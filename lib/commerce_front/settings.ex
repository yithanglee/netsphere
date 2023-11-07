defmodule CommerceFront.Settings do
  @moduledoc """
  The Settings context.
  """
  require Logger
  import Mogrify
  import Ecto.Query, warn: false
  alias CommerceFront.Repo
  require IEx
  alias Ecto.Multi
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

  def get_latest_gs_summary_by_user_id(user_id) do
    Repo.all(
      from(gss in GroupSalesSummary,
        where:
          gss.user_id == ^user_id and
            gss.day == ^Date.utc_today().day and gss.month == ^Date.utc_today().month and
            gss.year == ^Date.utc_today().year
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

  def create_placement_group_sales_detail(params \\ %{}) do
    Multi.new()
    |> Multi.run(:gsd, fn _repo, %{} ->
      PlacementGroupSalesDetail.changeset(%PlacementGroupSalesDetail{}, params)
      |> Repo.insert()
    end)
    |> Multi.run(:gs_summary, fn _repo, %{gsd: gsd} ->
      check = get_latest_gs_summary_by_user_id(gsd.to_user_id)

      case check do
        nil ->
          map =
            if gsd.position == "left" do
              %{
                total_left: gsd.amount,
                total_right: 0
              }
            else
              %{
                total_left: 0,
                total_right: gsd.amount
              }
            end

          create_group_sales_summary(
            %{
              total_left: 0,
              total_right: 0,
              user_id: gsd.to_user_id,
              day: Date.utc_today().day,
              month: Date.utc_today().month,
              year: Date.utc_today().year
            }
            |> Map.merge(map)
          )

        _ ->
          map =
            if gsd.position == "left" do
              %{
                total_left: check.total_left + gsd.amount
              }
            else
              %{
                total_right: check.total_right + gsd.amount
              }
            end

          update_group_sales_summary(
            check,
            %{
              user_id: gsd.to_user_id,
              day: Date.utc_today().day,
              month: Date.utc_today().month,
              year: Date.utc_today().year
            }
            |> Map.merge(map)
          )
      end
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
    Repo.get!(Sale, id)
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

  def decode_customer_token(token) do
    case Phoenix.Token.verify(CommerceFrontWeb.Endpoint, "member_signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  def auth_user(params) do
    user =
      Repo.all(from(u in User, where: u.username == ^params["username"]))
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

    User.changeset(model, attrs) |> Repo.update() |> IO.inspect()
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
            %{total_left: 0, total_right: 0, balance_left: 0, balance_right: 0}
          end

        Repo.get_by(Placement, user_id: res.id)
        |> Repo.preload(:user)
        |> BluePotion.sanitize_struct()
        |> Map.merge(%{
          total_left: gs_summary.total_left,
          total_right: gs_summary.total_right,
          balance_left: gs_summary.balance_left,
          balance_right: gs_summary.balance_right
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
    display_tree(username, list, [], :referral, false)
  end

  def display_place_tree(username) do
    list = check_downlines(username)
    display_tree(username, list, [], :placement, false)
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

  def display_tree(
        username \\ "damien",
        ori_data,
        transformed_children \\ [],
        tree \\ :placement,
        include_empty \\ true
      ) do
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
          balance_right
        ] = list |> String.split("|")

        zchildren =
          if include_empty do
            [%{id: 0, name: "~"}, %{id: 0, name: "~"}]
          else
            []
          end

        %{
          value:
            %{
              username: username,
              left: left |> String.to_integer(),
              right: right |> String.to_integer(),
              total_left: total_left || 0,
              total_right: total_right || 0,
              balance_left: balance_left || 0,
              balance_right: balance_right || 0,
              position: position
            }
            |> Jason.encode!(),
          left: left |> String.to_integer(),
          right: right |> String.to_integer(),
          total_left: total_left || 0,
          total_right: total_right || 0,
          balance_left: balance_left || 0,
          balance_right: balance_right || 0,
          name: username,
          children: zchildren,
          username: username,
          id: id |> String.to_integer(),
          fullname: fullname,
          position: position
        }
      else
        [username, id, fullname] = list |> String.split("|")

        zchildren =
          if include_empty do
            []
          else
            []
          end

        %{
          icon: "fa fa-user text-info",
          name: username <> " #{id}",
          text: """
          <span class='my-2'>
            <span class='p-1 my-2'>#{username}</span>
            <span class='m-0 px-1 ' style="width: 50%;position: absolute;right: 0px;">id: #{id}</span>
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
      |> Enum.map(&(&1 |> to_map.()))

    map = ori_data |> Enum.filter(&(&1.parent_username == username)) |> List.first()

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
          balance_right
        ] = list

        map = ori_data |> Enum.filter(&(&1.parent_username == username)) |> List.first()

        display_tree(username, ori_data, transformed_children)
      else
        [username, id, fullname] = list

        map = ori_data |> Enum.filter(&(&1.parent_username == username)) |> List.first()

        display_tree(username, ori_data, transformed_children, :referral)
      end
    end

    children =
      if map != nil do
        if Enum.count(map.children) < 2 do
          l =
            map.children
            |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))

          if tree == :placement do
            l ++ [%{id: 0, name: "~", position: "left"}]
          else
            l
          end
        else
          map.children |> Enum.map(&(&1 |> String.split("|") |> transform.(ori_data)))
        end
      else
        []
      end

    if map == nil do
      transformed_children |> Enum.filter(&(&1.username == username)) |> List.first()
    else
      smap = transformed_children |> Enum.filter(&(&1.username == username)) |> List.first()

      if tree == :placement do
        smap =
          if smap == nil do
            get_placement_by_username(map.parent_username)
          else
            smap
          end
          |> IO.inspect()

        %{
          id: map.parent_id,
          value:
            %{
              username: map.parent_username,
              position: if(smap != nil, do: smap.position, else: "n/a"),
              left: if(smap != nil, do: smap.left, else: "n/a"),
              right: if(smap != nil, do: smap.right, else: "n/a"),
              total_left: if(smap != nil, do: smap.total_left, else: "n/a"),
              total_right: if(smap != nil, do: smap.total_right, else: "n/a"),
              balance_left: if(smap != nil, do: smap.balance_left, else: "n/a"),
              balance_right: if(smap != nil, do: smap.balance_right, else: "n/a")
            }
            |> Jason.encode!(),
          name: map.parent_username,
          position: if(smap != nil, do: smap.position, else: "n/a"),
          left: if(smap != nil, do: smap.left, else: "n/a"),
          right: if(smap != nil, do: smap.right, else: "n/a"),
          total_left: if(smap != nil, do: smap.total_left, else: "n/a"),
          total_right: if(smap != nil, do: smap.total_right, else: "n/a"),
          balance_left: if(smap != nil, do: smap.balance_left, else: "n/a"),
          balance_right: if(smap != nil, do: smap.balance_right, else: "n/a"),
          children: children |> Enum.sort_by(& &1.position)
        }
      else
        smap =
          if smap == nil do
            get_referral_by_username(map.parent_username)
          else
            smap
          end

        %{
          icon: "fa fa-user text-success",
          text: """
          <span class='my-2'>
            <span class='p-1 my-2'>#{username}</span>
            <span class='m-0 px-1 ' style="width: 50%;position: absolute;right: 0px;">id: #{map.parent_id}</span>
          </span>
          """,
          id: map.parent_id,
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
      IO.inspect(item)
      uplines = CommerceFront.Settings.check_uplines(item.user.username) |> IO.inspect()

      for upline <- uplines do
        p = CommerceFront.Settings.get_placement!(upline.pt_parent_id) |> Repo.preload(:user)
        c = CommerceFront.Settings.get_placement!(upline.pt_child_id) |> Repo.preload(:user)

        if p.user.username == "damien" do
          # IEx.pry()
        end

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

        CommerceFront.Settings.Placement.changeset(p, changes) |> Repo.update() |> IO.inspect()
      end
    end
  end

  def latest_group_sales_details(username, position) do
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

  def contribute_group_sales(from_username, amount, sales, placement, prev_multi \\ nil) do
    from_user = get_user_by_username(from_username)

    add_gs = fn upline, multi_query ->
      multi_query
      |> Multi.run(String.to_atom("parent_#{upline.parent}"), fn _repo, %{} ->
        latest = latest_group_sales_details(upline.parent, upline.pt_position)
        # position has to be the first upline's position 
        IO.inspect(upline.pt_position)
        IO.inspect(placement.position)

        case latest do
          nil ->
            create_placement_group_sales_detail(%{
              before: 0,
              after: amount,
              amount: amount,
              from_user_id: from_user.id,
              to_user_id: upline.parent_id,
              position: upline.pt_position,
              sales_id: sales.id,
              remarks: "from sales-#{sales.id}"
            })

          _ ->
            create_placement_group_sales_detail(%{
              before: latest.after,
              after: latest.after + amount,
              amount: amount,
              from_user_id: from_user.id,
              to_user_id: upline.parent_id,
              position: upline.pt_position,
              sales_id: sales.id,
              remarks: "from sales-#{sales.id}"
            })
        end

        # find the latest group sales details
        # create group sales details
      end)
    end

    uplines = check_uplines(from_username) |> IO.inspect()

    if prev_multi != nil do
      multi = prev_multi
      Enum.reduce(uplines, multi, &add_gs.(&1, &2))
    else
      multi = Multi.new()

      Enum.reduce(uplines, multi, &add_gs.(&1, &2))
      |> Repo.transaction()
    end
  end

  def update_placement_position_counter(placement, position, amount) do
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
        tree = CommerceFront.Settings.display_place_tree(sponsor_username)

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

  def register(params) do
    multi =
      Multi.new()
      |> Multi.run(:user, fn _repo, %{} ->
        create_user(params)
      end)
      |> Multi.run(:ewallets, fn _repo, %{user: user} ->
        nil
        # create_ewallet(%{user_id: user.id, wallet_type: "bonus", total: 0})
        # create_ewallet(%{user_id: user.id, wallet_type: "product", total: 0})
        # create_ewallet(%{user_id: user.id, wallet_type: "register", total: 0})
        # create_ewallet(%{user_id: user.id, wallet_type: "direct_recruitment", total: 0})
      end)
      |> Multi.run(:sale, fn _repo, %{user: user} ->
        rank = get_rank!(params["rank_id"])

        create_sale(%{
          month: Date.utc_today().month,
          year: Date.utc_today().year,
          sale_date: Date.utc_today(),
          status: :processing,
          subtotal: rank.retail_price,
          total_point_value: rank.point_value,
          user_id: user.id
        })
      end)
      |> Multi.run(:referral, fn _repo, %{user: user} ->
        parent_r = get_referral_by_username(params["sponsor"])

        create_referral(%{
          parent_user_id: parent_r.user_id,
          parent_referral_id: parent_r.id,
          user_id: user.id
        })
      end)
      |> Multi.run(:placement, fn _repo, %{user: user} ->
        # parent_p = get_placement_by_username(params["sponsor"])
        {position, parent_p} = determine_position(params["sponsor"])

        create_placement(%{
          parent_user_id: parent_p.user_id,
          parent_placement_id: parent_p.id,
          position: position,
          user_id: user.id
        })
      end)
      |> Multi.run(:pgsd, fn _repo, %{user: user, sale: sale, placement: placement} ->
        contribute_group_sales(user.username, sale.total_point_value, sale, placement)
      end)
      |> Multi.run(:team_bonus, fn _repo,
                                   %{pgsd: pgsd, user: user, sale: sale, placement: placement} ->
        team_bonus(user.username, sale.total_point_value, sale, placement, pgsd)
      end)
      |> Repo.transaction()
      |> IO.inspect()
      |> case do
        {:ok, multi_res} ->
          placement_counter_reset()
          {:ok, multi_res |> Map.get(:user)}

        _ ->
          {:error, []}
      end
  end

  def team_bonus(username, total_point_value, sale, placement, pgsd) do
    multi = Multi.new()

    summaries = pgsd |> Map.values() |> Enum.map(& &1)

    calc_for_parent = fn map, multi_query ->
      summary = map.gs_summary |> Repo.preload(:user)
      # IEx.pry()

      with true <- summary.total_left != nil,
           true <- summary.total_left != 0,
           true <- summary.total_right != nil,
           true <- summary.total_right != 0 do
        IO.inspect([summary.total_left, summary.total_right])

        constant =
          if summary.total_left > summary.total_right do
            summary.total_left / summary.total_right
          else
            summary.total_right / summary.total_left
          end

        {paired, changeset} =
          if constant > 1 do
            # this means, the left is more than right
            {total_point_value,
             %{
               balance_left: summary.total_left - summary.total_right,
               balance_right: summary.total_right - summary.total_right
             }}
          else
            {total_point_value,
             %{
               balance_left: summary.total_left - summary.total_left,
               balance_right: summary.total_right - summary.total_left
             }}
          end
          |> IO.inspect()

        multi_query
        |> Multi.run(String.to_atom("pgsd_left_#{summary.user_id}"), fn _repo, %{} ->
          if map.position == "left" do
            if map.after - paired < 0 do
              Logger.info("[team bonus] - after: #{map.after} - paired: #{paired}")
            end

            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: map.after,
                after: map.after - paired,
                amount: paired,
                from_user_id: 0,
                to_user_id: map.to_user_id,
                remarks: "pairing bonus calculation",
                sales_id: 0,
                position: "left"
              }
            )
          else
            if map.after - paired < 0 do
              Logger.info("[team bonus] - after: #{map.after} - paired: #{paired}")
            end

            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: map.after,
                after: map.after - paired,
                amount: paired,
                from_user_id: 0,
                to_user_id: map.to_user_id,
                remarks: "pairing bonus calculation",
                sales_id: 0,
                position: "right"
              }
            )
          end
          |> Repo.insert()
        end)
        |> Multi.run(String.to_atom("gs_summary_#{summary.user_id}"), fn _repo, %{} ->
          update_group_sales_summary(summary, changeset)
        end)
      else
        _ ->
          multi_query
      end
    end

    Enum.reduce(summaries, multi, &calc_for_parent.(&1, &2))
    |> Repo.transaction()
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
        |> select([m, pt, m2], %{
          child_id: m.id,
          child: m.username,
          pt_child_id: pt.id,
          pt_parent_id: pt.parent_referral_id,
          parent: m2.username,
          parent_id: m2.id
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
    |> where([m, pt, m2], m.id <= ^child_user_id)
    |> where([m, pt, m2], not is_nil(m2.id))
    |> select_statement.()
    |> order_by([m, pt, m2], desc: m.id)
    |> Repo.all()
  end

  def check_downlines(parent_username, tree \\ :placement) do
    parent_user = get_user_by_username(parent_username)
    parent_user_id = parent_user.id

    module =
      if tree == :placement do
        Placement
      else
        Referral
      end

    select_statement = fn query ->
      if tree == :placement do
        query
        |> select([m, pt, m2, gss], %{
          children:
            fragment(
              "ARRAY_AGG( CONCAT(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) )",
              m.username,
              "|",
              m.id,
              "|",
              m.fullname,
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
              gss.balance_right
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
              "ARRAY_AGG( CONCAT(?, ?, ?, ?, ?) )",
              m.username,
              "|",
              m.id,
              "|",
              m.fullname
            ),
          parent: m2.fullname,
          parent_username: m2.username,
          parent_id: m2.id
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
    |> where([m, pt, m2], m.id > ^parent_user_id)
    |> where([m, pt, m2, gss], not is_nil(m2.id))
    |> group_by([m, pt, m2, gss], [m2.id])
    |> select_statement.()
    |> Repo.all()
    |> IO.inspect()
  end

  def gs_subquery() do
    from(gss in GroupSalesSummary,
      where:
        gss.day == ^Date.utc_today().day and gss.month == ^Date.utc_today().month and
          gss.year == ^Date.utc_today().year
    )
  end

  def reset do
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
end
