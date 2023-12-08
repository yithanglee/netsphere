defmodule CommerceFrontWeb.Router do
  use CommerceFrontWeb, :router

  if Mix.env() == :dev do
    # If using Phoenix
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  @content_security_policy (case Mix.env() do
                              # :prod  -> "default-src 'self'"

                              # _ -> "default-src 'self' 'unsafe-eval'"

                              _ ->
                                "default-src 'self' 'unsafe-inline' fonts.gstatic.com; img-src 'self' blob data: ; style-src 'self' 'unsafe-inline' fonts.googleapis.com fonts.gstatic.com;"
                            end)
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    # plug :put_secure_browser_headers, %{"content-security-policy" => @content_security_policy}
  end

  pipeline :plain_api do
    plug :accepts, ["json"]
  end

  pipeline :svt_api do
    plug :accepts, ["json"]

    plug CORSPlug,
      origin: [
        "f770-115-164-46-61.ngrok-free.app",
        "https://fonts.gstatic.com",
        "https://svt.damienslab.com",
        "http://svt.damienslab.com",
        "http://localhost:5173"
      ]

    plug(CommerceFront.ApiAuthorization)
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery

    plug CORSPlug,
      origin: [
        "2cb0-115-164-216-41.ngrok-free.app",
        "f770-115-164-46-61.ngrok-free.app",
        "https://fonts.gstatic.com",
        "https://svt.damienslab.com",
        "http://svt.damienslab.com",
        "http://localhost:5173"
      ]

    plug(CommerceFront.ApiAuthorization)
  end

  scope "/svt_api", CommerceFrontWeb do
    pipe_through :svt_api
    get "/stream", ApiController, :stream_get
    options("/:webhook", ApiController, :get)

    get "/webhook", ApiController, :get
    post "/webhook", ApiController, :post
    options("/:model", ApiController, :datatable)
    get("/:model", ApiController, :datatable)
    post("/:model", ApiController, :form_submission)
    options("/:model/:id", ApiController, :delete_data)
    delete("/:model/:id", ApiController, :delete_data)
  end

  scope "/api", CommerceFrontWeb do
    pipe_through :plain_api

    post "/payment/billplz", ApiController, :payment
  end

  scope "/api", CommerceFrontWeb do
    pipe_through :api
    get "/stream", ApiController, :stream_get
    options("/:webhook", ApiController, :get)

    get "/webhook", ApiController, :get
    post "/webhook", ApiController, :post
    options("/:model", ApiController, :datatable)
    get("/:model", ApiController, :datatable)
    post("/:model", ApiController, :form_submission)
    delete("/:model/:id", ApiController, :delete_data)
  end

  scope "/", CommerceFrontWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/log2in", PageController, :login
    post "/auth", PageController, :authenticate
    get "/thank_you", PageController, :thank_you
    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CommerceFrontWeb do
  #   pipe_through :api
  # end
end
