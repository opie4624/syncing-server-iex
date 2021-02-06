defmodule SyncServerWeb.AuthController do
  use SyncingServerWeb, :controller

  alias SyncingServer.Accounts
  alias SyncingServer.Accounts.User

  action_fallback SyncingServerWeb.FallbackController

  def params(conn, _params) do
    nil
  end

  def sign_in(conn, _params) do
    nil
  end

  def sign_out(conn, _params) do
    nil
  end

  def register(conn, _params) do
    nil
  end

  def update(conn, _params) do
    nil
  end

  def change_pw(conn, _params) do
    nil
  end
end
