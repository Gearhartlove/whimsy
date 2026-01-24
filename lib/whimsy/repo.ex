defmodule Whimsy.Repo do
  use Ecto.Repo,
    otp_app: :whimsy,
    adapter: Ecto.Adapters.Postgres
end
