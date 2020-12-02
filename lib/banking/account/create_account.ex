defmodule Banking.CreateAccount do
  @moduledoc """
  Creating a new account
  """

  import Ecto.Changeset
  alias Ecto.Multi
  alias Banking.{Account, CreateUser, Repo}

  def run(attrs) do
    Multi.new()
    |> Multi.run(:user, fn _, _ -> CreateUser.run(Map.put(attrs, "employee", false)) end)
    |> Multi.run(:account, fn _, %{user: user} ->
      attrs = Map.put(attrs, "user_id", user.id)
      create_account(attrs)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, response} ->
        {:ok, response}

      {:error, _, value, _} ->
        {:error, value}
    end
  end

  defp create_account(params) do
    %Account{}
    |> cast(params, [:user_id])
    |> foreign_key_constraint(:user_id)
    |> Repo.insert()
  end
end
