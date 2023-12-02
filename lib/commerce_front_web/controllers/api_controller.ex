defmodule CommerceFrontWeb.ApiController do
  use CommerceFrontWeb, :controller

  alias CommerceFront.{Repo, Settings}

  def stream_get(conn, params) do
    final =
      case params["scope"] do
        _ ->
          rest_id = Map.get(params, "rest_id", 1)
          pid = Process.whereis(String.to_atom("rest_#{rest_id}"))

          if pid == nil do
            {:ok, pid} = Agent.start_link(fn -> [] end)
            Process.register(pid, String.to_atom("rest_#{rest_id}"))
          else
            IO.inspect("pid rest_#{rest_id} already exist")
          end

          %{status: "received"}
      end

    conn =
      conn
      |> put_resp_content_type("application/json")
      |> send_chunked(200)

    Enum.reduce_while(
      Stream.iterate(
        "",
        fn x ->
          Process.sleep(2000)
          CommerceFront.get_order() |> Jason.encode!()
        end
      ),
      conn,
      fn chunk, conn ->
        IO.inspect(chunk)

        case Plug.Conn.chunk(conn, chunk) do
          {:ok, conn} ->
            {:cont, conn}

          {:error, :closed} ->
            {:halt, conn}
        end
      end
    )
  end

  def decode_token(token) do
    Settings.decode_token(token)
  end

  def csrf(conn, params) do
    json(conn, Phoenix.Controller.get_csrf_token())
  end

  require IEx

  def get(conn, params) do
    token = params |> Map.get("token")

    %{id: id} =
      with true <- token != nil,
           decoded <- token |> decode_token,
           true <- decoded != nil do
        decoded
      else
        _ ->
          %{id: 0}
      end

    res =
      case params["scope"] do
        "get_reward_summary" ->
          Settings.user_monthly_reward_summary(params["user_id"])

        "get_sale" ->
          Settings.get_sale!(params["id"])
          |> BluePotion.sanitize_struct()

        "user_wallet" ->
          res =
            Settings.list_ewallets_by_user_id(id)
            |> Enum.map(&(&1 |> BluePotion.sanitize_struct()))

        "get_product" ->
          Settings.get_product!(params["id"]) |> BluePotion.sanitize_struct()

        "announcements" ->
          Settings.list_announcements() |> Enum.map(&(&1 |> BluePotion.sanitize_struct()))

        "check_bill" ->
          res =
            Billplz.get_bill(params["id"])
            |> IO.inspect()

          payment =
            Settings.get_payment_by_billplz_code(params["id"])
            |> IO.inspect()

          with true <- Map.get(res, "paid", false) == true,
               true <- payment != nil,
               true <- payment.sales != nil,
               sales <- payment.sales |> IO.inspect(),
               {:ok, register_params} <-
                 sales.registration_details |> Jason.decode() |> IO.inspect() do
            case Settings.register(register_params["user"], sales) do
              {:ok, multi_res} ->
                %{status: "ok", res: multi_res |> BluePotion.sanitize_struct()}

              _ ->
                %{status: "error"}
            end
          else
            _ ->
              with true <- payment != nil,
                   true <- payment.wallet_topup != nil do
                case Settings.approve_topup(%{"id" => payment.wallet_topup.id}) do
                  {:ok, tp} ->
                    %{status: "ok", res: tp |> BluePotion.sanitize_struct()}

                  _ ->
                    %{status: "error"}
                end
              else
                _ ->
                  %{status: "error"}
              end
          end

          res

        "node" ->
          if params["token"] != nil do
            if params["username"] == "damien" do
              %{
                icon: "fa fa-user text-success",
                id: "root",
                text: "root",
                children: [
                  %{id: "root1", text: "root1", children: true, icon: "fa fa-user"}
                ],
                type: "root"
              }
            else
              []
            end

            Settings.display_refer_tree(params["username"])
          else
            []
          end

        "get_ranks" ->
          Settings.list_ranks() |> Enum.map(&(&1 |> BluePotion.sanitize_struct()))

        "placement" ->
          Settings.display_place_tree(params["username"], params["full"])

        "referral" ->
          Settings.display_refer_tree(params["username"])

        "gen_inputs" ->
          BluePotion.test_module(params["module"])

        _ ->
          %{status: "ok"}
      end

    append_cache_request = fn conn ->
      # if conn.req_headers
      #    |> Enum.into(%{})
      #    |> Map.get("referer", "")
      #    |> String.contains?("admin") do
      #   conn
      # else
      #   conn
      #   |> put_resp_header("cache-control", "max-age=900, must-revalidate")
      # end

      conn
    end

    conn
    |> append_cache_request.()
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(res))
  end

  def payment(conn, params) do
    payment = Settings.get_payment_by_billplz_code(params["id"])

    res =
      with true <- params["paid"] == "true",
           true <- payment != nil,
           true <- payment.sales != nil,
           sales <- payment.sales,
           {:ok, register_params} <- sales.registration_details |> Jason.decode() do
        case Settings.register(register_params["user"], sales) do
          {:ok, multi_res} ->
            %{status: "ok", res: multi_res |> BluePotion.sanitize_struct()}

          _ ->
            %{status: "error"}
        end
      else
        _ ->
          with true <- payment.wallet_topup != nil do
            case Settings.approve_topup(%{"id" => payment.wallet_topup.id}) do
              {:ok, tp} ->
                %{status: "ok", res: tp |> BluePotion.sanitize_struct()}

              _ ->
                %{status: "error"}
            end
          else
            _ ->
              %{status: "ok"}
          end
      end

    sample = %{
      "amount" => "500000",
      "collection_id" => "greljvdq",
      "due_at" => "2023-11-18",
      "email" => "a@1.com",
      "id" => "ywkq6y7x",
      "mobile" => "",
      "name" => "1",
      "paid" => "true",
      "paid_amount" => "500000",
      "paid_at" => "2023-11-18 16:16:29 +0800",
      "state" => "paid",
      "url" => "https://www.billplz-sandbox.com/bills/ywkq6y7x",
      "x_signature" => "20fe8afe691277badffd74ad3bbeaafe6f54b5c502ed91bd557b88678338b627"
    }

    json(conn, res)
  end

  def post(conn, params) do
    res =
      case params["scope"] do
        "approve_topup" ->
          case Settings.approve_topup(params) do
            {:ok, multi_res} ->
              %{status: "ok"}

            {:error, "already approved"} ->
              %{status: "error", reason: "already approved"}

            _ ->
              %{status: "error", reason: "unknown"}
          end

        "manual_approve_fpx" ->
          with payment <-
                 Settings.get_payment_by_billplz_code(params["id"]),
               true <- payment != nil,
               true <- payment.sales != nil,
               sales <- payment.sales,
               {:ok, register_params} <- sales.registration_details |> Jason.decode() do
            case Settings.register(register_params["user"], sales) do
              {:ok, multi_res} ->
                %{status: "ok", res: multi_res |> BluePotion.sanitize_struct()}

              _ ->
                %{status: "error"}
            end
          else
            _ ->
              %{status: "ok"}
          end

        "sign_in" ->
          # admin login
          token =
            Phoenix.Token.sign(
              CommerceFrontWeb.Endpoint,
              "admin_signature",
              params["username"]
            )

          %{status: "ok", res: token}

        "topup" ->
          case Settings.create_topup_transaction(params) do
            {:ok, multi_res} ->
              %{status: "ok", res: multi_res.payment |> BluePotion.sanitize_struct()}

            _ ->
              %{status: "error"}
          end

        "redeem" ->
          # get the billplz link first, then make payment
          # create the sales first
          # Settings.register(params["user"])
          case Settings.create_sales_transaction(params) |> IO.inspect() do
            {:ok, multi_res} ->
              %{status: "ok", res: multi_res.payment |> BluePotion.sanitize_struct()}

            {:error, :payment, "not sufficient", passed_cg} ->
              %{status: "error", reason: "wallet balance not sufficient"}

            _ ->
              %{status: "error"}
          end

        "upgrade" ->
          # get the billplz link first, then make payment
          # create the sales first
          # Settings.register(params["user"])
          case Settings.create_sales_transaction(params) |> IO.inspect() do
            {:ok, multi_res} ->
              %{status: "ok", res: multi_res.payment |> BluePotion.sanitize_struct()}

            {:error, :payment, "not sufficient", passed_cg} ->
              %{status: "error", reason: "wallet balance not sufficient"}

            _ ->
              %{status: "error"}
          end

        "register" ->
          # get the billplz link first, then make payment
          # create the sales first
          # Settings.register(params["user"])
          case Settings.create_sales_transaction(params) |> IO.inspect() do
            {:ok, multi_res} ->
              %{status: "ok", res: multi_res.payment |> BluePotion.sanitize_struct()}

            {:error, :payment, "not sufficient", passed_cg} ->
              %{status: "error", reason: "wallet balance not sufficient"}

            _ ->
              %{status: "error"}
          end

        "login" ->
          auth = Settings.auth_user(params["user"]) |> IO.inspect()

          case auth do
            {:ok, user} ->
              %{
                status: "ok",
                res:
                  user
                  |> BluePotion.sanitize_struct()
                  |> Map.put(:token, Settings.member_token(user.id))
              }

            _ ->
              %{status: "error"}
          end

        _ ->
          %{status: "ok"}
      end

    json(conn, res)
  end

  def print_pdf(conn, params) do
    check = File.exists?(File.cwd!() <> "/media")
    filename = params["filename"]

    path =
      if check do
        File.cwd!() <> "/media"
      else
        File.mkdir(File.cwd!() <> "/media")
        File.cwd!() <> "/media"
      end

    server_url = Application.get_env(:commerce_front, :endpoint)[:url]
    IO.inspect(server_url)

    {:ok, html} = File.read("#{path}/#{filename}.html")

    html =
      html
      |> String.replace("\"/images", "\"#{server_url}/images")
      |> String.replace("\'/images", "\'#{server_url}/images")

    host = conn.req_headers |> Enum.into(%{}) |> Map.get("host")

    css = """

    <link rel="stylesheet" type="text/css" href="#{server_url}/sticky/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="#{server_url}/sticky/styles/style.css">
    """

    pdf_params = %{
      "html" => "<!DOCTYPE html><html><head>#{css}</head><body>#{html}</body></html>"
    }

    # pdf_params = %{"html" => html}
    IO.inspect(pdf_params)
    IO.puts(pdf_params["html"])

    pdf_binary =
      PdfGenerator.generate_binary!(
        pdf_params["html"],
        size: "A4",
        shell_params: [
          "--page-width",
          "100cm",
          "--margin-left",
          "5",
          "--margin-right",
          "5",
          "--margin-top",
          "5",
          "--margin-bottom",
          "5",
          "--encoding",
          "utf-8",
          "--orientation",
          "Portrait"
        ],
        delete_temporary: true
      )

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"#{params["title"]}.pdf\""
    )
    |> send_resp(200, pdf_binary)
  end

  def append_params(params) do
    parent_id = Map.get(params, "parent_id")

    params =
      if parent_id != nil do
        params
        |> Map.put(
          "parent_id",
          CommerceFront.Settings.decode_corporate_account_token(parent_id).id
        )
      else
        params
      end

    password = Map.get(params, "password")

    params =
      if password != nil do
        crypted_password = :crypto.hash(:sha512, password) |> Base.encode16() |> String.downcase()

        params
        |> Map.put(
          "crypted_password",
          crypted_password
        )
      else
        params
      end

    IO.inspect("appended")
    IO.inspect(params)

    params
  end

  def form_submission(conn, params) do
    model = Map.get(params, "model")
    params = Map.delete(params, "model")

    upcase? = fn x -> x == String.upcase(x) end

    sanitized_model =
      model
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(
        &if upcase?.(&1), do: String.replace(&1, &1, "_#{String.downcase(&1)}"), else: &1
      )
      |> Enum.join("")
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> List.pop_at(0)
      |> elem(1)
      |> Enum.join()

    IO.inspect(params)
    json = %{}
    config = Application.get_env(:blue_potion, :contexts)

    mods =
      if config == nil do
        ["Settings", "Secretary"]
      else
        config
      end

    struct =
      for mod <- mods do
        Module.concat([Application.get_env(:blue_potion, :otp_app), mod, model])
      end
      |> Enum.filter(&Code.ensure_compiled?(&1))
      |> List.first()

    IO.inspect(struct)

    mod =
      struct
      |> Module.split()
      |> Enum.take(2)
      |> Module.concat()

    IO.inspect(mod)

    dynamic_code =
      if Map.get(params, model) |> Map.get("id") != "0" do
        """
        struct = #{mod}.get_#{sanitized_model}!(params["id"])
        #{mod}.update_#{sanitized_model}(struct, params)
        """
      else
        """
        #{mod}.create_#{sanitized_model}(params)
        """
      end

    p = Map.get(params, model)

    p =
      case model do
        c when c in ["CorporateAccount"] ->
          case p["id"] |> Integer.parse() do
            :error ->
              {:ok, map} =
                Phoenix.Token.verify(
                  CommerceFrontWeb.Endpoint,
                  "corporate_account_signature",
                  p["id"]
                )

              p = Map.put(p, "id", map.id)

              append_params(p)

            _ ->
              append_params(p)
          end

        # c when c in ["Blog", "Shop", "Announcement"] ->
        #   case p["corporate_account_id"] |> Integer.parse() do
        #     :error ->
        #       {:ok, map} =
        #         Phoenix.Token.verify(
        #           CommerceFrontWeb.Endpoint,
        #           "corporate_account_signature",
        #           p["corporate_account_id"]
        #         )

        #       p = Map.put(p, "corporate_account_id", map.id)

        #       append_params(p)

        #     _ ->
        #       append_params(p)
        #   end

        "CorporateTopup" ->
          cond do
            p["corporate_account_id"] != nil ->
              if p["corporate_account_id"] |> Integer.parse() == :error do
                {:ok, map} =
                  Phoenix.Token.verify(
                    CommerceFrontWeb.Endpoint,
                    "corporate_account_signature",
                    p["corporate_account_id"]
                  )

                p = Map.put(p, "corporate_account_id", map.id)

                append_params(p)
              else
                p
              end

            p["id"] != "" ->
              p
          end

        "User" ->
          case p["id"] |> Integer.parse() do
            :error ->
              {:ok, map} = Phoenix.Token.verify(CommerceFrontWeb.Endpoint, "signature", p["id"])
              Map.put(p, "id", map.id)

            _ ->
              p
          end

        _ ->
          p
      end

    {result, _values} = Code.eval_string(dynamic_code, params: p |> CommerceFront.upload_file())

    IO.inspect(result)

    case result do
      {:ok, item} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(BluePotion.sanitize_struct(item)))

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = changeset.errors |> Keyword.keys()

        {reason, message} = changeset.errors |> hd()
        {proper_message, message_list} = message
        final_reason = Atom.to_string(reason) <> " " <> proper_message

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{status: final_reason}))
    end
  end

  require IEx

  def datatable(conn, params) do
    decode_token = fn params ->
      customer_id = Map.get(params, "user_id")

      params =
        if customer_id != nil do
          params
          |> Map.put(
            "user_id",
            CommerceFront.Settings.decode_token(customer_id)
          )
        else
          params
        end
    end

    model = Map.get(params, "model")
    preloads = Map.get(params, "preloads")
    additional_search_queries = Map.get(params, "additional_search_queries")
    additional_join_statements = Map.get(params, "additional_join_statements") |> IO.inspect()
    params = Map.delete(params, "model") |> Map.delete("preloads") |> Map.delete("host")

    params =
      decode_token.(params)
      |> IO.inspect()

    additional_join_statements =
      if additional_join_statements == nil do
        ""
      else
        joins = additional_join_statements |> Poison.decode!() |> IO.inspect()

        for join <- joins do
          key = Map.keys(join) |> List.first()
          value = join |> Map.get(key)
          # module = Module.concat(["Church", "Settings", key])

          config = Application.get_env(:blue_potion, :contexts)

          mods =
            if config == nil do
              ["Settings", "Secretary"]
            else
              config
            end

          struct =
            for mod <- mods do
              Module.concat([Application.get_env(:blue_potion, :otp_app), mod, key])
            end
            |> Enum.filter(&(elem(Code.ensure_compiled(&1), 0) == :module))
            |> List.first()

          "|> join(:left, [a], b in assoc(a, :#{key}))"
        end
        |> Enum.join("")
        |> IO.inspect()
      end

    additional_search_queries =
      if additional_search_queries == nil do
        ""
      else
        columns = additional_search_queries |> String.split(",")

        for {item, index} <- columns |> Enum.with_index() do
          cond do
            item |> String.contains?("!=") ->
              [i, val] = item |> String.split("!=")

              """
              |> where([a,b,c,d], a.#{i} != "#{val}") 
              """

            item |> String.contains?("_id^") ->
              item = item |> String.replace("^", "")
              [_prefix, i] = item |> String.split(".")
              ss = params["search"]["value"]

              if ss != "" do
                case Integer.parse(ss) do
                  {ss, _} ->
                    """
                    |> where([a,b,c,d], a.#{i} == ^"#{ss}") 
                    """

                  _ ->
                    """
                    |> where([a,b,c,d], a.#{i} == ^"#{ss}") 
                    """
                end
              end

            item |> String.contains?("^") ->
              item = item |> String.replace("^", "")
              [prefix, i] = item |> String.split(".")
              ss = params["search"]["value"]

              if ss != "" do
                """
                |> where([a,b,c,d],  ilike(#{prefix}.#{i}, ^"%#{ss}%") ) 
                """
              end

            true ->
              ss = params["search"]["value"]
              items = String.split(item, "|") |> IO.inspect()
              # ["a.name", "b.username", "a.is_paid"]

              subquery =
                for i <- items do
                  if i |> String.contains?(".") do
                    [prefix, i] = i |> String.split(".")
                    # if possible, here need to add back the previous and statements
                    [i, value] =
                      if i |> String.contains?("=") do
                        [i, value] = String.split(i, "=")
                      else
                        [i, ""]
                      end

                    ss =
                      if value != "" do
                        value
                      else
                        ss
                      end

                    check_id = fn tuple ->
                      if tuple |> is_tuple do
                        {prefix, i, ss} = tuple

                        if i |> String.contains?("_id") do
                          case Integer.parse(ss) do
                            {ss, _val} ->
                              """
                              #{prefix}.#{i} == ^#{ss}
                              """

                            _ ->
                              """
                              ilike(a.#{i}, ^"%#{ss}%")
                              """
                          end
                        else
                          with true <- i |> String.contains?("id"),
                               false <- i |> String.contains?("uuid"),
                               false <- i |> String.contains?("paid"),
                               false <- i |> String.contains?("is_") do
                            case Integer.parse(ss) do
                              {ss, _val} ->
                                """
                                #{prefix}.#{i} == ^#{ss}
                                """

                              _ ->
                                """
                                ilike(a.#{i}, ^"%#{ss}%")
                                """
                            end
                          else
                            _ ->
                              tuple
                          end
                        end
                      else
                        tuple
                      end
                    end

                    check_date = fn tuple ->
                      if tuple |> is_tuple do
                        {prefix, i, ss} = tuple

                        if i == "date" do
                          """
                          #{prefix}.#{i} == ^"#{ss}"
                          """
                        else
                          tuple
                        end
                      else
                        tuple
                      end
                    end

                    check_bool = fn tuple ->
                      if tuple |> is_tuple do
                        {prefix, i, ss} = tuple

                        if ss == "true" || ss == "false" do
                          """
                          a.#{i} == ^#{ss}
                          """
                        else
                          if ss == nil do
                            """
                            """
                          else
                            """
                            ilike(#{prefix}.#{i}, ^"%#{ss}%")
                            """
                          end
                        end
                      else
                        tuple
                      end
                    end

                    check_id.({prefix, i, ss})
                    |> check_date.()
                    |> check_bool.()
                  else
                    [i, value] =
                      if i |> String.contains?("=") do
                        [i, value] = String.split(i, "=")
                      else
                        [i, ""]
                      end

                    ss =
                      if value != "" do
                        value
                      else
                        ss
                      end

                    unless i |> String.contains?("_id") do
                      if ss == "true" || ss == "false" do
                        """
                        a.#{i} == ^#{ss}
                        """
                      else
                        """
                        ilike(a.#{i}, ^"%#{ss}%")
                        """
                      end
                    else
                      case Integer.parse(ss) do
                        {ss, _val} ->
                          """
                          a.#{i} == ^#{ss}
                          """

                        _ ->
                          if ss == "true" || ss == "false" do
                            """
                            a.#{i} == ^#{ss}
                            """
                          else
                            """
                            ilike(a.#{i}, ^"%#{ss}%")
                            """
                          end
                      end
                    end
                  end
                end
                |> Enum.reject(&(&1 == nil))
                |> Enum.reject(&(&1 == ""))
                |> Enum.join(" and ")
                |> IO.inspect()

              with true <- subquery != "",
                   true <- ss != nil do
                """
                |> or_where([a,b,c,d], #{subquery})
                """
              else
                _ ->
                  nil
              end
          end
        end
        |> Enum.reject(&(&1 == nil))
        |> Enum.join("")
      end
      |> IO.inspect()

    preloads =
      if preloads == nil do
        preloads = []
      else
        IO.inspect("preload ")

        preloads
        |> Poison.decode!()
        |> Enum.map(&(&1 |> BluePotion.convert_to_atom()))
      end
      |> List.flatten()

    IO.inspect(preloads)

    json =
      BluePotion.post_process_datatable(
        params,
        Module.concat(["CommerceFront", "Settings", model]),
        additional_join_statements,
        additional_search_queries,
        preloads
      )

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(json))
  end

  def delete_data(conn, params) do
    model = Map.get(params, "model")
    params = Map.delete(params, "model")

    upcase? = fn x -> x == String.upcase(x) end

    sanitized_model =
      model
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(
        &if upcase?.(&1), do: String.replace(&1, &1, "_#{String.downcase(&1)}"), else: &1
      )
      |> Enum.join("")
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> List.pop_at(0)
      |> elem(1)
      |> Enum.join()

    IO.inspect(params)
    json = %{}

    config = Application.get_env(:blue_potion, :contexts)

    mods =
      if config == nil do
        ["Settings", "Secretary"]
      else
        config
      end

    struct =
      for mod <- mods do
        Module.concat([Application.get_env(:blue_potion, :otp_app), mod, model])
      end
      |> Enum.filter(&({:error, :nofile} != Code.ensure_compiled(&1)))
      |> List.first()

    IO.inspect(struct)

    mod =
      struct
      |> Module.split()
      |> Enum.take(2)
      |> Module.concat()

    IO.inspect(mod)

    dynamic_code = """
    struct = #{mod}.get_#{sanitized_model}!(params["id"])
    #{mod}.delete_#{sanitized_model}(struct)
    """

    {result, _values} = Code.eval_string(dynamic_code, params: params)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "already deleted"}))
  end
end
