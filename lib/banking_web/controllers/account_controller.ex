defmodule BankingWeb.AccountController do
  use BankingWeb, :controller
  alias Banking.CreateAccount

  action_fallback(BankingWeb.FallbackController)

  def create(conn, params) do
    with {:ok, %{account: account, user: user}} <-
           CreateAccount.run(params) do
      conn
      |> put_status(:created)
      |> render("account.json", %{account: account, user: user})
    end
  end
end
