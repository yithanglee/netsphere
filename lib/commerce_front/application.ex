defmodule CommerceFront.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do


    source =
      {:service_account,
       File.read!("#{Application.app_dir(:commerce_front) <> "/priv/static"}/service-account.json")
       |> Jason.decode!()}


    children = [

      {Goth, name: CommerceFront.Goth, source: source},
      # {CommerceFront.Queue, []},
      CommerceFront.Repo,
      # Start the Telemetry supervisor
      CommerceFrontWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CommerceFront.PubSub},
      # Start the Endpoint (http/https)
      CommerceFrontWeb.Endpoint,
      CommerceFront.Scheduler
      # Start a worker by calling: CommerceFront.Worker.start_link(arg)
      # {CommerceFront.Worker, arg}
    ]

    {:ok, pid} = Agent.start_link(fn -> %{} end)
    Process.register(pid, :kv)
    path = File.cwd!() <> "/media"

    if File.exists?(path) == false do
      File.mkdir(File.cwd!() <> "/media")
    end

    File.rm_rf("#{Application.app_dir(:commerce_front)}/priv/static/images/uploads")

    File.ln_s(
      "#{File.cwd!()}/media/",
      "#{Application.app_dir(:commerce_front)}/priv/static/images/uploads"
    )

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CommerceFront.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CommerceFrontWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
