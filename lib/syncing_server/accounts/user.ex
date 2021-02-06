defmodule SyncingServer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :kp_created, :string
    field :kp_origination, :string
    field :locked_until, :utc_datetime
    field :num_failed_attempts, :integer
    field :pw_alg, :string
    field :pw_cost, :integer
    field :pw_func, :string
    field :pw_key_size, :integer
    field :pw_nonce, :string
    field :pw_salt, :string
    field :updated_with_user_agent, :string
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:version, :email, :pw_nonce, :kp_created, :kp_origination, :pw_cost, :pw_key_size, :pw_salt, :pw_alg, :pw_func, :encrypted_password, :locked_until, :num_failed_attempts, :updated_with_user_agent])
    |> validate_required([:version, :email, :pw_nonce, :kp_created, :kp_origination, :pw_cost, :pw_key_size, :pw_salt, :pw_alg, :pw_func, :encrypted_password, :locked_until, :num_failed_attempts, :updated_with_user_agent])
  end
end