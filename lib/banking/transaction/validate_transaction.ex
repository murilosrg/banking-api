defmodule Banking.ValidateTransaction do
  @moduledoc """
  transaction validations
  """

  alias Banking.{AccountBalance, FindAccount, Repo, TransferTransaction, WithdrawalTransaction}
  alias Ecto.Multi

  def valid_transaction?(account, value) do
    case valid_balance?(account, value) do
      true -> {:ok, account}
      _ -> {:error}
    end
  end

  def debit_from_account(account, amount) do
    Multi.new()
    |> Multi.run(:transaction, fn _, _ ->
      WithdrawalTransaction.run(%{amount: amount, account_from: account.id})
    end)
    |> Multi.run(:account, fn _, _ ->
      AccountBalance.debit(account, amount)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, response} ->
        {:ok, response}

      {:error, _, value, _} ->
        {:error, value}
    end
  end

  def transfer_to_account(account_from, email, amount) do
    account_to = FindAccount.run(email)

    Multi.new()
    |> Multi.run(:transaction, fn _, _ ->
      TransferTransaction.run(%{
        "amount" => amount,
        "account_from" => account_from.id,
        "account_to" => account_to.id
      })
    end)
    |> Multi.run(:transfer_account_to, fn _, _ -> AccountBalance.credit(account_to, amount) end)
    |> Multi.run(:transfer_account_from, fn _, _ -> AccountBalance.debit(account_from, amount) end)
    |> Repo.transaction()
    |> case do
      {:ok, response} ->
        {:ok, response.transfer_account_from}

      {:error, _, value, _} ->
        {:error, value}
    end
  end

  defp valid_balance?(account, amount) do
    {:ok, decimal} = Decimal.cast(amount)

    Decimal.sub(account.balance, decimal)
    |> Decimal.compare(0)
    |> case do
      :gt -> true
      :eq -> true
      _ -> false
    end
  end
end
