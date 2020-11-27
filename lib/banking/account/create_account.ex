defmodule Banking.CreateAccount do
  @moduledoc """
  Creating a new account
  """

  import Ecto.Changeset

  alias Banking.{Account, Repo}

  def run(params) do
    %Account{}
    |> cast(params, [:user_id])
    |> foreign_key_constraint(:user_id)
    |> Repo.insert()
  end
end
