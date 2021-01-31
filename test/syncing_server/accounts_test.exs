defmodule SyncingServer.AccountsTest do
  use SyncingServer.DataCase

  alias SyncingServer.Accounts

  describe "users" do
    alias SyncingServer.Accounts.User

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password", kp_created: "some kp_created", kp_origination: "some kp_origination", locked_until: "2010-04-17T14:00:00Z", num_failed_attempts: 42, pw_alg: "some pw_alg", pw_cost: 42, pw_func: "some pw_func", pw_key_size: 42, pw_nonce: "some pw_nonce", pw_salt: "some pw_salt", updated_with_user_agent: "some updated_with_user_agent", version: "some version"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password", kp_created: "some updated kp_created", kp_origination: "some updated kp_origination", locked_until: "2011-05-18T15:01:01Z", num_failed_attempts: 43, pw_alg: "some updated pw_alg", pw_cost: 43, pw_func: "some updated pw_func", pw_key_size: 43, pw_nonce: "some updated pw_nonce", pw_salt: "some updated pw_salt", updated_with_user_agent: "some updated updated_with_user_agent", version: "some updated version"}
    @invalid_attrs %{email: nil, encrypted_password: nil, kp_created: nil, kp_origination: nil, locked_until: nil, num_failed_attempts: nil, pw_alg: nil, pw_cost: nil, pw_func: nil, pw_key_size: nil, pw_nonce: nil, pw_salt: nil, updated_with_user_agent: nil, version: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password == "some encrypted_password"
      assert user.kp_created == "some kp_created"
      assert user.kp_origination == "some kp_origination"
      assert user.locked_until == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert user.num_failed_attempts == 42
      assert user.pw_alg == "some pw_alg"
      assert user.pw_cost == 42
      assert user.pw_func == "some pw_func"
      assert user.pw_key_size == 42
      assert user.pw_nonce == "some pw_nonce"
      assert user.pw_salt == "some pw_salt"
      assert user.updated_with_user_agent == "some updated_with_user_agent"
      assert user.version == "some version"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.encrypted_password == "some updated encrypted_password"
      assert user.kp_created == "some updated kp_created"
      assert user.kp_origination == "some updated kp_origination"
      assert user.locked_until == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert user.num_failed_attempts == 43
      assert user.pw_alg == "some updated pw_alg"
      assert user.pw_cost == 43
      assert user.pw_func == "some updated pw_func"
      assert user.pw_key_size == 43
      assert user.pw_nonce == "some updated pw_nonce"
      assert user.pw_salt == "some updated pw_salt"
      assert user.updated_with_user_agent == "some updated updated_with_user_agent"
      assert user.version == "some updated version"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
