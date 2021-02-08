defmodule SyncingServerWeb.UserControllerTest do
  use SyncingServerWeb.ConnCase

  alias SyncingServer.Accounts
  alias SyncingServer.Accounts.User

  @create_attrs %{
    email: "some email",
    encrypted_password: "some encrypted_password",
    kp_created: "some kp_created",
    kp_origination: "some kp_origination",
    locked_until: "2010-04-17T14:00:00Z",
    num_failed_attempts: 42,
    pw_alg: "some pw_alg",
    pw_cost: 42,
    pw_func: "some pw_func",
    pw_key_size: 42,
    pw_nonce: "some pw_nonce",
    pw_salt: "some pw_salt",
    updated_with_user_agent: "some updated_with_user_agent",
    version: "some version"
  }
  @update_attrs %{
    email: "some updated email",
    encrypted_password: "some updated encrypted_password",
    kp_created: "some updated kp_created",
    kp_origination: "some updated kp_origination",
    locked_until: "2011-05-18T15:01:01Z",
    num_failed_attempts: 43,
    pw_alg: "some updated pw_alg",
    pw_cost: 43,
    pw_func: "some updated pw_func",
    pw_key_size: 43,
    pw_nonce: "some updated pw_nonce",
    pw_salt: "some updated pw_salt",
    updated_with_user_agent: "some updated updated_with_user_agent",
    version: "some updated version"
  }
  @invalid_attrs %{
    email: nil,
    encrypted_password: nil,
    kp_created: nil,
    kp_origination: nil,
    locked_until: nil,
    num_failed_attempts: nil,
    pw_alg: nil,
    pw_cost: nil,
    pw_func: nil,
    pw_key_size: nil,
    pw_nonce: nil,
    pw_salt: nil,
    updated_with_user_agent: nil,
    version: nil
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some email",
               "encrypted_password" => "some encrypted_password",
               "kp_created" => "some kp_created",
               "kp_origination" => "some kp_origination",
               "locked_until" => "2010-04-17T14:00:00Z",
               "num_failed_attempts" => 42,
               "pw_alg" => "some pw_alg",
               "pw_cost" => 42,
               "pw_func" => "some pw_func",
               "pw_key_size" => 42,
               "pw_nonce" => "some pw_nonce",
               "pw_salt" => "some pw_salt",
               "updated_with_user_agent" => "some updated_with_user_agent",
               "version" => "some version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "some updated email",
               "encrypted_password" => "some updated encrypted_password",
               "kp_created" => "some updated kp_created",
               "kp_origination" => "some updated kp_origination",
               "locked_until" => "2011-05-18T15:01:01Z",
               "num_failed_attempts" => 43,
               "pw_alg" => "some updated pw_alg",
               "pw_cost" => 43,
               "pw_func" => "some updated pw_func",
               "pw_key_size" => 43,
               "pw_nonce" => "some updated pw_nonce",
               "pw_salt" => "some updated pw_salt",
               "updated_with_user_agent" => "some updated updated_with_user_agent",
               "version" => "some updated version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
