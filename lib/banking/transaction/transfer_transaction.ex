defmodule Banking.TransferTransaction do
  @moduledoc """
  Creating a transfer transaction
  """

  import Ecto.Changeset

  alias Banking.{Repo, Transaction}

  def run(params) do
    %Transaction{type: 1}
    |> cast(params, [:amount, :account_from, :account_to])
    |> validate_required([:amount, :account_from, :account_to])
    |> foreign_key_constraint(:account_from)
    |> Repo.insert()
  end
end
