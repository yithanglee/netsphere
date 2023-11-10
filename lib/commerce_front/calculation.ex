defmodule CommerceFront.Calculation do
  require Logger

  import Ecto.Query, warn: false
  alias CommerceFront.Repo
  require IEx
  alias Ecto.Multi

  @doc """


  find uplines,
  check upline rank,
  compress until the total_point_value is paid completely...

  """
  def sharing_bonus(username, total_point_value, sale, referral) do
    uplines = CommerceFront.Settings.check_uplines(username) |> Enum.with_index(1)

    matrix = [
      %{rank: "青铜套餐", l1: 0.2, calculated: false},
      %{rank: "银色套餐", l1: 0.2, l2: 0.1, calculated: false},
      %{rank: "黄金套餐", l1: 0.2, l2: 0.1, l3: 0.1, calculated: false}
    ]

    run_calc = fn {upline, index}, {calc_index, eval_matrix, remainder_point_value} ->
      user = CommerceFront.Settings.get_user_by_username(upline.parent)
      rank = user.rank_id |> CommerceFront.Settings.get_rank!() |> IO.inspect()

      calc_table =
        matrix
        |> Enum.filter(&(&1.rank == rank.name))
        |> List.first()

      perc =
        case calc_index do
          1 ->
            calc_table |> Map.get(:l1, 0)

          2 ->
            calc_table |> Map.get(:l2, 0)

          3 ->
            calc_table |> Map.get(:l3, 0)

          _ ->
            0
        end
        |> IO.inspect()

      with true <- calc_index < 4,
           list <-
             eval_matrix
             |> Enum.reject(&(&1.calculated == true))
             |> Enum.filter(&(&1.rank == rank.name)),
           true <- list != [],
           matrix_item <-
             list
             |> List.first(),
           calculated <-
             matrix_item
             |> Map.get(:calculated),
           true <- calculated == false do
        bonus = remainder_point_value * perc

        CommerceFront.Settings.create_reward(%{
          sales_id: sale.id,
          is_paid: false,
          remarks:
            "sales-#{sale.id}|#{remainder_point_value} * #{perc} = #{bonus}|lvl:#{index}/#{rank.name}",
          name: "sharing bonus",
          amount: bonus,
          user_id: user.id,
          day: Date.utc_today().day,
          month: Date.utc_today().month,
          year: Date.utc_today().year
        })

        new_matrix_item =
          matrix |> Enum.find(&(&1.rank == rank.name)) |> Map.put(:calculated, true)

        remove_index = matrix |> Enum.find_index(&(&1.rank == rank.name))

        pre_matrix = List.delete_at(matrix, 0)

        next_matrix = List.insert_at(pre_matrix, 0, new_matrix_item)

        # remainder_point_value - bonus
        {calc_index + 1, next_matrix, total_point_value}
      else
        _ ->
          {calc_index, eval_matrix, total_point_value}
      end
    end

    Enum.reduce(uplines, {1, matrix, total_point_value}, &run_calc.(&1, &2))

    {:ok, nil}
  end

  def team_bonus(username, total_point_value, sale, placement, pgsd) do
    multi = Multi.new()

    summaries = pgsd |> Map.values() |> Enum.map(& &1)

    calc_for_parent = fn map, multi_query ->
      summary = map.gs_summary |> Repo.preload(:user)

      if summary.user.username == "summer" do
        # IEx.pry()
      end

      with true <- summary.total_left != nil,
           true <- summary.total_left != 0,
           true <- summary.total_right != nil,
           true <- summary.total_right != 0 do
        IO.inspect([summary.total_left, summary.total_right])

        latest_gs =
          CommerceFront.Settings.get_latest_gs_summary_by_user_id(
            summary.user.id,
            Date.from_erl!({summary.year, summary.month, summary.day})
          )

        constant = summary.total_left / summary.total_right

        {paired, changeset} =
          if constant > 1 do
            # this means, the left is more than right

            if summary.total_left - summary.total_right < 0 do
              IEx.pry()
            end

            {total_point_value,
             %{
               balance_left: summary.total_left - summary.total_right,
               balance_right: summary.total_right - summary.total_right
             }}
          else
            if summary.total_right - summary.total_left < 0 do
              IEx.pry()
            end

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
            Logger.info("[team bonus] - after: #{map.after} - paired: #{paired}")

            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: map.after,
                after: map.after - paired,
                amount: -paired,
                from_user_id: 0,
                to_user_id: map.to_user_id,
                remarks: "pairing bonus calculation|from sale-#{sale.id}",
                sales_id: 0,
                position: "left"
              }
            )
          else
            Logger.info("[team bonus] - after: #{map.after} - paired: #{paired}")

            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: map.after,
                after: map.after - paired,
                amount: -paired,
                from_user_id: 0,
                to_user_id: map.to_user_id,
                remarks: "pairing bonus calculation|from sale-#{sale.id}",
                sales_id: 0,
                position: "right"
              }
            )
          end
          |> Repo.insert()
        end)
        |> Multi.run(String.to_atom("pgsd_right_#{summary.user_id}"), fn _repo, %{} ->
          if map.position == "left" do
            Logger.info("[team bonus] - after: #{map.after} - paired: #{paired}")

            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: map.after,
                after: map.after - paired,
                amount: -paired,
                from_user_id: 0,
                to_user_id: map.to_user_id,
                remarks: "pairing bonus calculation|from sale-#{sale.id}",
                sales_id: 0,
                position: "right"
              }
            )
          else
            Logger.info("[team bonus] - after: #{map.after} - paired: #{paired}")

            CommerceFront.Settings.PlacementGroupSalesDetail.changeset(
              %CommerceFront.Settings.PlacementGroupSalesDetail{},
              %{
                before: map.after,
                after: map.after - paired,
                amount: -paired,
                from_user_id: 0,
                to_user_id: map.to_user_id,
                remarks: "pairing bonus calculation|from sale-#{sale.id}",
                sales_id: 0,
                position: "left"
              }
            )
          end
          |> Repo.insert()
        end)
        |> Multi.run(String.to_atom("gs_summary_#{summary.user_id}"), fn _repo, %{} ->
          CommerceFront.Settings.update_group_sales_summary(summary, changeset)
        end)
        |> Multi.run(String.to_atom("bonus_#{summary.user_id}"), fn _repo, %{} ->
          bonus = paired * 0.1

          user = summary.user |> Repo.preload(:rank)
          rank = user |> Map.get(:rank)

          matrix = [
            %{rank: "青铜套餐", cap: 100},
            %{rank: "银色套餐", cap: 500},
            %{rank: "黄金套餐", cap: 1500}
          ]

          {{y, m, d}, _time} = NaiveDateTime.to_erl(sale.inserted_at)

          check =
            Repo.all(
              from(r in CommerceFront.Settings.Reward,
                where:
                  r.user_id == ^user.id and r.name == "team bonus" and
                    r.day == ^d and r.month == ^m and
                    r.year == ^y,
                select: r.amount
              )
            )
            |> Enum.sum()

          user_cap =
            matrix |> Enum.filter(&(&1.rank == rank.name)) |> List.first() |> Map.get(:cap)

          final_pay =
            if check <= user_cap do
              bonus
            else
              0
            end

          # todo: apply the reserve wallet
          CommerceFront.Settings.create_reward(%{
            sales_id: sale.id,
            is_paid: false,
            remarks:
              "sales-#{sale.id}|#{paired} * #{0.1} = #{bonus}|paid: #{check}|user_cap:#{user_cap}",
            name: "team bonus",
            amount: final_pay,
            user_id: map.to_user_id,
            day: d,
            month: m,
            year: y
          })
        end)
      else
        _ ->
          multi_query
      end
    end

    Enum.reduce(summaries, multi, &calc_for_parent.(&1, &2))
    |> Repo.transaction()
  end

  @doc """
  this is a monthly calculated,
  but we can always rerun it everyday after running contribute group sales, pairing bonus
  this require to check every user's group sales summary on the total left right accumulated in that month
  """
  def matching_bonus() do
  end
end
