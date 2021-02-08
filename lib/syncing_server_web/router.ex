defmodule SyncingServerWeb.Router do
  use SyncingServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SyncingServerWeb do
    pipe_through :api

    get "/healthcheck", HealthCheckController, :do_it

    scope "/auth" do
      post "/", AuthController, :register
      get "/params", AuthController, :params
      post "/sign_in", AuthController, :sign_in
      post "/sign_out", AuthController, :sign_out
      post "/update", AuthController, :update
      post "/change_pw", AuthController, :change_pw
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  import Phoenix.LiveDashboard.Router

  scope "/admin" do
    pipe_through [:fetch_session, :protect_from_forgery]

    live_dashboard "/dashboard",
      metrics: SyncingServerWeb.Telemetry,
      ecto_repos: [SyncingServer.Repo]

    resources "/users", UserController, except: [:new, :edit]
  end
end
