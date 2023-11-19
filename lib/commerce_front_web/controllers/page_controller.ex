defmodule CommerceFrontWeb.PageController do
  use CommerceFrontWeb, :controller

  def index(conn, _params) do
    IO.inspect("it's reloading!")
    render(conn, "index.html")
  end

  def thank_you(conn, params) do
    IO.inspect("it's reloading!")
    render(conn, "thank_you.html", params)
  end
end
