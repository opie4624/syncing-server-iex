defmodule SyncingServer.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :version, :string
      add :email, :string
      add :pw_nonce, :string
      add :kp_created, :string
      add :kp_origination, :string
      add :pw_cost, :integer
      add :pw_key_size, :integer
      add :pw_salt, :string
      add :pw_alg, :string
      add :pw_func, :string
      add :encrypted_password, :string
      add :locked_until, :utc_datetime
      add :num_failed_attempts, :integer
      add :updated_with_user_agent, :string

      timestamps()
    end
  end
end
