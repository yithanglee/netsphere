defmodule CommerceFront.Authorization do
  use Phoenix.Controller, namespace: CommerceFrontWeb
  import Plug.Conn
  require IEx

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    if conn.request_path |> String.contains?("/admin") do
      if conn.private.plug_session["current_user"] == nil do
        cond do
          conn.request_path |> String.contains?("/login") ->
            conn

          conn.request_path |> String.contains?("/logout") ->
            conn

          conn.request_path |> String.contains?("/authenticate") ->
            conn

          true ->
            conn
            |> put_flash(:error, "You haven't login.")
            |> redirect(to: "/admin/login")
            |> halt
        end
      else
        conn
      end
    else
      if conn.request_path |> String.contains?("/0") do
        conn
        |> put_flash(:error, "Unauthorized.")
        |> redirect(to: "/admin")
        |> halt
      else
        conn
      end
    end
  end
end

defmodule CommerceFront.ApiAuthorization do
  use Phoenix.Controller, namespace: CommerceFrontWeb
  import Plug.Conn
  require IEx

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    if conn.method == "POST" do
      cond do
        conn.params["scope"] in ["update_customer", "food_payment", "customer_topup"] ->
          conn

        Plug.Conn.get_req_header(conn, "phx-request") != [] ->
          conn

        Plug.Conn.get_req_header(conn, "referer") |> List.first() != nil ->
          conn

        true ->
          with auth_token <- Plug.Conn.get_req_header(conn, "authorization") |> List.first(),
               true <- auth_token != nil,
               token <- auth_token |> String.split("Basic ") |> List.last(),
               t <- CommerceFront.Settings.decode_token(token),
               true <- t != nil do
            conn
          else
            _ ->
              IO.inspect("not auth")

              conn
              |> resp(500, Jason.encode!(%{message: "Not authorized."}))
              |> halt
          end
      end
    else
      conn
    end
  end
end
