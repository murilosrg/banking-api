defmodule Banking.UserRepo do
  @moduledoc """
  User repository
  """

  alias Banking.{Repo, User}

  def get_user!(email) do
    Repo.get_by!(User, email: email)
  end
end
