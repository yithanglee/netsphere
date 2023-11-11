defmodule CommerceFront.Calculation do
  require Logger

  import Ecto.Query, warn: false
  alias CommerceFront.Repo
  require IEx
  alias Ecto.Multi
  alias CommerceFront.Settings
  alias CommerceFront.Settings.{User, Reward}

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
  def matching_bonus(month, year) do
    date = Date.from_erl!({year, month, 1})

    subquery = """
    select
      u.username,
      r.user_id,
      sum(r.amount),
      r.month,
      r.year
    from
      rewards r
    left join users u on
      u.id = r.user_id
    where
      r.name = 'team bonus'
      and r.month = $1
      and r.year = $2
    group by
      u.username,
      r.user_id,
      r.month,
      r.year;
    """

    {:ok, %Postgrex.Result{columns: columns, rows: rows} = res} =
      Ecto.Adapters.SQL.query(Repo, subquery, [month, year])

    team_bonuses =
      for row <- rows do
        Enum.zip(columns |> Enum.map(&(&1 |> String.to_atom())), row) |> Enum.into(%{})
      end

    subquery2 = """
    select
    sum(gss.new_left) as left,
    sum(gss.new_right) as right,
    u.username,
    gss.user_id ,
    gss.month,
    gss.year
    from
    group_sales_summaries gss
    left join users u on u.id = gss.user_id
    where 
    gss.month = $1
    and gss.year = $2
    group by
    u.username, 
    gss.user_id,
    gss.month,
    gss.year ;
    """

    {:ok, %Postgrex.Result{columns: columns, rows: rows} = res} =
      Ecto.Adapters.SQL.query(Repo, subquery2, [month, year])

    users_weak_leg =
      for row <- rows do
        Enum.zip(columns |> Enum.map(&(&1 |> String.to_atom())), row) |> Enum.into(%{})
      end

    Repo.delete_all(
      from(r in Reward,
        where: r.name == ^"matching bonus" and r.month == ^month and r.year == ^year
      )
    )

    users = Repo.all(from(u in User, order_by: [desc: u.id]))

    Multi.new()
    |> Multi.run(:calculation, fn _repo, %{} ->
      for user <- users do
        uplines = Settings.check_uplines(user.username)
        # check user has team bonus

        check = team_bonuses |> Enum.filter(&(&1.user_id == user.id)) |> List.first()

        calc = fn upline, index ->
          nil

          weak_leg =
            users_weak_leg |> Enum.filter(&(&1.user_id == upline.parent_id)) |> List.first()

          weak_amount =
            if weak_leg.left > weak_leg.right do
              weak_leg.right
            else
              weak_leg.left
            end

          matrix = [
            %{amount: 500, l1: 0.1},
            %{amount: 1000, l1: 0.1, l2: 0.1},
            %{amount: 1500, l1: 0.1, l2: 0.1, l3: 0.1}
          ]

          map = Enum.filter(matrix, &(&1.amount <= weak_amount)) |> List.last()

          if map != nil do
            if index < 4 do
              constant =
                case index do
                  1 ->
                    map |> Map.get(:l1, 0)

                  2 ->
                    map |> Map.get(:l2, 0)

                  3 ->
                    map |> Map.get(:l3, 0)

                  _ ->
                    0
                end

              bonus = check.sum * constant

              CommerceFront.Settings.create_reward(%{
                sales_id: 0,
                is_paid: false,
                remarks:
                  "#{check.sum} * #{constant} = #{bonus}|lvl:#{index}|#{user.username}: #{check.sum}|#{weak_leg.username} leg: #{weak_leg.left}|#{weak_leg.right}",
                name: "matching bonus",
                amount: bonus,
                user_id: upline.parent_id,
                day: Timex.end_of_month(date).day,
                month: month,
                year: year
              })
            end

            index + 1
          else
            index
          end

          # check upline's weak leg 
        end

        if check != nil do
          Enum.reduce(uplines, 1, &calc.(&1, &2))
        end
      end

      {:ok, nil}
    end)
    |> Repo.transaction()
  end

  @doc """
  D）Elite Leader CTO sharing 5%
  Ever month weak team pv achieved 
  1,500PV-1star-1%
  3,000PV-2stars-1%+1%
  10,000PV-3stars-1%+1%+1%
  30,000PV-4stars-1%+1%+1%+1%
  50,000PV-5stars-1%+1%+1%+1%+1%


  each weak leg will be given 1% from current month sales PV

  """

  def elite_leader(month, year) do
    date = Date.from_erl!({year, month, 1})

    subquery = """

    select sum(s.total_point_value) from sales s where s.month = $1 and s.year = $2 group by s.month , s.year;
    """

    {:ok, %Postgrex.Result{columns: columns, rows: rows} = res} =
      Ecto.Adapters.SQL.query(Repo, subquery, [month, year])

    monthly_sales =
      for row <- rows do
        Enum.zip(columns |> Enum.map(&(&1 |> String.to_atom())), row) |> Enum.into(%{})
      end
      |> List.first()
      |> IO.inspect()

    Repo.delete_all(
      from(r in Reward,
        where: r.name == ^"elite leader" and r.month == ^month and r.year == ^year
      )
    )

    subquery2 = """
    select
    sum(gss.new_left) as left,
    sum(gss.new_right) as right,
    u.username,
    gss.user_id ,
    gss.month,
    gss.year
    from
    group_sales_summaries gss
    left join users u on u.id = gss.user_id
    where 
    gss.month = $1
    and gss.year = $2
    group by
    u.username, 
    gss.user_id,
    gss.month,
    gss.year ;
    """

    {:ok, %Postgrex.Result{columns: columns, rows: rows} = res} =
      Ecto.Adapters.SQL.query(Repo, subquery2, [month, year])

    users_weak_leg =
      for row <- rows do
        Enum.zip(columns |> Enum.map(&(&1 |> String.to_atom())), row) |> Enum.into(%{})
      end

    Repo.delete_all(
      from(r in Reward,
        where: r.name == ^"elite leader" and r.month == ^month and r.year == ^year
      )
    )

    Multi.new()
    |> Multi.run(:calculation, fn _repo, %{} ->
      total_sales_pv = monthly_sales.sum
      # 8k

      # 1star pool = 8k * 0.01  ?

      matrix = [
        %{name: "1star", qualify: 1500},
        %{name: "2star", qualify: 3000},
        %{name: "3star", qualify: 10000},
        %{name: "4star", qualify: 30000},
        %{name: "5star", qualify: 50000}
      ]

      for %{name: star_name, qualify: amount} = star <- matrix do
        one_star_qualifier =
          for weak_leg <- users_weak_leg do
            weak_amount =
              if weak_leg.left > weak_leg.right do
                weak_leg.right
              else
                weak_leg.left
              end

            if weak_amount > amount do
              weak_leg
            else
              nil
            end
          end
          |> Enum.reject(&(&1 == nil))

        count = Enum.count(one_star_qualifier)

        if count > 0 do
          one_star_amount = total_sales_pv * 0.01 / count

          for weak_leg <- one_star_qualifier do
            weak_amount =
              if weak_leg.left > weak_leg.right do
                weak_leg.right
              else
                weak_leg.left
              end

            CommerceFront.Settings.create_reward(%{
              sales_id: 0,
              is_paid: false,
              remarks:
                "#{total_sales_pv} * 0.01/ #{count} = #{one_star_amount}|weak_leg: #{weak_amount}|pool qualifiers: #{count}|#{star_name}",
              name: "elite leader",
              amount: one_star_amount,
              user_id: weak_leg.user_id,
              day: Timex.end_of_month(date).day,
              month: month,
              year: year
            })
          end
        end
      end

      {:ok, nil}
    end)
    |> Repo.transaction()
  end

  def travel_fund(month, year) do
    date = Date.from_erl!({year, month, 1})

    subquery2 = """
    select
    sum(gss.new_left) as left,
    sum(gss.new_right) as right,
    u.username,
    gss.user_id ,
    gss.month,
    gss.year
    from
    group_sales_summaries gss
    left join users u on u.id = gss.user_id
    where 
    gss.month = $1
    and gss.year = $2
    group by
    u.username, 
    gss.user_id,
    gss.month,
    gss.year ;
    """

    {:ok, %Postgrex.Result{columns: columns, rows: rows} = res} =
      Ecto.Adapters.SQL.query(Repo, subquery2, [month, year])

    users_weak_leg =
      for row <- rows do
        Enum.zip(columns |> Enum.map(&(&1 |> String.to_atom())), row) |> Enum.into(%{})
      end

    matrix = [
      %{point: 1, amount: 1500},
      %{point: 3, amount: 3000},
      %{point: 6, amount: 5000}
    ]

    Repo.delete_all(
      from(r in Reward,
        where: r.name == ^"travel fund" and r.month == ^month and r.year == ^year
      )
    )

    Multi.new()
    |> Multi.run(:calculation, fn _repo, %{} ->
      travel_qualifier =
        for weak_leg <- users_weak_leg do
          weak_amount =
            if weak_leg.left > weak_leg.right do
              weak_leg.right
            else
              weak_leg.left
            end

          map = Enum.filter(matrix, &(&1.amount <= weak_amount)) |> List.last()

          if map != nil do
            CommerceFront.Settings.create_reward(%{
              sales_id: 0,
              is_paid: false,
              remarks: "#{weak_leg.username} leg: #{weak_leg.left}|#{weak_leg.right}",
              name: "travel fund",
              amount: map.point,
              user_id: weak_leg.user_id,
              day: Timex.end_of_month(date).day,
              month: month,
              year: year
            })
          end
        end

      {:ok, nil}
    end)
    |> Repo.transaction()
  end
end
