defmodule SyncingServerWeb.AuthController do
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

  def register(conn, %{
        "email" => email,
        "password" => password,
        "pw_nonce" => pw_nonce,
        "version" => version
      })
      when version == "003" do
    {:ok, user} =
      Accounts.create_user(%{
        email: email,
        encrypted_password: password,
        pw_nonce: pw_nonce,
        version: version
      })
  end

  def register(conn, %{
        "identifier" => identifier,
        "password" => password,
        "version" => version
      })
      when version == "004 " do
    {:ok, user} =
      Accounts.create_user(
        {%{
           email: identifer,
           encrypted_password: password,
           version: version
         }}
      )
  end

  def update(conn, _params) do
    nil
  end

  def change_pw(conn, _params) do
    nil
  end
end
