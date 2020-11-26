defmodule Banking.CreateUser do
  @moduledoc """
  Creating a new user
  """
  import Ecto.Changeset

  alias Banking.{User, Repo}

  def run(params) do
    %User{}
    |> cast(params, [:name, :email, :password, :employee])
    |> validate_required([:name, :email, :password, :employee])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6, max: 20)
    |> put_password()
    |> Repo.insert()
  end

  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset
end
