defmodule CommerceFront.Settings do
  @moduledoc """
  The Settings context.
  """
  require Logger
  # import Mogrify
  import Ecto.Query, warn: false
  alias CommerceFront.Repo
  require IEx
  alias Ecto.Multi

  import CommerceFront.Calculation,
    only: [special_share_reward: 3, sharing_bonus: 4, team_bonus: 5, stockist_register_bonus: 4]

  alias CommerceFront.Settings.SessionUser

  def get_cookie_user_by_cookie(cookie) do
    Repo.all(
      from(s in SessionUser, where: s.cookie == ^cookie, preload: [user: [role: :app_routes]])
    )
    |> List.first()
  end

  def list_session_users() do
    Repo.all(SessionUser)
  end

  def get_session_user!(id) do
    Repo.get!(SessionUser, id)
  end

  def create_session_user(params \\ %{}) do
    SessionUser.changeset(%SessionUser{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_session_user(model, params) do
    SessionUser.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_session_user(%SessionUser{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.AppRoute

  def list_app_routes() do
    Repo.all(AppRoute)
  end

  def get_app_route!(id) do
    Repo.get!(AppRoute, id)
  end

  def create_app_route(params \\ %{}) do
    params = params |> Map.put("can_get", params["can_get"] == "on")
    params = params |> Map.put("can_post", params["can_post"] == "on")
    AppRoute.changeset(%AppRoute{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_app_route(model, params) do
    params = params |> Map.put("can_get", params["can_get"] == "on")
    params = params |> Map.put("can_post", params["can_post"] == "on")
    AppRoute.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_app_route(%AppRoute{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Role

  def list_roles() do
    Repo.all(Role)
  end

  def get_role!(id) do
    Repo.get!(Role, id)
  end

  def create_role(params \\ %{}) do
    Role.changeset(%Role{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_role(model, params) do
    Role.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_role(%Role{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.RoleAppRoute

  def list_role_app_routes() do
    Repo.all(RoleAppRoute)
  end

  def get_role_app_route!(id) do
    Repo.get!(RoleAppRoute, id)
  end

  def create_role_app_route(params \\ %{}) do
    sample = %{"AppRoute" => %{"1" => %{"1" => "on", "2" => "on"}}, "id" => "0"}

    role_id = Map.keys(params["AppRoute"]) |> List.first()

    items = params["AppRoute"][role_id] |> Map.keys()
    Repo.delete_all(from(rap in RoleAppRoute, where: rap.role_id == ^role_id))

    for item <- items do
      params = %{"role_id" => role_id, "app_route_id" => item}
      RoleAppRoute.changeset(%RoleAppRoute{}, params) |> Repo.insert() |> IO.inspect()
    end

    {:ok, %RoleAppRoute{id: 0}}
  end

  def update_role_app_route(model, params) do
    RoleAppRoute.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_role_app_route(%RoleAppRoute{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Staff

  def list_staffs() do
    Repo.all(Staff)
  end

  def get_staff!(id) do
    Repo.get!(Staff, id)
  end

  def create_staff(params \\ %{}) do
    Staff.changeset(%Staff{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_staff(model, attrs) do
    attrs =
      with true <- "password" in Map.keys(attrs),
           true <- attrs["password"] != "" do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        _ ->
          attrs
      end

    Staff.changeset(model, attrs) |> Repo.update() |> IO.inspect()
  end

  def delete_staff(%Staff{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.WithdrawalBatch

  def list_withdrawal_batches() do
    Repo.all(WithdrawalBatch)
  end

  def get_withdrawal_batch!(id) do
    Repo.get!(WithdrawalBatch, id)
  end

  def create_withdrawal_batch(params \\ %{}) do
    params = params |> Map.put("is_open", params["is_open"] == "on")
    WithdrawalBatch.changeset(%WithdrawalBatch{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_withdrawal_batch(model, params) do
    params = params |> Map.put("is_open", params["is_open"] == "on")
    WithdrawalBatch.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_withdrawal_batch(%WithdrawalBatch{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.WalletWithdrawal

  def list_wallet_withdrawals() do
    Repo.all(WalletWithdrawal)
  end

  def get_wallet_withdrawal!(id) do
    Repo.get!(WalletWithdrawal, id)
  end

  def create_wallet_withdrawal(params \\ %{}) do
    cg = WalletWithdrawal.changeset(%WalletWithdrawal{}, params)

    wallet =
      list_ewallets_by_user_id(params["user_id"])
      |> Enum.filter(&(&1.wallet_type == :bonus))
      |> List.first()

    cond do
      String.to_integer(params["amount"]) < 100 ->
        {:error, Ecto.Changeset.add_error(cg, :amount, "Cannot be less than 100")}

      String.to_integer(params["amount"]) > wallet.total ->
        {:error,
         Ecto.Changeset.add_error(
           cg,
           :amount,
           "Wallet insufficient, can withdraw: #{wallet.total}"
         )}

      true ->
        cg |> Repo.insert() |> IO.inspect()
    end
  end

  def update_wallet_withdrawal(model, params) do
    WalletWithdrawal.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_wallet_withdrawal_by_id(id) do
    Repo.delete(get_wallet_withdrawal!(id))
  end

  def delete_wallet_withdrawal(%WalletWithdrawal{} = model) do
    Repo.delete(model)
  end

  def approve_withdrawal_batch(id) do
    wb = get_withdrawal_batch!(id)

    if wb.paid_date == nil do
      withdrawals = Repo.all(from(ww in WalletWithdrawal, where: ww.withdrawal_batch_id == ^id))

      Multi.new()
      |> Multi.run(:approve_withdrawal, fn _repo, %{} ->
        res =
          for withdrawal <- withdrawals do
            update_wallet_withdrawal(withdrawal, %{is_paid: true})

            CommerceFront.Settings.create_wallet_transaction(%{
              user_id: withdrawal.user_id,
              amount: (withdrawal.amount * -0.97) |> Float.round(2),
              remarks:
                "withdrawal #{wb.code} to #{withdrawal.bank_name} #{withdrawal.bank_account_number}",
              wallet_type: "bonus"
            })

            CommerceFront.Settings.create_wallet_transaction(%{
              user_id: withdrawal.user_id,
              amount: (withdrawal.amount * -0.03) |> Float.round(2),
              remarks:
                "#{wb.code} processing fee #{withdrawal.amount} * 0.03 = #{withdrawal.amount * 0.03} ",
              wallet_type: "bonus"
            })
          end

        update_withdrawal_batch(wb, %{"paid_date" => Date.utc_today()})

        {:ok, nil}
      end)
      |> Repo.transaction()
      |> case do
        {:ok, multi_res} ->
          {:ok, multi_res |> Map.get(:approve_withdrawal)}

        _ ->
          {:error, []}
      end
    else
      {:error, "already paid"}
    end
  end

  alias CommerceFront.Settings.WalletTopup

  def list_wallet_topups() do
    Repo.all(WalletTopup)
  end

  def get_wallet_topup!(id) do
    Repo.get!(WalletTopup, id)
  end

  def create_wallet_topup(params \\ %{}) do
    Multi.new()
    |> Multi.run(:wallet_topup, fn _repo, %{} ->
      WalletTopup.changeset(%WalletTopup{}, params) |> Repo.insert() |> IO.inspect()
    end)
    |> Multi.run(:payment, fn _repo, %{wallet_topup: wallet_topup} ->
      if wallet_topup.payment_method == "fpx" do
        wallet_topup = wallet_topup |> Repo.preload(:user)
        res = Billplz.create_collection("Topup Order: #{wallet_topup.id}")
        collection_id = Map.get(res, "id")

        bill_res =
          Billplz.create_bill(collection_id, %{
            description: "Topup Order: #{wallet_topup.id}",
            email: wallet_topup.user.email,
            name: wallet_topup.user.fullname,
            amount: wallet_topup.amount * 5,
            phone: wallet_topup.user.phone
          })

        create_payment(%{
          payment_method: "fpx",
          amount: wallet_topup.amount,
          wallet_topup_id: wallet_topup.id,
          billplz_code: Map.get(bill_res, "id"),
          payment_url: Map.get(bill_res, "url")
        })
      else
        create_payment(%{
          payment_method: wallet_topup.payment_method,
          amount: wallet_topup.amount,
          wallet_topup_id: wallet_topup.id
        })
      end
    end)
    |> Repo.transaction()
    |> case do
      {:ok, multi_res} ->
        {:ok, multi_res |> Map.get(:wallet_topup)}

      _ ->
        {:error, []}
    end
  end

  def update_wallet_topup(model, params) do
    params = params |> Map.put("is_approved", params["is_approved"] == "on")

    WalletTopup.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_wallet_topup(%WalletTopup{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Payment

  def list_payments() do
    Repo.all(Payment)
  end

  def get_payment_by_billplz_code(code) do
    Repo.get_by(Payment, billplz_code: code) |> Repo.preload([:sales, :wallet_topup])
  end

  def get_payment!(id) do
    Repo.get!(Payment, id)
  end

  def create_payment(params \\ %{}) do
    Payment.changeset(%Payment{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_payment(model, params) do
    Payment.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_payment(%Payment{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.PaymentChannel

  def list_payment_channels() do
    Repo.all(PaymentChannel)
  end

  def get_payment_channel_by_code(code) do
    Repo.get_by(PaymentChannel, code: code)
  end

  def get_payment_channel!(id) do
    Repo.get!(PaymentChannel, id)
  end

  def create_payment_channel(params \\ %{}) do
    sample = %{"active" => true, "category" => "razerpay", "code" => "BP-RZRMB2QR"}

    check = get_payment_channel_by_code(params["code"])

    if check == nil do
      PaymentChannel.changeset(%PaymentChannel{}, params) |> Repo.insert()
    else
      PaymentChannel.changeset(check, params) |> Repo.update()
    end
    |> IO.inspect()
  end

  def update_payment_channel(model, params) do
    PaymentChannel.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_payment_channel(%PaymentChannel{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.WalletType

  def list_wallet_types() do
    Repo.all(WalletType)
  end

  def get_wallet_type!(id) do
    Repo.get!(WalletType, id)
  end

  def create_wallet_type(params \\ %{}) do
    WalletType.changeset(%WalletType{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_wallet_type(model, params) do
    WalletType.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_wallet_type(%WalletType{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.EwalletTransfer

  def list_ewallet_transfers() do
    Repo.all(EwalletTransfer)
  end

  def get_ewallet_transfer!(id) do
    Repo.get!(EwalletTransfer, id)
  end

  def create_ewallet_transfer(params \\ %{}) do
    IO.inspect(params)

    from_username =
      Map.get(params, "from_username") |> CommerceFront.Settings.get_user_by_username()

    to_username = Map.get(params, "to_username") |> CommerceFront.Settings.get_user_by_username()

    with true <- from_username != nil,
         true <- to_username != nil do
      params =
        Map.merge(params, %{
          "from_user_id" => from_username.id,
          "to_user_id" => to_username.id
        })
        |> IO.inspect()

      EwalletTransfer.changeset(%EwalletTransfer{}, params) |> Repo.insert() |> IO.inspect()
    else
      _ ->
        nil
    end
  end

  def update_ewallet_transfer(model, params) do
    EwalletTransfer.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_ewallet_transfer(%EwalletTransfer{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Announcement

  def list_announcements() do
    Repo.all(Announcement)
  end

  def get_announcement!(id) do
    Repo.get!(Announcement, id)
  end

  def create_announcement(params \\ %{}) do
    Announcement.changeset(%Announcement{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_announcement(model, params) do
    Announcement.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_announcement(%Announcement{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Reward

  def list_rewards() do
    Repo.all(from(r in Reward, preload: :user))
  end

  def get_reward!(id) do
    Repo.get!(Reward, id)
  end

  def create_reward(params \\ %{}) do
    Reward.changeset(%Reward{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_reward(model, params) do
    Reward.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_reward(%Reward{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.WalletTransaction

  def list_wallet_transactions() do
    Repo.all(WalletTransaction)
  end

  def get_wallet_transaction!(id) do
    Repo.get!(WalletTransaction, id)
  end

  def update_wallet_transaction(model, params) do
    WalletTransaction.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_wallet_transaction(%WalletTransaction{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Ewallet

  def get_latest_wallet_transaction_by_user_id(user_id, wallet_type) do
    Repo.all(
      from(wt in WalletTransaction,
        left_join: ew in Ewallet,
        on: ew.id == wt.ewallet_id,
        where: wt.user_id == ^user_id and ew.wallet_type == ^wallet_type,
        order_by: [desc: wt.id],
        preload: [:ewallet]
      )
    )
    |> List.first()
  end

  def list_ewallets_by_user_id(id) do
    Repo.all(from(e in Ewallet, where: e.user_id == ^id))
  end

  def list_ewallets() do
    Repo.all(Ewallet)
  end

  def get_ewallet!(id) do
    Repo.get!(Ewallet, id)
  end

  def create_ewallet(params \\ %{}) do
    params |> IO.inspect()

    Multi.new()
    |> Multi.run(:ewallet, fn _repo, %{} ->
      Ewallet.changeset(%Ewallet{}, params) |> Repo.insert()
    end)
    |> Multi.run(:wallet_transaction, fn _repo, %{ewallet: ewallet} ->
      WalletTransaction.changeset(%WalletTransaction{}, %{
        ewallet_id: ewallet.id,
        user_id: ewallet.user_id,
        before: 0.00,
        amount: 0.00,
        after: 0.00,
        remarks: "initial"
      })
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> IO.inspect()
    |> case do
      {:ok, multi_res} ->
        {:ok, multi_res}

      _ ->
        {:error, []}
    end
  end

  @doc """

  this transaction need to have 

  CommerceFront.Settings.create_wallet_transaction(  %{user_id: CommerceFront.Settings.finance_user.id, amount: 1.00, remarks: "something", wallet_type: "reserve" })

  CommerceFront.Settings.create_wallet_transaction(  %{user_id: 609, amount: 1100.00, remarks: "something", wallet_type: "direct_recruitment" })
  CommerceFront.Settings.create_wallet_transaction(  %{user_id: 609, amount: 1100.00, remarks: "something", wallet_type: "register" })

  %{
    user_id: 1,
    amount: 100.00,

    remarks: "something",
    wallet_type: "bonus"
  }
  it will first find the wallet transaction first, if nid, need to create
  """
  def create_wallet_transaction(params \\ %{}) do
    Multi.new()
    |> Multi.run(:ewallet_n_transaction, fn _repo, %{} ->
      check = get_latest_wallet_transaction_by_user_id(params.user_id, params.wallet_type)

      if check == nil do
        create_ewallet(params |> Map.put(:total, 0.00))
      else
        {:ok, %{wallet_transaction: check, ewallet: check.ewallet}}
      end
      |> IO.inspect()
    end)
    |> Multi.run(:wallet_transaction, fn _repo, %{ewallet_n_transaction: ewallet} ->
      WalletTransaction.changeset(
        %WalletTransaction{},
        params
        |> Map.merge(%{
          before: ewallet.wallet_transaction.after,
          after: ewallet.wallet_transaction.after + params.amount,
          ewallet_id: ewallet.ewallet.id
        })
        |> IO.inspect()
      )
      |> Repo.insert()
    end)
    |> Multi.run(:ewallet, fn _repo,
                              %{
                                ewallet_n_transaction: ewallet,
                                wallet_transaction: wallet_transaction
                              } ->
      Ewallet.changeset(ewallet.ewallet, %{total: wallet_transaction.after}) |> Repo.update()
    end)
    |> Repo.transaction()
    |> IO.inspect()
    |> case do
      {:ok, multi_res} ->
        # {:ok, multi_res |> Map.get(:ewallet)}
        {:ok, multi_res}

      _ ->
        {:error, []}
    end
  end

  def update_ewallet(model, params) do
    Ewallet.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_ewallet(%Ewallet{} = model) do
    Repo.delete(model)
  end

  def reset_all_ewallet() do
    Repo.delete_all(WalletTransaction)
    Repo.delete_all(from(e in Ewallet))
  end

  alias CommerceFront.Settings.GroupSalesSummary

  def list_group_sales_summaries() do
    Repo.all(GroupSalesSummary)
  end

  def get_group_sales_summary!(id) do
    Repo.get!(GroupSalesSummary, id)
  end

  def get_latest_gs_summary_by_user_id(user_id, back_date \\ nil) do
    {y, m, d} =
      if back_date != nil do
        back_date
      else
        Date.utc_today()
      end
      |> Date.to_erl()

    subquery2 =
      from(gss in GroupSalesSummary,
        where:
          gss.month == ^m and
            gss.year == ^y and gss.user_id == ^user_id,
        select: %{
          sum_left: sum(gss.new_left),
          sum_right: sum(gss.new_right),
          user_id: gss.user_id
        },
        order_by: [asc: gss.user_id],
        group_by: [gss.user_id, gss.month, gss.year]
      )

    Repo.all(subquery2) |> IO.inspect()

    Repo.all(
      from(gss in GroupSalesSummary,
        full_join: gs2 in subquery(subquery2),
        on: gs2.user_id == gss.user_id,
        where:
          gss.user_id == ^user_id and
            gss.day == ^d and gss.month == ^m and
            gss.year == ^y,
        select: gss,
        select_merge: %{sum_left: gs2.sum_left, sum_right: gs2.sum_right}
      )
    )
    |> List.first()
  end

  def create_group_sales_summary(params \\ %{}) do
    GroupSalesSummary.changeset(%GroupSalesSummary{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_group_sales_summary(model, params) do
    GroupSalesSummary.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_group_sales_summary(%GroupSalesSummary{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.PlacementGroupSalesDetail

  def list_placement_group_sales_details() do
    Repo.all(PlacementGroupSalesDetail)
  end

  def get_placement_group_sales_detail!(id) do
    Repo.get!(PlacementGroupSalesDetail, id)
  end

  def create_placement_group_sales_detail(params \\ %{}, back_date \\ nil) do
    Multi.new()
    |> Multi.run(:gsd, fn _repo, %{} ->
      PlacementGroupSalesDetail.changeset(%PlacementGroupSalesDetail{}, params)
      |> Repo.insert()
    end)
    |> Multi.run(:gs_summary, fn _repo, %{gsd: gsd} ->
      check = get_latest_gs_summary_by_user_id(gsd.to_user_id, back_date)

      if gsd.to_user_id == 584 do
        r =
          CommerceFront.Repo.all(
            from(gss in CommerceFront.Settings.GroupSalesSummary, where: gss.user_id == ^584)
          )

        # IEx.pry()
      end

      case check do
        nil ->
          map =
            if gsd.position == "left" do
              %{new_left: gsd.amount, total_left: gsd.amount, total_right: 0}
            else
              %{
                total_left: 0,
                new_right: gsd.amount,
                total_right: gsd.amount
              }
            end

          {y, m, d} =
            if back_date != nil do
              back_date |> Date.to_erl()
            else
              Date.utc_today() |> Date.to_erl()
            end

          create_group_sales_summary(
            %{
              total_left: 0,
              total_right: 0,
              user_id: gsd.to_user_id,
              day: d,
              month: m,
              year: y
            }
            |> Map.merge(map)
          )

        _ ->
          map =
            if gsd.position == "left" do
              %{
                new_left: check.new_left + gsd.amount,
                total_left: check.total_left + gsd.amount,
                balance_left: check.total_left + gsd.amount
              }
            else
              %{
                new_right: check.new_right + gsd.amount,
                total_right: check.total_right + gsd.amount,
                balance_right: check.total_right + gsd.amount
              }
            end

          {y, m, d} =
            if back_date != nil do
              back_date |> Date.to_erl()
            else
              Date.utc_today() |> Date.to_erl()
            end

          update_group_sales_summary(
            check,
            %{
              user_id: gsd.to_user_id,
              day: d,
              month: m,
              year: y
            }
            |> Map.merge(map)
          )
      end
    end)
    |> Multi.run(:gsd2, fn _repo, %{gsd: gsd, gs_summary: gs_summary} ->
      PlacementGroupSalesDetail.changeset(gsd, %{gs_summary_id: gs_summary.id})
      |> Repo.update()
    end)
    |> Repo.transaction()
    |> IO.inspect()
    |> case do
      {:ok, multi_res} ->
        gs_summary = multi_res |> Map.get(:gs_summary)
        {:ok, multi_res |> Map.get(:gsd) |> Map.put(:gs_summary, gs_summary)}

      _ ->
        {:error, []}
    end
  end

  def update_placement_group_sales_detail(model, params) do
    PlacementGroupSalesDetail.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_placement_group_sales_detail(%PlacementGroupSalesDetail{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.SalesItem

  def list_sales_items() do
    Repo.all(SalesItem)
  end

  def get_sales_item!(id) do
    Repo.get!(SalesItem, id)
  end

  def create_sales_item(params \\ %{}) do
    SalesItem.changeset(%SalesItem{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_sales_item(model, params) do
    SalesItem.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_sales_item(%SalesItem{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Sale

  def list_sales() do
    Repo.all(Sale)
  end

  def get_sale!(id) do
    Repo.get!(Sale, id) |> Repo.preload([:payment, :sales_person, :user, :sales_items])
  end

  def create_sale(params \\ %{}) do
    Sale.changeset(%Sale{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_sale(model, params) do
    Sale.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_sale(%Sale{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Product

  def list_products() do
    Repo.all(Product)
  end

  def get_product_by_name(name) do
    Repo.all(from(p in Product, where: p.name == ^name)) |> List.first()
  end

  def get_product!(id) do
    Repo.get!(Product, id)
  end

  def create_product(params \\ %{}) do
    Product.changeset(%Product{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_product(model, params) do
    Product.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_product(%Product{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Rank

  def list_ranks() do
    Repo.all(Rank)
  end

  def get_rank!(id) do
    Repo.get!(Rank, id)
  end

  def create_rank(params \\ %{}) do
    Rank.changeset(%Rank{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_rank(model, params) do
    Rank.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_rank(%Rank{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.User

  def member_token(id) do
    Phoenix.Token.sign(
      CommerceFrontWeb.Endpoint,
      "member_signature",
      %{id: id}
    )
  end

  def decode_admin_token(token) do
    case Phoenix.Token.verify(CommerceFrontWeb.Endpoint, "admin_signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  def decode_token(token) do
    case Phoenix.Token.verify(CommerceFrontWeb.Endpoint, "member_signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  def auth_user(params) do
    user =
      Repo.all(from(u in User, where: u.username == ^params["username"], preload: :rank))
      |> List.first()

    with true <- user != nil,
         crypted_password <-
           :crypto.hash(:sha512, params["password"]) |> Base.encode16() |> String.downcase(),
         true <- crypted_password == user.crypted_password do
      {:ok, user}
    else
      _ ->
        {:error}
    end
  end

  def list_users() do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create_user(attrs \\ %{}) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    User.changeset(%User{}, attrs) |> Repo.insert() |> IO.inspect()
  end

  def update_user(model, attrs) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    attrs =
      if "is_stockist" in Map.keys(attrs) do
        attrs |> Map.put("is_stockist", attrs["is_stockist"] == "on")
      else
        attrs
      end

    cg = User.changeset(model, attrs) |> Repo.update() |> IO.inspect()

    case cg do
      {:ok, u} ->
        u = u |> Repo.preload(:rank) |> Map.put(:token, CommerceFront.Settings.member_token(u.id))
        {:ok, u}

      {:error, cg} ->
        {:error, cg}
    end
  end

  def delete_user(%User{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Referral

  def list_referrals() do
    Repo.all(Referral)
  end

  def get_referral_by_username(username) do
    if username == "admin" do
      %{id: 0, user_id: 0}
    else
      res = Repo.all(from(u in User, where: u.username == ^username)) |> List.first()

      if res != nil do
        Repo.get_by(Referral, user_id: res.id)
      end
    end
  end

  def get_referral!(id) do
    Repo.get!(Referral, id)
  end

  def create_referral(params \\ %{}) do
    Referral.changeset(%Referral{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_referral(model, params) do
    Referral.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_referral(%Referral{} = model) do
    Repo.delete(model)
  end

  alias CommerceFront.Settings.Placement

  def list_placements() do
    Repo.all(Placement)
  end

  def get_placement_by_username(username) do
    if username == "admin" do
      %{id: 0, user_id: 0}
    else
      res = Repo.all(from(u in User, where: u.username == ^username)) |> List.first()

      if res != nil do
        gs_summary = get_latest_gs_summary_by_user_id(res.id) |> BluePotion.sanitize_struct()

        gs_summary =
          if gs_summary != nil do
            gs_summary
          else
            %{
              total_left: 0,
              total_right: 0,
              balance_left: 0,
              balance_right: 0,
              new_left: 0,
              new_right: 0,
              sum_left: 0,
              sum_right: 0
            }
          end

        Repo.get_by(Placement, user_id: res.id)
        |> IO.inspect()
        |> Repo.preload(:user)
        |> BluePotion.sanitize_struct()
        |> Map.merge(%{
          total_left: gs_summary.total_left,
          total_right: gs_summary.total_right,
          balance_left: gs_summary.balance_left,
          balance_right: gs_summary.balance_right,
          new_left: gs_summary.new_left,
          new_right: gs_summary.new_right,
          sum_left: gs_summary.sum_left,
          sum_right: gs_summary.sum_right
        })
      end
    end
  end

  def get_placement!(id) do
    Repo.get!(Placement, id)
  end

  def create_placement(params \\ %{}) do
    Placement.changeset(%Placement{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_placement(model, params) do
    Placement.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_placement(%Placement{} = model) do
    Repo.delete(model)
  end

  def display_refer_tree(username) do
    list = check_downlines(username, :referral)
    display_tree(username, list, [], :referral, false, 0)
  end

  def display_place_tree(username, full \\ false) do
    list = check_downlines(username)

    tree = display_tree(username, list, [], :placement, false, 0, full)

    if tree != nil do
      [fl_child, far_left_data] = far_node("left", username, %{})

      [fr_child, far_right_data] = far_node("right", username, %{})

      map = %{
        far_left: far_left_data,
        far_left_child: fl_child,
        far_right: far_right_data,
        far_right_child: fr_child
      }

      tree
      |> Map.merge(map)
    end

    # tree
  end

  def far_node(position, username, tree \\ %{}, parent_username \\ nil) do
    IO.inspect("far #{username}")

    if username |> String.contains?("~") do
      [parent_username, parent_username]
    else
      list = check_downlines(username)

      tree =
        if tree == %{} do
          display_tree(username, list, [], :placement, false, 0, true)
        else
          tree
        end

      children = tree |> Map.get(:children)

      if :position in (Enum.map(children, &Map.keys(&1)) |> List.flatten() |> Enum.uniq()) do
        new_tree = children |> Enum.filter(&(&1.position == position)) |> List.first()

        if new_tree != nil do
          parent_username =
            if List.first(list) == nil do
              "~空"
            else
              List.first(list) |> Map.get(:parent_username)
            end

          far_node(
            position,
            new_tree |> Map.get(:name),
            new_tree,
            parent_username
          )
        else
          parent_username =
            if List.first(list) == nil do
              "~空"
            else
              List.first(list) |> Map.get(:parent_username)
            end

          [
            parent_username,
            parent_username
          ]
        end
      else
        [username, parent_username]
      end
    end
  end

  def find_weak_placement(tree, use_one_direction, first_node, prev_node \\ nil) do
    IO.inspect("from tree")
    IO.inspect(tree)

    if tree == nil do
      if first_node.left > first_node.right do
        # need to add to left + 1 

        left = prev_node.left

        prev_node |> Map.put(:left, left + 1)
      else
        right = prev_node.right

        prev_node |> Map.put(:right, right + 1)
      end
    else
      items = tree |> Map.get(:children) |> Enum.reject(&(&1.id == 0))

      if use_one_direction do
        node =
          if first_node.left > first_node.right do
            items |> Enum.filter(&(&1.position == "right")) |> List.first()
          else
            items |> Enum.filter(&(&1.position == "left")) |> List.first()
          end

        find_weak_placement(node, use_one_direction, first_node, tree)
      else
        left = items |> Enum.filter(&(&1.position == "left")) |> List.first()

        right = items |> Enum.filter(&(&1.position == "right")) |> List.first()

        if tree.left > tree.right do
          find_weak_placement(right, use_one_direction, first_node, tree)
        else
          find_weak_placement(left, use_one_direction, first_node, tree)
        end
      end
    end
  end

  @doc """

  list = CommerceFront.Settings.check_downlines("elis", true)
      tree = CommerceFront.Settings.display_tree("elis", list, [], :placement, false, 0, full)
  """
  def display_tree(
        username \\ "damien",
        ori_data,
        transformed_children \\ [],
        tree \\ :placement,
        include_empty \\ true,
        count,
        full \\ false
      ) do
    Logger.info("[display tree] - Count: #{count} - #{username}")

    to_map = fn list ->
      if tree == :placement do
        [
          username,
          id,
          fullname,
          position,
          left,
          right,
          total_left,
          total_right,
          balance_left,
          balance_right,
          new_left,
          new_right,
          sum_left,
          sum_right
        ] = list |> String.split("|")

        zchildren =
          if include_empty do
            [%{id: 0, name: "~"}, %{id: 0, name: "~"}]
          else
            [%{id: 0, name: "~空"}]
          end

        map = %{
          left: left |> String.to_integer(),
          right: right |> String.to_integer(),
          name: username,
          children: zchildren,
          username: username,
          id: id |> String.to_integer(),
          fullname: fullname,
          position: position
        }

        if full do
          map
        else
          map = %{
            left: left |> String.to_integer(),
            right: right |> String.to_integer(),
            total_left: total_left || 0,
            total_right: total_right || 0,
            balance_left: balance_left || 0,
            balance_right: balance_right || 0,
            sum_left: sum_left || 0,
            sum_right: sum_right || 0,
            new_left: new_left || 0,
            new_right: new_right || 0,
            name: username,
            fullname: fullname,
            children: zchildren,
            username: username,
            id: id |> String.to_integer(),
            fullname: fullname,
            position: position
          }

          map
          |> Map.put(
            :value,
            %{
              level: count,
              username: username,
              fullname: fullname,
              left: left |> String.to_integer(),
              right: right |> String.to_integer(),
              total_left: total_left || 0,
              total_right: total_right || 0,
              balance_left: balance_left || 0,
              balance_right: balance_right || 0,
              sum_left: sum_left || 0,
              sum_right: sum_right || 0,
              new_left: new_left || 0,
              new_right: new_right || 0,
              position: position
            }
            |> Jason.encode!()
          )
        end
      else
        [username, id, fullname, rank_name] = list |> String.split("|")

        zchildren =
          if include_empty do
            []
          else
            []
          end

        bg =
          case rank_name do
            "金级套餐" ->
              "bg-warning"

            "银级套餐" ->
              "bg-info"

            _ ->
              "bg-primary"
          end

        %{
          icon: "fa fa-user text-info",
          name: username <> " #{id}",
          text: """
          <span class='my-2'>
            <span class='p-1 my-2 left-box'>#{username}</span>
            <span class='m-0 px-1 ' style="width: 40%; position: absolute;right: 0px;">id: #{id} | <span class="badge #{bg}"> #{rank_name}</span></span>
          </span>
          """,
          children: zchildren,
          username: username,
          id: id |> String.to_integer(),
          fullname: fullname
        }
      end
    end

    transformed_children =
      ori_data
      |> Enum.map(&(&1 |> Map.get(:children)))
      |> List.flatten()
      |> Enum.uniq()
      |> Enum.map(&(&1 |> to_map.()))

    # initial data
    map = ori_data |> Enum.filter(&(&1.parent_username == username)) |> List.first()

    # this transform will recursively call
    transform = fn list, ori_data ->
      if tree == :placement do
        [
          username,
          id,
          fullname,
          position,
          left,
          right,
          total_left,
          total_right,
          balance_left,
          balance_right,
          new_left,
          new_right,
          sum_left,
          sum_right
        ] = list

        display_tree(
          username,
          ori_data,
          transformed_children |> Enum.uniq(),
          tree,
          include_empty,
          count + 1,
          full
        )
      else
        [username, id, fullname, rank_name] = list

        # map = ori_data |> Enum.filter(&(&1.parent_username == username)) |> List.first()

        display_tree(
          username,
          ori_data,
          transformed_children,
          :referral,
          include_empty,
          count + 1,
          full
        )
      end
    end

    # this children is where all the branching start...
    children =
      if map != nil do
        if full do
          if Enum.count(map.children) < 2 do
            l =
              map.children
              |> Enum.uniq()
              |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))

            if tree == :placement do
              l ++ [%{id: 0, name: "~空", position: "left"}]
            else
              l
            end
          else
            if tree == :placement do
              map.children
              |> Enum.uniq()
              |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))
            else
              map.children
              |> Enum.uniq()
              |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))
            end
          end
        else
          if Enum.count(map.children) < 2 && count < 2 do
            l =
              map.children
              |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))

            if tree == :placement do
              l ++ [%{id: 0, name: "~空", position: "left"}]
            else
              l
            end
          else
            if tree == :placement do
              if count < 2 do
                map.children |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))
              else
                [
                  %{id: 0, name: "~ More", position: "left"}
                ]
              end
            else
              map.children |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))
            end
          end
        end
      else
        if tree == :placement do
          [
            %{id: 0, name: "~空", position: "right"}
          ]
        else
          []
        end
      end

    if map == nil do
      transformed_children
      |> Enum.filter(&(&1.username == username))
      |> Enum.uniq()
      |> List.first()

      # transformed_children   |> Enum.filter(&(&1.username == username))     |> Enum.uniq()    |> List.first()
    else
      smap =
        transformed_children
        |> Enum.filter(&(&1.username == username))
        |> Enum.uniq()
        |> List.first()

      if tree == :placement do
        smap =
          if smap == nil do
            get_placement_by_username(map.parent_username)
          else
            smap
          end

        inner_map = %{
          id: map.parent_id,
          name: map.parent_username,
          position: if(smap != nil, do: smap.position, else: "n/a"),
          left: if(smap != nil, do: smap.left, else: "n/a"),
          right: if(smap != nil, do: smap.right, else: "n/a"),
          children: children |> Enum.sort_by(& &1.position)
        }

        if full do
          inner_map
        else
          rank_name =
            if :fullname in Map.keys(smap) do
              smap.fullname
            else
              # IEx.pry()
              smap.user.rank_name
            end

          inner_map = %{
            id: map.parent_id,
            name: map.parent_username,
            fullname: if(smap != nil, do: rank_name, else: "n/a"),
            position: if(smap != nil, do: smap.position, else: "n/a"),
            left: if(smap != nil, do: smap.left, else: "n/a"),
            right: if(smap != nil, do: smap.right, else: "n/a"),
            total_left: if(smap != nil, do: smap.total_left, else: "n/a"),
            total_right: if(smap != nil, do: smap.total_right, else: "n/a"),
            new_left: if(smap != nil, do: smap.new_left, else: "n/a"),
            new_right: if(smap != nil, do: smap.new_right, else: "n/a"),
            balance_left: if(smap != nil, do: smap.balance_left, else: "n/a"),
            balance_right: if(smap != nil, do: smap.balance_right, else: "n/a"),
            sum_left: if(smap != nil, do: smap.sum_left, else: "n/a"),
            sum_right: if(smap != nil, do: smap.sum_right, else: "n/a"),
            children: children |> Enum.sort_by(& &1.position)
          }

          inner_map
          |> Map.put(
            :value,
            %{
              level: count,
              username: map.parent_username,
              fullname: if(smap != nil, do: rank_name, else: "n/a"),
              position: if(smap != nil, do: smap.position, else: "n/a"),
              left: if(smap != nil, do: smap.left, else: "n/a"),
              right: if(smap != nil, do: smap.right, else: "n/a"),
              total_left: if(smap != nil, do: smap.total_left, else: "n/a"),
              total_right: if(smap != nil, do: smap.total_right, else: "n/a"),
              balance_left: if(smap != nil, do: smap.balance_left, else: "n/a"),
              balance_right: if(smap != nil, do: smap.balance_right, else: "n/a"),
              sum_left: if(smap != nil, do: smap.sum_left, else: "n/a"),
              sum_right: if(smap != nil, do: smap.sum_right, else: "n/a"),
              new_left: if(smap != nil, do: smap.new_left, else: "n/a"),
              new_right: if(smap != nil, do: smap.new_right, else: "n/a")
            }
            |> Jason.encode!()
          )
        end
      else
        smap =
          if smap == nil do
            get_referral_by_username(map.parent_username)
          else
            smap
          end

        bg =
          case map.rank_name do
            "金级套餐" ->
              "bg-warning"

            "银级套餐" ->
              "bg-info"

            _ ->
              "bg-primary"
          end

        %{
          icon: "fa fa-user text-success",
          text: """
          <span class='my-2'>
            <span class='p-1 my-2 left-box'>#{username}</span>
            <span class='m-0 px-1 ' style="width: 40%;position: absolute;right: 0px;">id: #{map.parent_id} | <span class="badge #{bg}"> #{map.rank_name}</span></span>
          </span>
          """,
          id: map.parent_id,
          rank_name: map.rank_name,
          name: map.parent_username <> " #{if(smap != nil, do: smap.id, else: "n/a")}",
          children: children |> Enum.sort_by(& &1.id)
        }
      end
    end
  end

  def placement_counter_reset() do
    Repo.update_all(Placement, set: [left: 0, right: 0])

    items = Repo.all(from(p in Placement, order_by: [desc: p.id], preload: [:user]))

    for item <- items do
      Logger.info("[check upline] - #{item.user.username}")
      uplines = CommerceFront.Settings.check_uplines(item.user.username) |> IO.inspect()

      for upline <- uplines do
        p = CommerceFront.Settings.get_placement!(upline.pt_parent_id) |> Repo.preload(:user)
        c = CommerceFront.Settings.get_placement!(upline.pt_child_id) |> Repo.preload(:user)

        changes =
          if upline.pt_position == "left" do
            %{
              left: p.left + 1,
              right: p.right
            }
          else
            %{
              left: p.left,
              right: p.right + 1
            }
          end

        CommerceFront.Settings.Placement.changeset(p, changes) |> Repo.update()
      end
    end
  end

  def latest_group_sales_details(username, position, back_date \\ nil) do
    Repo.all(
      from(pgsd in PlacementGroupSalesDetail,
        left_join: u in User,
        on: pgsd.to_user_id == u.id,
        where: u.username == ^username and pgsd.position == ^position,
        order_by: [desc: pgsd.id]
      )
    )
    |> List.first()
  end

  def contribute_group_sales(
        from_username,
        amount,
        sales,
        placement,
        prev_multi \\ nil,
        back_date \\ nil
      ) do
    from_user = get_user_by_username(from_username)

    add_gs = fn upline, multi_query ->
      multi_query
      |> Multi.run(String.to_atom("parent_#{upline.parent}"), fn _repo, %{} ->
        latest = latest_group_sales_details(upline.parent, upline.pt_position)
        # position has to be the first upline's position 

        case latest do
          nil ->
            create_placement_group_sales_detail(
              %{
                before: 0,
                after: amount,
                amount: amount,
                from_user_id: from_user.id,
                to_user_id: upline.parent_id,
                position: upline.pt_position,
                sales_id: sales.id,
                remarks: "from sales-#{sales.id}"
              },
              back_date
            )

          _ ->
            create_placement_group_sales_detail(
              %{
                before: latest.after,
                after: latest.after + amount,
                amount: amount,
                from_user_id: from_user.id,
                to_user_id: upline.parent_id,
                position: upline.pt_position,
                sales_id: sales.id,
                remarks: "from sales-#{sales.id}"
              },
              back_date
            )
        end

        # find the latest group sales details
        # create group sales details
      end)
    end

    uplines = check_uplines(from_username)

    if prev_multi != nil do
      multi = prev_multi
      Enum.reduce(uplines, multi, &add_gs.(&1, &2))
    else
      multi = Multi.new()

      Enum.reduce(uplines, multi, &add_gs.(&1, &2))
      |> Repo.transaction()
    end
  end

  @doc """
  from this sponsor_username, 
  the placement itself have a left right counter,
  depending on the position that has a lowest number, 
  dive deep down to the lowest , use that placement
  after placing it, need to get the upline and update the counter 
  """

  def determine_position(sponsor_username, use_tree \\ true) do
    if sponsor_username != "admin" do
      if use_tree do
        tree = CommerceFront.Settings.display_place_tree(sponsor_username, true)

        Logger.info("[determine_position] - ...")

        if tree != nil do
          card = CommerceFront.Settings.find_weak_placement(tree, true, tree)

          position =
            cond do
              card.left == card.right ->
                "left"

              card.left > card.right ->
                "right"

              card.right > card.left ->
                "left"
            end

          p = Repo.get_by(Placement, user_id: card.id) |> Repo.preload(:user)

          {position, p}
        else
          {"left", get_placement_by_username(sponsor_username)}
        end
      else
        placement = get_placement_by_username(sponsor_username)

        position =
          if placement.left > placement.right do
            "right"
          else
            "left"
          end

        {position, placement}
      end
    else
      {"left", get_placement_by_username(sponsor_username)}
    end
  end

  def today_bonus(bonus_name, date \\ Date.utc_today()) do
    {y, m, d} =
      date
      |> Date.to_erl()

    datetime = NaiveDateTime.from_erl!({{y, m, d}, {0, 0, 0}})
    end_datetime = datetime |> Timex.shift(days: 1)
    # check today's team bonus reward
    # check today's sales
    sales =
      Repo.all(
        from(r in CommerceFront.Settings.Reward,
          where: r.day == ^d and r.month == ^m and r.year == ^y and r.name == ^bonus_name,
          group_by: [r.name],
          select: %{sum: sum(r.amount), name: r.name}
        )
      )
  end

  def today_sales(date \\ Date.utc_today()) do
    {y, m, d} =
      date
      |> Date.to_erl()

    datetime = NaiveDateTime.from_erl!({{y, m, d}, {0, 0, 0}})
    end_datetime = datetime |> Timex.shift(days: 1)
    # check today's team bonus reward
    # check today's sales
    sales =
      Repo.all(
        from(s in CommerceFront.Settings.Sale,
          where:
            s.inserted_at > ^datetime and s.inserted_at < ^end_datetime and
              s.status != ^:pending_payment,
          select: %{total_pv: sum(s.total_point_value), sum: sum(s.subtotal), date: s.sale_date},
          group_by: [s.sale_date]
        )
      )
  end

  def this_month_sales(date \\ Date.utc_today()) do
    {y, m, d} =
      date
      |> Date.to_erl()

    datetime = NaiveDateTime.from_erl!({{y, m, 1}, {0, 0, 0}})
    end_datetime = datetime |> Timex.shift(months: 1)
    # check today's team bonus reward
    # check today's sales
    sales =
      Repo.all(
        from(s in CommerceFront.Settings.Sale,
          where:
            s.inserted_at > ^datetime and s.inserted_at < ^end_datetime and
              s.status != ^:pending_payment,
          select: %{total_pv: sum(s.total_point_value), sum: sum(s.subtotal), date: s.sale_date},
          group_by: [s.sale_date]
        )
      )
  end

  @doc """
  when the placement group sales details is in place, based on the inserted at date to reconstruct the group sales sumary
  """
  def reconstruct_daily_group_sales_summary(date \\ Date.utc_today()) do
    {y, m, d} =
      date
      |> Date.to_erl()

    datetime = NaiveDateTime.from_erl!({{y, m, d}, {0, 0, 0}})
    end_datetime = datetime |> Timex.shift(days: 1)

    Multi.new()
    |> Multi.run(:delete_initial_entries, fn _repo, %{} ->
      if date == ~D[2023-11-07] do
        Repo.delete_all(GroupSalesSummary)
        Repo.delete_all(PlacementGroupSalesDetail)

        Repo.delete_all(
          from(r in Reward,
            where: r.name == "team bonus"
          )
        )
      end

      {:ok, nil}
    end)
    |> Multi.run(:delete_remaining_entries, fn _repo, %{} ->
      ids =
        Repo.all(
          from(gss in GroupSalesSummary,
            where:
              gss.day == ^d and gss.month == ^m and
                gss.year == ^y,
            select: gss.id
          )
        )

      q2 =
        from(pgsd in PlacementGroupSalesDetail)
        |> where(
          [pgsd],
          not ilike(pgsd.remarks, "bring forward%") and pgsd.gs_summary_id in ^ids
        )

      # need to exlude those carry forward and bring forward..

      # Repo.delete_all(
      #   from(gss in GroupSalesSummary,
      #     where:
      #       gss.day == ^d and gss.month == ^m and
      #         gss.year == ^y
      #   )
      # )

      Repo.delete_all(q2)

      {:ok, nil}
    end)
    |> Multi.run(:sales, fn _repo, %{} ->
      sales =
        Repo.all(
          from(s in CommerceFront.Settings.Sale,
            where: s.inserted_at > ^datetime and s.inserted_at < ^end_datetime,
            preload: :user,
            order_by: [asc: s.id]
          )
        )

      for sale <- sales do
        if sale.user != nil do
          {:ok, pgsd} =
            contribute_group_sales(
              sale.user.username,
              sale.total_point_value,
              sale,
              nil,
              nil,
              date
            )
        end
      end

      # team_bonus(sale.user.username, sale.total_point_value, sale, nil, pgsd)

      {:ok, nil}
    end)
    |> Repo.transaction()
  end

  @doc """
  end of day, the balance from the summary need to carry forward to next day
  CommerceFront.Settings.carry_forward_entry(Date.utc_today() |> Timex.shift(days: -1))
  """
  def carry_forward_entry(from_date \\ Date.utc_today()) do
    query =
      from(pgsd in GroupSalesSummary,
        left_join: u in User,
        on: u.id == pgsd.user_id,
        where:
          pgsd.day == ^from_date.day and pgsd.month == ^from_date.month and
            pgsd.year == ^from_date.year and not is_nil(u.username),
        order_by: [asc: pgsd.id]
      )

    gs_summaries = Repo.all(query)

    Multi.new()
    |> Multi.run(:carry_forward, fn _repo, %{} ->
      res =
        for gs_summary <-
              gs_summaries
              |> Enum.reject(&(&1.balance_left == nil && &1.balance_right == nil)) do
          gs_summary = gs_summary |> Repo.preload(:user)

          gs_summary =
            if gs_summary.new_left == 0 && gs_summary.new_right == 0 &&
                 gs_summary.balance_left == 0 && gs_summary.balance_right == 0 do
              gs_summary
              |> Map.put(:balance_left, gs_summary.total_left)
              |> Map.put(:balance_right, gs_summary.total_right)
            else
              # possible that bal left and right are 0, even without pairing

              with true <- gs_summary.new_left == 0 || gs_summary.new_right == 0 do
                if gs_summary.new_left > gs_summary.new_right do
                  gs_summary |> Map.put(:balance_left, gs_summary.total_left)
                else
                  gs_summary |> Map.put(:balance_right, gs_summary.total_right)
                end
              else
                _ ->
                  gs_summary
              end
            end

          {:ok, left} =
            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: gs_summary.balance_left,
                after: 0,
                amount: gs_summary.balance_left * -1,
                remarks: "carry forward",
                from_user_id: gs_summary.user_id,
                to_user_id: gs_summary.user_id,
                sales_id: 0,
                position: "left",
                gs_summary_id: gs_summary.id
              }
            )
            |> Repo.insert()

          {:ok, right} =
            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: gs_summary.balance_right,
                after: 0,
                amount: gs_summary.balance_right * -1,
                remarks: "carry forward",
                from_user_id: gs_summary.user_id,
                to_user_id: gs_summary.user_id,
                sales_id: 0,
                position: "right",
                gs_summary_id: gs_summary.id
              }
            )
            |> Repo.insert()

          to_date = from_date |> Timex.shift(days: 1)

          {:ok, gs} =
            CommerceFront.Settings.GroupSalesSummary.changeset(
              %CommerceFront.Settings.GroupSalesSummary{},
              %{
                new_left: 0,
                new_right: 0,
                total_left: 0,
                total_right: 0,
                user_id: gs_summary.user_id,
                day: to_date.day,
                month: to_date.month,
                year: to_date.year
              }
            )
            |> Repo.insert()

          # todo, check for existing PGSD entries

          CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
            %CommerceFront.Settings.PlacementGroupSalesDetail{},
            %{
              before: 0,
              after: gs_summary.balance_left,
              amount: gs_summary.balance_left,
              remarks: "bring forward from #{left.id}",
              from_user_id: gs_summary.user_id,
              to_user_id: gs_summary.user_id,
              sales_id: 0,
              position: "left",
              gs_summary_id: gs.id
            }
          )
          |> Repo.insert()

          CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
            %CommerceFront.Settings.PlacementGroupSalesDetail{},
            %{
              before: 0,
              after: gs_summary.balance_right,
              amount: gs_summary.balance_right,
              remarks: "bring forward from #{right.id}",
              from_user_id: gs_summary.user_id,
              to_user_id: gs_summary.user_id,
              sales_id: 0,
              position: "right",
              gs_summary_id: gs.id
            }
          )
          |> Repo.insert()

          # if gs_summary.user.username == "damien" && from_date == ~D[2023-11-26] do
          #   IEx.pry()
          # end

          CommerceFront.Settings.GroupSalesSummary.changeset(
            gs,
            %{
              total_left: gs_summary.balance_left,
              total_right: gs_summary.balance_right,
              balance_left: gs_summary.balance_left,
              balance_right: gs_summary.balance_right
            }
          )
          |> Repo.update()
          |> IO.inspect()
        end

      {:ok, res}
    end)
    |> Repo.transaction()
  end

  def create_topup_transaction(params) do
    IO.inspect(params)

    Multi.new()
    |> Multi.run(:topup, fn _repo, %{} ->
      create_wallet_topup(params)
    end)
    |> Multi.run(:payment, fn _repo, %{topup: topup} ->
      res = Billplz.create_collection("Topup Order: #{topup.id}")
      collection_id = Map.get(res, "id")

      bill_res =
        Billplz.create_bill(collection_id, %{
          description: "Topup Order: #{topup.id}",
          email: params["user"]["email"],
          name: params["user"]["fullname"],
          amount: topup.amount * 5
        })

      create_payment(%{
        amount: topup.amount,
        wallet_topup_id: topup.id,
        billplz_code: Map.get(bill_res, "id"),
        payment_url: Map.get(bill_res, "url")
      })
    end)
    |> Repo.transaction()
  end

  @doc """
  this is to create the billplz link and let user to complete the flow 
  """
  def create_sales_transaction(params) do
    IO.inspect(params)

    title =
      cond do
        params["user"] |> Map.get("redeem") != nil ->
          "Redeem"

        params["user"] |> Map.get("upgrade") != nil ->
          "Upgrade"

        true ->
          "Sales"
      end

    Multi.new()
    |> Multi.run(:sale, fn _repo, %{} ->
      pv = 0

      # need to check if DRP was used

      create_sale(%{
        month: Date.utc_today().month,
        year: Date.utc_today().year,
        sale_date: Date.utc_today(),
        status: :pending_payment,
        subtotal: 0,
        total_point_value: pv,
        registration_details: Jason.encode!(params),
        sales_person_id: params["user"]["sales_person_id"]
        # user_id: user.id
      })
    end)
    |> Multi.run(:sales2, fn _repo, %{sale: sale} ->
      sample = %{
        "0" => %{"item_name" => "Product C", "item_price" => "200", "qty" => "3"},
        "1" => %{"item_name" => "Product B", "item_price" => "500", "qty" => "2"},
        "2" => %{"item_name" => "Product A", "item_price" => "1000", "qty" => "1"}
      }

      products = params |> Kernel.get_in(["user", "products"])
      shipping_fee = 2

      res =
        for key <- Map.keys(products) do
          product_params =
            products[key]
            |> Map.put("sales_id", sale.id)

          {:ok, pres} = product_params |> CommerceFront.Settings.create_sales_item()

          p = get_product_by_name(product_params["item_name"])
          p |> Map.put(:qty, product_params["qty"] |> String.to_integer())
        end

      calc_rp = fn product, acc ->
        acc + product.retail_price * product.qty
      end

      total_rp = Enum.reduce(res, 0, &calc_rp.(&1, &2))

      calc_pv = fn product, acc ->
        acc + product.point_value * product.qty
      end

      total_pv =
        with true <- params["user"]["rank_id"] != nil,
             rank <- CommerceFront.Settings.get_rank!(params["user"]["rank_id"]),
             true <- rank.point_value == 0 do
          0
        else
          _ ->
            Enum.reduce(res, 0, &calc_pv.(&1, &2))
        end

      shipping_fee =
        if total_rp > 500 do
          0
        else
          shipping_fee
        end

      update_sale(sale, %{
        total_point_value: total_pv,
        subtotal: total_rp,
        shipping_fee: shipping_fee,
        grand_total: total_rp + shipping_fee
      })
    end)
    |> Multi.run(:payment, fn _repo, %{sales2: sale} ->
      case params["user"]["payment"]["method"] do
        "product_point" ->
          wallets = CommerceFront.Settings.list_ewallets_by_user_id(sale.sales_person_id)
          pp = wallets |> Enum.filter(&(&1.wallet_type == :product)) |> List.first()

          check_sufficient = fn subtotal ->
            # deduct the ewallet 

            with true <- (pp.total >= sale.subtotal) |> IO.inspect() do
              {:ok, sale} = update_sale(sale, %{total_point_value: 0, status: :processing})

              create_wallet_transaction(%{
                user_id: sale.sales_person_id,
                amount: sale.grand_total * -1,
                remarks: "#{title}: #{sale.id}",
                wallet_type: "product"
              })

              create_payment(%{
                payment_method: "product_point",
                amount: sale.grand_total,
                sales_id: sale.id,
                webhook_details: "pp paid: #{subtotal}"
              })

              {:ok, sale}
            else
              _ ->
                {:error, nil}
            end
          end

          case check_sufficient.(sale.subtotal) do
            # direct register liao... 
            {:ok, sale} ->
              {:ok, %CommerceFront.Settings.Payment{payment_url: "/sales/#{sale.id}"}}

            _ ->
              {:error, "not sufficient"}
          end

        "fpx" ->
          res = Billplz.create_collection("#{title} Order: #{sale.id}")
          collection_id = Map.get(res, "id")

          bill_res =
            Billplz.create_bill(collection_id, %{
              description: "#{title} Order: #{sale.id}",
              email: params["user"]["email"],
              name: params["user"]["shipping"]["fullname"],
              amount: sale.grand_total * 5,
              phone: params["user"]["shipping"]["phone"]
            })

          if Map.get(bill_res, "url") != nil do
            create_payment(%{
              payment_method: "fpx",
              amount: sale.grand_total,
              sales_id: sale.id,
              billplz_code: Map.get(bill_res, "id"),
              payment_url: Map.get(bill_res, "url")
            })
          else
            {:error, nil}
          end

        "only_register_point" ->
          # check sales person... register point sufficient
          wallets = CommerceFront.Settings.list_ewallets_by_user_id(sale.sales_person_id)
          # drp = wallets |> Enum.filter(&(&1.wallet_type == :direct_recruitment)) |> List.first()
          rp = wallets |> Enum.filter(&(&1.wallet_type == :register)) |> List.first()

          check_sufficient = fn subtotal ->
            # here proceed to normal registration and deduct the ewallet 

            with true <- (rp.total >= sale.grand_total) |> IO.inspect() do
              {:ok, sale} =
                update_sale(sale, %{
                  total_point_value: sale.total_point_value
                })

              create_wallet_transaction(%{
                user_id: sale.sales_person_id,
                amount: subtotal * -1,
                remarks: "#{title}: #{sale.id}",
                wallet_type: "register"
              })

              create_payment(%{
                payment_method: "only_register_point",
                amount: sale.grand_total,
                sales_id: sale.id,
                webhook_details: "rp paid: #{subtotal}"
              })

              {:ok, sale}
            else
              _ ->
                {:error, nil}
            end
          end

          case check_sufficient.(sale.grand_total) do
            # direct register liao... 

            {:ok, sale} ->
              {:ok, user} = register(params["user"], sale)

              {:ok, %CommerceFront.Settings.Payment{payment_url: "/home", user: user}}

            _ ->
              {:error, "not sufficient"}
          end

        "register_point" ->
          # check sales person... register point sufficient
          wallets = CommerceFront.Settings.list_ewallets_by_user_id(sale.sales_person_id)
          drp = wallets |> Enum.filter(&(&1.wallet_type == :direct_recruitment)) |> List.first()
          rp = wallets |> Enum.filter(&(&1.wallet_type == :register)) |> List.first()

          check_sufficient = fn subtotal ->
            # here proceed to normal registration and deduct the ewallet 
            form_drp =
              if params["user"]["payment"]["drp"] != nil do
                String.to_integer(params["user"]["payment"]["drp"])
              else
                0
              end

            with true <- :erlang.trunc(drp.total) >= form_drp,
                 true <- (rp.total >= sale.grand_total - form_drp) |> IO.inspect() do
              {:ok, sale} =
                update_sale(sale, %{
                  total_point_value: sale.total_point_value - form_drp
                })

              create_wallet_transaction(%{
                user_id: sale.sales_person_id,
                amount: form_drp * -1,
                remarks: "#{title}: #{sale.id}",
                wallet_type: "direct_recruitment"
              })

              create_wallet_transaction(%{
                user_id: sale.sales_person_id,
                amount: (subtotal - form_drp) * -1,
                remarks: "#{title}: #{sale.id}",
                wallet_type: "register"
              })

              create_payment(%{
                payment_method: "register_point",
                amount: sale.grand_total,
                sales_id: sale.id,
                webhook_details: "rp paid: #{subtotal - form_drp}|drp paid: #{form_drp}"
              })

              {:ok, sale}
            else
              _ ->
                {:error, nil}
            end
          end

          case check_sufficient.(sale.grand_total) do
            # direct register liao... 

            {:ok, sale} ->
              form_drp =
                if params["user"]["payment"]["drp"] != nil do
                  String.to_integer(params["user"]["payment"]["drp"])
                else
                  0
                end

              {:ok, user} = register(params["user"], sale)

              CommerceFront.Calculation.drp_sales_level_bonus(
                sale.id,
                form_drp,
                user,
                Date.utc_today()
              )

              {:ok, %CommerceFront.Settings.Payment{payment_url: "/home", user: user}}

            _ ->
              {:error, "not sufficient"}
          end

        _ ->
          {:error, nil}
      end
    end)
    |> Repo.transaction()
  end

  @doc """
  the registration is paid with RP 
  which can be bought from company,
  admin just need to approve the RP purchase...

  during registration, the checkout contains the products


  %{      
  "email" => "a@1.com",
  "fullname" => "1",
  "password" => "abc123",
  "payment" => %{"method" => "FPX"},
  "phone" => "1",
  "rank_id" => "3",
  "shipping" => %{
    "city" => "city",
    "fullname" => "1",
    "line1" => "line1",
    "line2" => "line2",
    "phone" => "1",
    "postcode" => "postcode",
    "state" => "state"
  },
  "sponsor" => "damien",
  "username" => "damien"
  }


  """

  def register(params, sales) do
    multi =
      Multi.new()
      |> Multi.run(:sales_person, fn _repo, %{} ->
        user = CommerceFront.Settings.get_user!(params["sales_person_id"]) |> Repo.preload(:rank)
        {:ok, user}
      end)
      |> Multi.run(:user, fn _repo, %{sales_person: sales_person} ->
        if params["upgrade"] != nil do
          sales_person.rank.retail_price
          total_pv = sales_person.rank.retail_price + sales.subtotal
          # determine wat rank he reached based on new pv... 
          new_rank =
            CommerceFront.Settings.list_ranks()
            |> Enum.sort_by(& &1.retail_price)
            |> Enum.filter(&(&1.retail_price <= total_pv))
            |> List.last()

          prm = %{
            rank_id: new_rank.id,
            rank_name: new_rank.name
          }

          {:ok, sales_person} = CommerceFront.Settings.update_user(sales_person, prm)

          {:ok, sales_person |> Map.put(:rank, new_rank)}
        else
          rank = get_rank!(params["rank_id"])

          create_user(params |> Map.put("rank_name", rank.name))
        end
      end)
      |> Multi.run(:ewallets, fn _repo, %{user: user} ->
        if params["upgrade"] != nil do
        else
          wallets = ["bonus", "product", "register", "direct_recruitment"]

          for wallet_type <- wallets do
            CommerceFront.Settings.create_wallet_transaction(%{
              user_id: user.id,
              amount: 0.00,
              remarks: "initial",
              wallet_type: wallet_type
            })
          end
        end

        {:ok, nil}
      end)
      |> Multi.run(:sale, fn _repo, %{user: user} ->
        # rank = get_rank!(params["rank_id"])
        # pv = rank.point_value

        # # need to check if DRP was used
        if params["stockist"] != nil do
          {:ok, nil}
        else
          update_sale(sales, %{
            month: Date.utc_today().month,
            year: Date.utc_today().year,
            sale_date: Date.utc_today(),
            status: :processing,
            user_id: user.id
          })
        end
      end)
      |> Multi.run(:referral, fn _repo, %{user: user} ->
        if params["upgrade"] != nil do
          {:ok, get_referral_by_username(user.username)}
        else
          parent_r = get_referral_by_username(params["sponsor"])

          create_referral(%{
            parent_user_id: parent_r.user_id,
            parent_referral_id: parent_r.id,
            user_id: user.id
          })
        end
      end)
      |> Multi.run(:placement, fn _repo, %{user: user} ->
        if params["upgrade"] != nil do
          parent_p = get_placement_by_username(user.username)
          IEx.pry()
          {:ok, parent_p}
        else
          {position, parent_p} = determine_position(params["sponsor"])

          create_placement(%{
            parent_user_id: parent_p.user_id,
            parent_placement_id: parent_p.id,
            position: position,
            user_id: user.id
          })
        end
      end)
      |> Multi.run(:pgsd, fn _repo, %{user: user, sale: sale, placement: placement} ->
        if params["stockist"] != nil do
          {:ok, nil}
        else
          contribute_group_sales(user.username, sale.total_point_value, sale, placement)
        end
      end)
      |> Multi.run(:sharing_bonus, fn _repo,
                                      %{pgsd: pgsd, user: user, sale: sale, referral: referral} ->
        if params["stockist"] != nil do
          {:ok, nil}
        else
          sharing_bonus(user.username, sale.total_point_value, sale, referral)
        end
      end)
      |> Multi.run(:stockist_register_bonus, fn _repo,
                                                %{
                                                  sales_person: sales_person,
                                                  pgsd: pgsd,
                                                  user: user,
                                                  sale: sale,
                                                  referral: referral
                                                } ->
        if sales_person.is_stockist do
          stockist_register_bonus(sales_person, user.username, sale.total_point_value, sale)
        else
          {:ok, nil}
        end
      end)
      |> Multi.run(:special_share_reward, fn _repo,
                                             %{
                                               pgsd: pgsd,
                                               user: user,
                                               sale: sale,
                                               placement: placement
                                             } ->
        if params["upgrade"] != nil do
          {:ok, nil}
        else
          if params["stockist"] != nil do
            {:ok, nil}
          else
            special_share_reward(user.id, sale.total_point_value, sale)
          end
        end
      end)
      |> Multi.run(:stockist, fn _repo, %{user: user, sale: sale, placement: placement} ->
        with true <- sale != nil,
             true <- sale.subtotal >= 2000,
             true <- sale.total_point_value >= 1000 do
          # IEx.pry()
          CommerceFront.Settings.convert_to_stockist(user |> Map.put(:placement, placement))
        else
          _ ->
            nil
        end

        {:ok, nil}
      end)
      |> Repo.transaction()
      |> IO.inspect()
      |> case do
        {:ok, multi_res} ->
          if params["upgrade"] != nil do
            {:ok, nil}
          else
            placement_counter_reset()
          end

          {:ok, multi_res |> Map.get(:user) |> Map.put(:placement, multi_res.placement)}

        _ ->
          {:error, []}
      end
  end

  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def check_uplines(child_username, tree \\ :placement) do
    child_user = get_user_by_username(child_username)
    child_user_id = child_user.id

    module =
      if tree == :placement do
        Placement
      else
        Referral
      end

    select_statement = fn query ->
      if tree == :placement do
        query
        |> select([m, pt, m2], %{
          child_id: m.id,
          child: m.username,
          pt_child_id: pt.id,
          pt_parent_id: pt.parent_placement_id,
          parent: m2.username,
          parent_id: m2.id,
          pt_position: pt.position
        })
      else
        query
        |> select([m, pt, m2, r], %{
          child_id: m.id,
          child: m.username,
          pt_child_id: pt.id,
          pt_parent_id: pt.parent_referral_id,
          parent: m2.username,
          parent_id: m2.id,
          rank: r.name
        })
      end
    end

    category_tree_initial_query =
      module
      |> where([sp], sp.user_id == ^child_user_id)

    category_tree_recursion_query =
      module
      |> join(:inner, [sp], pt in "placement_tree", on: sp.user_id == pt.parent_user_id)

    category_tree_query =
      category_tree_initial_query
      |> union_all(^category_tree_recursion_query)

    User
    |> recursive_ctes(true)
    |> with_cte("placement_tree", as: ^category_tree_query)
    |> join(:left, [m], pt in "placement_tree", on: m.id == pt.user_id)
    |> join(:left, [m, pt], m2 in User, on: m2.id == pt.parent_user_id)
    |> join(:left, [m, pt, m2], r in Rank, on: m2.rank_id == r.id)
    |> where([m, pt, m2], m.id <= ^child_user_id)
    |> where([m, pt, m2], not is_nil(m2.id))
    |> select_statement.()
    |> order_by([m, pt, m2], desc: m.id)
    |> Repo.all()
  end

  @doc """


  WITH RECURSIVE "placement_tree" AS 
  (SELECT 
    p0."id" AS "id", 
    p0."parent_user_id" AS "parent_user_id", 
    p0."parent_placement_id" AS "parent_placement_id", 
    p0."position" AS "position", 
    p0."left" AS "left", 
    p0."right" AS "right", 
    p0."user_id" AS "user_id", 
    p0."inserted_at" AS "inserted_at", 
    p0."updated_at" AS "updated_at" 

    FROM "placements" AS p0 WHERE (p0."parent_user_id" = $1) UNION ALL (


    SELECT p0."id", p0."parent_user_id", 
    p0."parent_placement_id", p0."position", 
    p0."left", p0."right", p0."user_id", 
    p0."inserted_at", p0."updated_at" FROM "placements" AS p0 INNER JOIN "placement_tree" AS p1 ON p0."parent_user_id" = p1."user_id")) 


    SELECT ARRAY_AGG( CONCAT(u0."username", '|', u0."id", '|', u0."rank_name", '|', p1."position", '|', p1."left", '|', p1."right", '|', s3."total_left", '|', s3."total_right", '|', s3."balance_left", '|', s3."balance_right", '|', s3."new_left", '|', s3."new_right", '|', s4."sum_left", '|', s4."sum_right") ), u2."fullname", u2."username", u2."id" FROM "users" AS u0 

    LEFT OUTER JOIN "placement_tree" AS p1 ON u0."id" = p1."user_id" 
    LEFT OUTER JOIN "users" AS u2 ON u2."id" = p1."parent_user_id" 
    FULL OUTER JOIN (
      SELECT sg0."id" AS "id", sg0."balance_left" AS "balance_left", 
        sg0."balance_right" AS "balance_right", sg0."day" AS "day", 
        sg0."month" AS "month", sg0."paired" AS "paired", 
        sg0."total_left" AS "total_left", sg0."total_right" AS "total_right", 
        sg0."new_left" AS "new_left", sg0."new_right" AS "new_right", 
        sg0."user_id" AS "user_id", sg0."year" AS "year", 
        sg0."inserted_at" AS "inserted_at", sg0."updated_at" AS "updated_at" FROM "group_sales_summaries" AS sg0 WHERE (((sg0."day" = $2) AND (sg0."month" = $3)) AND (sg0."year" = $4))) AS s3 ON s3."user_id" = p1."user_id" 
        FULL OUTER JOIN (SELECT sum(sg0."new_left") AS "sum_left", sum(sg0."new_right") AS "sum_right", sg0."user_id" AS "user_id" FROM "group_sales_summaries" AS sg0 WHERE ((sg0."month" = $5) AND (sg0."year" = $6)) GROUP BY sg0."user_id", sg0."month", sg0."year") AS s4 ON s4."user_id" = p1."user_id" WHERE (u0."id" > $7) AND (NOT (u2."id" IS NULL)) GROUP BY u2."id" [16, 2, 12, 2023, 12, 2023, 16]



      "kathy|587|银级套餐|right|0|20|0|  0|0|0|0|  0|0|350",
      "kathy|587|银级套餐|right|0|20|0|100|0|0|0|100|0|350"

  """
  def check_downlines(parent_username, tree \\ :placement, direction \\ nil) do
    parent_user = get_user_by_username(parent_username)
    parent_user_id = parent_user.id

    seek_direction = fn query, direction ->
      if direction == nil do
        query
        # |> limit([m, pt, m2, gss], 10)
      else
        query
        # |> join(:full, [m, pt, m2, gss], pt2 in Placement, on: pt2.user_id == m2.id)
        |> where([m, pt, m2, gss], pt.position == ^direction)
      end
    end

    module =
      if tree == :placement do
        Placement
      else
        Referral
      end

    select_statement = fn query ->
      if tree == :placement do
        query
        |> select([m, pt, m2, gss, gss2], %{
          children:
            fragment(
              "ARRAY_AGG( CONCAT(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) )",
              m.username,
              "|",
              m.id,
              "|",
              m.rank_name,
              "|",
              pt.position,
              "|",
              pt.left,
              "|",
              pt.right,
              "|",
              gss.total_left,
              "|",
              gss.total_right,
              "|",
              gss.balance_left,
              "|",
              gss.balance_right,
              "|",
              gss.new_left,
              "|",
              gss.new_right,
              "|",
              gss2.sum_left,
              "|",
              gss2.sum_right
            ),
          parent: m2.fullname,
          parent_username: m2.username,
          parent_id: m2.id
        })
      else
        query
        |> select([m, pt, m2], %{
          children:
            fragment(
              "ARRAY_AGG( CONCAT(?, ?, ?, ?, ?, ?, ?) )",
              m.username,
              "|",
              m.id,
              "|",
              m.fullname,
              "|",
              m.rank_name
            ),
          parent: m2.fullname,
          parent_username: m2.username,
          parent_id: m2.id,
          rank_name: m2.rank_name
        })
      end
    end

    category_tree_initial_query =
      module
      |> where([sp], sp.parent_user_id == ^parent_user_id)

    category_tree_recursion_query =
      module
      |> join(:inner, [sp], pt in "placement_tree", on: sp.parent_user_id == pt.user_id)

    category_tree_query =
      category_tree_initial_query
      |> union_all(^category_tree_recursion_query)

    User
    |> recursive_ctes(true)
    |> with_cte("placement_tree", as: ^category_tree_query)
    |> join(:left, [m], pt in "placement_tree", on: m.id == pt.user_id)
    |> join(:left, [m, pt], m2 in User, on: m2.id == pt.parent_user_id)
    |> join(:full, [m, pt, m2], gss in subquery(gs_subquery()), on: gss.user_id == pt.user_id)
    |> join(:full, [m, pt, m2, gss], gss2 in subquery(gs_subquery2()),
      on: gss2.user_id == pt.user_id
    )
    # |> where([m, pt, m2, gss, gss2], m.id > ^parent_user_id)
    |> where([m, pt, m2, gss, gss2], not is_nil(m2.id))
    |> group_by([m, pt, m2, gss, gss2], [m2.id])
    |> select_statement.()
    |> Repo.all()

    # sanitize_res = fn map ->
    #   uniq_children = map.children |> Enum.uniq()

    #   map |> Map.put(:children, uniq_children)
    # end

    # Enum.map(res, &(&1 |> sanitize_res.()))
  end

  def gs_subquery2() do
    from(gss in GroupSalesSummary,
      where:
        gss.month == ^Date.utc_today().month and
          gss.year == ^Date.utc_today().year,
      select: %{sum_left: sum(gss.new_left), sum_right: sum(gss.new_right), user_id: gss.user_id},
      group_by: [gss.user_id, gss.month, gss.year]
    )
  end

  def sanitize_carry_forwards(date) do
    data =
      Repo.all(
        from(gss in GroupSalesSummary,
          where:
            gss.day == ^date.day and gss.month == ^date.month and
              gss.year == ^date.year
        )
      )
      |> Enum.group_by(& &1.user_id)

    for user_id <- Map.keys(data) do
      # IO.inspect()
      case data[user_id] do
        [hd, tl, tl2] ->
          Repo.delete(hd)
          Repo.delete(tl)

        _ ->
          nil
      end
    end
  end

  def gs_subquery() do
    from(gss in GroupSalesSummary,
      where:
        gss.day == ^Date.utc_today().day and gss.month == ^Date.utc_today().month and
          gss.year == ^Date.utc_today().year
    )
  end

  def pay_unpaid_bonus(date, bonus_list) do
    {y, m, d} = date |> Date.to_erl()

    matrix = ["team bonus", "matching bonus", "elite leader"]

    month_rewards =
      Repo.all(
        from(r in Reward,
          where:
            r.month == ^m and
              r.year == ^y,
          select: %{sum: sum(r.amount), bonus: r.name, user_id: r.user_id},
          group_by: [r.user_id, r.name]
        )
      )

    check_this_month_reward = fn user_id, month_rewards ->
      month_rewards
      |> Enum.filter(&(&1.user_id == user_id))
      |> Enum.filter(&(&1.bonus in matrix))
      |> Enum.map(& &1.sum)
      |> Enum.sum()
    end

    for bonus <- bonus_list do
      rewards =
        Repo.all(
          from(r in Reward,
            where:
              r.is_paid == false and
                r.name == ^bonus and r.day == ^d and r.month == ^m and
                r.year == ^y
          )
        )

      pay_to_bonus_wallet = fn reward, multi ->
        multi
        |> Multi.run(String.to_atom("reward_#{reward.id}"), fn _repo, %{} ->
          cond do
            # reward.name == "travel fund" ->
            # get company total pv
            # expect this date to be the last day in the month...

            # month_pv =
            #   CommerceFront.Settings.this_month_sales(date)
            #   |> Enum.map(& &1.total_pv)
            #   |> Enum.sum()

            # allocated = month_pv * 0.05

            # all_member_travel_fund =
            #   CommerceFront.Settings.today_bonus("travel fund", date)
            #   |> List.first()
            #   |> Map.get(:sum)

            # per_share_value = (allocated / all_member_travel_fund) |> Float.round(2)
            # amount = per_share_value * reward.amount

            # params = %{
            #   user_id: reward.user_id,
            #   amount: amount |> Float.round(2),
            #   remarks:
            #     reward.remarks <>
            #       "|no shares: #{reward.amount}|month allocated: #{allocated}|per share: #{per_share_value}",
            #   wallet_type: "travel"
            # }

            # case create_wallet_transaction(params) do
            #   {:ok, wt} ->
            #     update_reward(reward, %{is_paid: true})

            #   {:error, cg} ->
            #     {:error, cg}
            # end

            true ->
              total_this_month = check_this_month_reward.(reward.user_id, month_rewards)

              {amount, remarks} =
                if bonus not in matrix do
                  {reward.amount, "month total: #{total_this_month}|pay: 100%"}
                else
                  if total_this_month > 10000 do
                    {reward.amount, "month total: #{total_this_month}|pay: 100%"}
                  else
                    {reward.amount * 0.9, "month total: #{total_this_month}|pay: 90%"}
                  end
                end

              params = %{
                user_id: reward.user_id,
                amount: amount |> Float.round(2),
                remarks: reward.remarks <> "|" <> remarks,
                wallet_type: "bonus"
              }

              case create_wallet_transaction(params) do
                {:ok, wt} ->
                  if total_this_month <= 10000 && bonus in matrix do
                    params2 = %{
                      user_id: reward.user_id,
                      amount: (reward.amount * 0.1) |> Float.round(2),
                      remarks:
                        reward.remarks <> "|" <> "month total: #{total_this_month}|pay: 10%",
                      wallet_type: "product"
                    }

                    create_wallet_transaction(params2)
                  end

                  update_reward(reward, %{is_paid: true})

                {:error, cg} ->
                  {:error, cg}
              end
          end
        end)
      end

      Enum.reduce(rewards, Multi.new(), &pay_to_bonus_wallet.(&1, &2))
      |> Repo.transaction()
      |> IO.inspect()
    end
  end

  def reset do
    Repo.delete_all(Reward)
    Repo.delete_all(WalletTransaction)

    Repo.delete_all(Ewallet)
    Repo.delete_all(User)
    Repo.delete_all(Placement)
    Repo.delete_all(Referral)

    Repo.delete_all(Sale)
    Repo.delete_all(PlacementGroupSalesDetail)
  end

  def rollback do
    Repo.all(from(u in User, order_by: [desc: u.id])) |> List.first() |> Repo.delete()
    Repo.all(from(u in Placement, order_by: [desc: u.id])) |> List.first() |> Repo.delete()
    Repo.all(from(u in Referral, order_by: [desc: u.id])) |> List.first() |> Repo.delete()
    Repo.all(from(u in Sale, order_by: [desc: u.id])) |> List.first() |> Repo.delete()

    Repo.all(from(u in PlacementGroupSalesDetail, order_by: [desc: u.id]))
    |> List.first()
    |> Repo.delete()
  end

  def user_monthly_reward_summary(user_id, is_prev \\ false) do
    date =
      if is_prev == "true" do
        Date.utc_today() |> Timex.shift(months: -1)
      else
        Date.utc_today()
      end

    {y, m, d} = date |> Date.to_erl()

    Repo.all(
      from(r in Reward,
        where: r.user_id == ^user_id,
        where: r.month == ^m and r.year == ^y,
        group_by: [r.name, r.month, r.year],
        select: %{period: [r.month, r.year], name: r.name, sum: sum(r.amount)}
      )
    )
  end

  def approve_topup(params) do
    topup = get_wallet_topup!(params["id"])

    if topup.is_approved == false do
      Multi.new()
      |> Multi.run(:topup, fn _repo, %{} ->
        update_wallet_topup(topup, %{"is_approved" => "on"})
      end)
      |> Multi.run(:wallet_transaction, fn _repo, %{topup: topup} ->
        create_wallet_transaction(%{
          user_id: topup.user_id,
          amount: topup.amount,
          remarks: "Topup: #{topup.id}",
          wallet_type: "register"
        })
      end)
      |> Repo.transaction()
      |> IO.inspect()
      |> case do
        {:ok, multi_res} ->
          # {:ok, multi_res |> Map.get(:ewallet)}
          {:ok, multi_res}

        _ ->
          {:error, []}
      end
    else
      {:error, "already approved"}
    end
  end

  def rename_ranks() do
    users = Repo.all(from(u in User, preload: [:rank]))

    for user <- users do
      update_user(user, %{rank_name: user.rank.name})
    end
  end

  def convert_to_stockist(user) do
    # create the other 2 nodes first..
    # then append them under the current account?
    Multi.new()
    |> Multi.run(:u2u3, fn _repo, %{} ->
      unit_2 =
        register(
          %{
            "stockist_user_id" => user.id,
            "rank_id" => user.rank_id,
            "sponsor" => user.username,
            "stockist" => true,
            "email" => user.email,
            "username" => user.username <> "-U2",
            "fullname" => user.fullname,
            "phone" => user.phone
          },
          %CommerceFront.Settings.Sale{}
        )

      unit_3 =
        register(
          %{
            "stockist_user_id" => user.id,
            "rank_id" => user.rank_id,
            "sponsor" => user.username,
            "stockist" => true,
            "email" => user.email,
            "username" => user.username <> "-U3",
            "fullname" => user.fullname,
            "phone" => user.phone
          },
          %CommerceFront.Settings.Sale{}
        )

      updated_parent = user |> Repo.preload([:placement, stockist_users: [placement: [:parent]]])

      [%{placement: u2_placement} = u2, %{placement: u3_placement} = u3] =
        updated_parent.stockist_users

      res =
        Repo.all(
          from(p in Placement, where: p.parent_placement_id == ^updated_parent.placement.id)
        )

      case res do
        [%{position: "right"} = current_right, %{position: "left"} = current_left] ->
          if u2_placement.id != current_left.id do
            update_placement(u2_placement, %{
              position: "left",
              parent_placement_id: updated_parent.placement.id,
              parent_user_id: updated_parent.id
            })

            update_placement(current_left, %{
              parent_placement_id: u2_placement.id,
              parent_user_id: u2_placement.user_id
            })
          end

          if u3_placement.id != current_right.id do
            update_placement(u3_placement, %{
              position: "right",
              parent_placement_id: updated_parent.placement.id,
              parent_user_id: updated_parent.id
            })

            update_placement(current_right, %{
              parent_placement_id: u3_placement.id,
              parent_user_id: u3_placement.user_id
            })
          end

        [%{position: "left"} = current_left, %{position: "right"} = current_right] ->
          if u2_placement.id != current_left.id do
            update_placement(u2_placement, %{
              position: "left",
              parent_placement_id: updated_parent.placement.id,
              parent_user_id: updated_parent.id
            })

            update_placement(current_left, %{
              parent_placement_id: u2_placement.id,
              parent_user_id: u2_placement.user_id
            })
          end

          if u3_placement.id != current_right.id do
            update_placement(u3_placement, %{
              position: "right",
              parent_placement_id: updated_parent.placement.id,
              parent_user_id: updated_parent.id
            })

            update_placement(current_right, %{
              parent_placement_id: u3_placement.id,
              parent_user_id: u3_placement.user_id
            })
          end

        [%{position: "left"} = current_left] ->
          update_placement(u2_placement, %{
            position: "left",
            parent_placement_id: updated_parent.placement.id,
            parent_user_id: updated_parent.id
          })

          update_placement(current_left, %{
            parent_placement_id: u2_placement.id,
            parent_user_id: u2_placement.user_id
          })

        [%{position: "right"} = current_right] ->
          update_placement(u3_placement, %{
            position: "right",
            parent_placement_id: updated_parent.placement.id,
            parent_user_id: updated_parent.id
          })

          update_placement(current_right, %{
            parent_placement_id: u3_placement.id,
            parent_user_id: u3_placement.user_id
          })

        _ ->
          # IEx.pry()
          nil
      end

      # placement_counter_reset()

      Elixir.Task.start_link(CommerceFront.Settings, :placement_counter_reset, [])
      {:ok, [unit_2, unit_3, updated_parent]}
    end)
    |> Repo.transaction()
  end

  def finance_user() do
    res = get_user_by_username("haho_finance")

    if res == nil do
      {:ok, user} =
        create_user(%{
          "email" => "finance@1.com",
          "username" => "haho_finance",
          "fullname" => "haho_finance",
          "phone" => "0122664254",
          "password" => "abc222"
        })

      user
    else
      res
    end
  end

  def transfer_wallet(user_id, username, amount) do
    wallet =
      list_ewallets_by_user_id(user_id)
      |> Enum.filter(&(&1.wallet_type == :register))
      |> List.first()

    user = CommerceFront.Settings.get_user!(user_id)
    receiver = CommerceFront.Settings.get_user_by_username(username)

    if receiver == nil do
      %{status: "error", reason: "User not found"}
    else
      if wallet.total >= amount do
        CommerceFront.Settings.create_wallet_transaction(%{
          user_id: user_id,
          amount: amount * -1,
          remarks: "Transfer to #{username}",
          wallet_type: "register"
        })

        CommerceFront.Settings.create_wallet_transaction(%{
          user_id: receiver.id,
          amount: amount,
          remarks: "Transfer received from #{user.username}",
          wallet_type: "register"
        })

        %{status: "ok", res: "ok"}
      else
        %{status: "error", reason: "insufficient wallet balance"}
      end
    end
  end

  def convert_wallet(user_id, amount) do
    wallet =
      list_ewallets_by_user_id(user_id)
      |> Enum.filter(&(&1.wallet_type == :bonus))
      |> List.first()

    if wallet.total >= amount do
      CommerceFront.Settings.create_wallet_transaction(%{
        user_id: user_id,
        amount: amount * -1,
        remarks: "Convert",
        wallet_type: "bonus"
      })

      CommerceFront.Settings.create_wallet_transaction(%{
        user_id: user_id,
        amount: amount,
        remarks: "Convert",
        wallet_type: "register"
      })

      %{status: "ok", res: "ok"}
    else
      %{status: "error", reason: "insufficient wallet balance"}
    end
  end

  def check_staff_password(params) do
    users =
      Repo.all(
        from(u in Staff, where: u.username == ^params["username"], preload: [role: :app_routes])
      )
      |> IO.inspect()

    if users != [] do
      user = List.first(users)

      crypted_password =
        :crypto.hash(:sha512, params["password"] |> IO.inspect())
        |> Base.encode16()
        |> String.downcase()
        |> IO.inspect()

      {crypted_password == user.crypted_password, user} |> IO.inspect()
    else
      {false, nil}
    end
  end

  def get_admin_staff() do
    check = Repo.all(from(r in Role, where: r.name == "Owner")) |> IO.inspect()

    if check == [] do
      {:ok, role} = create_role(%{name: "Owner", desc: "own and manage the company "})
      role
    else
      List.first(check)
    end
  end

  def populate_menus() do
    Repo.delete_all(AppRoute)
    Repo.delete_all(RoleAppRoute)
    role = get_admin_staff()

    menus = [
      %{
        path: "#",
        title: "Admin",
        icon: nil,
        children: [
          %{path: "/admin/staff", title: "Staff", icon: "camera-foto-solid"},
          %{path: "/admin/role", title: "Role", icon: "camera-foto-solid"},
          %{path: "/admin/app_route", title: "Route", icon: "camera-foto-solid"}
        ]
      },
      %{path: "/announcements", title: "Announcements", icon: "book-solid"},
      %{
        path: "#",
        title: "Commission",
        icon: nil,
        children: [
          %{path: "/rewards", title: "Commission", icon: "camera-foto-solid"}
        ]
      },
      %{
        path: "#",
        title: "GroupSales",
        icon: nil,
        children: [
          %{path: "/gs_summary", title: "GS Summary", icon: "book-solid"},
          %{path: "/group_sales_details", title: "GS Details", icon: "book-solid"}
        ]
      },
      %{path: "/sales", title: "Sales", icon: "book-solid"},
      %{path: "/products", title: "Product", icon: "book-solid"},
      %{path: "/users", title: "Users", icon: "book-solid"},
      %{path: "/ranks", title: "Rank", icon: "book-solid"},
      %{
        path: "#",
        title: "Ewallets",
        icon: nil,
        children: [
          %{path: "/ewallets/withdrawal_batches", title: "Withdrawal", icon: "camera-foto-solid"},
          %{path: "/ewallets", title: "Ewallets", icon: "book-solid"},
          %{path: "/ewallets/transfers", title: "Transfers", icon: "camera-foto-solid"},
          %{
            path: "/ewallets/register_points",
            title: "Register Points",
            icon: "camera-foto-solid"
          }
        ]
      }
    ]

    for menu <- menus do
      {:ok, route} =
        create_app_route(%{
          "name" => menu.title,
          "route" => menu.path,
          "icon" => menu.icon
        })

      RoleAppRoute.changeset(%RoleAppRoute{}, %{
        role_id: role.id,
        app_route_id: route.id
      })
      |> Repo.insert()

      children = Map.get(menu, :children, [])

      for child <- children do
        {:ok, croute} =
          create_app_route(%{
            "name" => child.title,
            "route" => child.path,
            "icon" => child.icon
          })

        RoleAppRoute.changeset(%RoleAppRoute{}, %{
          role_id: role.id,
          app_route_id: croute.id
        })
        |> Repo.insert()
      end
    end
  end

  def group_unpay_rewards() do
    query =
      Reward
      |> where([r], r.is_paid == ^false)
      |> group_by([r], [r.name, r.day, r.month, r.year])
      |> select([r], %{sum: sum(r.amount), name: r.name, day: r.day, month: r.month, year: r.year})
      |> order_by([r], [r.year, r.month, r.day])

    Repo.all(query)
  end
end
