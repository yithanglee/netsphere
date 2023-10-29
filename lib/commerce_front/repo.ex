defmodule CommerceFront.Repo do
  use Ecto.Repo,
    otp_app: :commerce_front,
    adapter: Ecto.Adapters.Postgres
end
