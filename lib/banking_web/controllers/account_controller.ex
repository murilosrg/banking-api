defmodule BankingWeb.AccountController do
  use BankingWeb, :controller
  alias Banking.CreateAccount

  action_fallback(BankingWeb.FallbackController)

  def create(conn, params) do
    account =
      params
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    with {:ok, account, _} <- CreateAccount.run(account) do
      render(conn, "account.json", %{account: account})
    end
  end
end
