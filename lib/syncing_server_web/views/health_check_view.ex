defmodule SyncingServerWeb.HealthCheckView do
  use SyncingServerWeb, :view

  def render("healthcheck.txt", %{status: status}) do
    status
  end
end
