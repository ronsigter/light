defmodule Light.Repo do
  use Ecto.Repo,
    otp_app: :light,
    adapter: Ecto.Adapters.Postgres
end
