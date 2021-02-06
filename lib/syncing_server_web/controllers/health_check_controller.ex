defmodule SyncingServerWeb.HealthCheckController do
  use SyncingServerWeb, :controller

  action_fallback SyncingServerWeb.FallbackController

  def do_it(conn, _params) do
    render(conn, "healthcheck.txt", status: "OK")
  end
end
