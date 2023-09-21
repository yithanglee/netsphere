defmodule CommerceFrontWeb.PageController do
  use CommerceFrontWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
