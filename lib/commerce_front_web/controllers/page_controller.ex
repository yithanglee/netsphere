defmodule CommerceFrontWeb.PageController do
  use CommerceFrontWeb, :controller

  def index(conn, _params) do
    IO.inspect("it's reloading!")
    render(conn, "index.html")
  end
end
