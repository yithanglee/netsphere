defmodule CommerceFrontWeb.PageController do
  use CommerceFrontWeb, :controller

  def index(conn, _params) do
    IO.inspect("it's reloading!")
    render(conn, "index.html")
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def authenticate(conn, params) do
    case check_password(params) do
      {true, user} ->
        conn
        |> put_session(:current_user, BluePotion.s_to_map(user))
        |> redirect(to: "/home")

      _ ->
        conn
        |> redirect(to: "/login")
    end
  end

  def check_password(params) do
    # your auth method here

    user = CommerceFront.Settings.get_user_by_username(params["username"])

    if user != nil do
      crypted_password =
        :crypto.hash(:sha512, params["password"]) |> Base.encode16() |> String.downcase()

      {crypted_password == user.crypted_password, user}
    else
      false
    end
  end

  def thank_you(conn, params) do
    IO.inspect("it's reloading!")
    render(conn, "thank_you.html", params)
  end
end
