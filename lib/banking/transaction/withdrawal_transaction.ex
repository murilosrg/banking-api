defmodule Banking.WithdrawalTransaction do
  @moduledoc """
  Creating a withdrawal transaction
  """

  import Ecto.Changeset

  alias Banking.{Repo, Transaction}

  def run(params) do
    %Transaction{type: 2}
    |> cast(params, [:amount, :account_from])
    |> validate_required([:amount, :account_from])
    |> foreign_key_constraint(:account_from)
    |> Repo.insert()
  end
end
