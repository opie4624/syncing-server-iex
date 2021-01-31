defmodule SyncingServerWeb.UserView do
  use SyncingServerWeb, :view
  alias SyncingServerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      version: user.version,
      email: user.email,
      pw_nonce: user.pw_nonce,
      kp_created: user.kp_created,
      kp_origination: user.kp_origination,
      pw_cost: user.pw_cost,
      pw_key_size: user.pw_key_size,
      pw_salt: user.pw_salt,
      pw_alg: user.pw_alg,
      pw_func: user.pw_func,
      encrypted_password: user.encrypted_password,
      locked_until: user.locked_until,
      num_failed_attempts: user.num_failed_attempts,
      updated_with_user_agent: user.updated_with_user_agent}
  end
end
