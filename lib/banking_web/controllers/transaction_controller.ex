defmodule BankingWeb.TransactionController do
  use BankingWeb, :controller

  alias BankingWeb.Guardian
  alias Banking.{Mailer, Repo, ValidateTransaction, WithdrawalEmail}

  action_fallback BankingWeb.FallbackController

  def withdrawal(conn, %{"amount" => amount}) do
    user =
      Guardian.Plug.current_resource(conn)
      |> Repo.preload(:account)

    case ValidateTransaction.valid_transaction?(user.account, amount) do
      {:ok, account} ->
        {:ok, updated} = ValidateTransaction.debit_from_account(account, amount)

        {:ok, decimal} = Decimal.cast(amount)
        email = WithdrawalEmail.create(user.email, decimal)
        Mailer.deliver_now(email)

        conn
        |> render("account.json", %{account: updated.account})

      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("422.json", %{message: "insuficient funds"})
    end
  end

  def transfer(conn, %{"amount" => amount, "account" => email}) do
    user =
      Guardian.Plug.current_resource(conn)
      |> Repo.preload(:account)

    case ValidateTransaction.valid_transaction?(user.account, amount) do
      {:ok, account} ->
        {:ok, updated} = ValidateTransaction.transfer_to_account(account, email, amount)

        conn
        |> render("account.json", %{account: updated})

      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("422.json", %{message: "insuficient funds"})
    end
  end
end
