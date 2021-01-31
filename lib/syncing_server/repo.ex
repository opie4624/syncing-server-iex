defmodule SyncingServer.Repo do
  use Ecto.Repo,
    otp_app: :syncing_server,
    adapter: Ecto.Adapters.Postgres
end
