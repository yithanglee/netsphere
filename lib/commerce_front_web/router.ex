defmodule CommerceFrontWeb.Router do
  use CommerceFrontWeb, :router

  @content_security_policy (case Mix.env() do
                              # :prod  -> "default-src 'self'"

                              # _ -> "default-src 'self' 'unsafe-eval'"

                              _ ->
                                "default-src 'self' 'unsafe-inline' fonts.gstatic.com; img-src 'self' data: ; style-src 'self' fonts.googleapis.com fonts.gstatic.com;"
                            end)
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => @content_security_policy}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CommerceFrontWeb do
    pipe_through :api
    get "/stream", ApiController, :stream_get

    get "/webhook", ApiController, :get
    post "/webhook", ApiController, :post
  end

  scope "/", CommerceFrontWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CommerceFrontWeb do
  #   pipe_through :api
  # end
end
