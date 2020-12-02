defmodule Banking.AccountBalance do
  @moduledoc """
  Creating a new account
  """

  import Ecto.Changeset
  alias Banking.Repo

  def debit(account, amount) do
    {:ok, decimal} = Decimal.cast(amount)

    account
    |> change(%{balance: Decimal.sub(account.balance, decimal)})
    |> Repo.update()
  end

  def credit(account, amount) do
    {:ok, decimal} = Decimal.cast(amount)

    account
    |> change(%{balance: Decimal.add(account.balance, decimal)})
    |> Repo.update()
  end
end
