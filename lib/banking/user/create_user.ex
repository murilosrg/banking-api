defmodule Banking.CreateUser do
  @moduledoc """
  Creating a new user
  """
  import Ecto.Changeset

  alias Banking.{User, Repo}

  def run(params) do
    %User{}
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_password()
    |> Repo.insert()
  end

  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset
end
