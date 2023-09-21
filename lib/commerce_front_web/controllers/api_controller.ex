defmodule CommerceFrontWeb.ApiController do
  use CommerceFrontWeb, :controller

  def get(conn, params) do
    res = 
    case params["scope"] do
     _ ->
       %{status: "ok"} 
    end
    json(conn, res )
  end
end
