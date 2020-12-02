defmodule Banking.CreateAccount do
  @moduledoc """
  Creating a new account
  """

  import Ecto.Changeset

  alias Banking.{Account, CreateUser, Repo}

  def run(params) do
    case create_user(params) do
      {:ok, user} ->
        create_account(%{user_id: user.id})

      {:error, _} ->
        {:error, :error_creating_user}
    end
  end

  defp create_user(params) do
    Map.merge(params, %{employee: false})
    |> CreateUser.run()
  end

  defp create_account(params) do
    %Account{}
    |> cast(params, [:user_id])
    |> foreign_key_constraint(:user_id)
    |> Repo.insert()
    |> Ecto.assoc(:user)
  end
end
