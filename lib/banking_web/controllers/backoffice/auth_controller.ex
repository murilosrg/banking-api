defmodule BankingWeb.Backoffice.AuthController do
  use BankingWeb, :controller

  alias Banking.SignInBackoffice
  alias BankingWeb.Guardian

  action_fallback(BankingWeb.FallbackController)

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- SignInBackoffice.run(email, password),
         {:ok, token, _} = Guardian.encode_and_sign(user, %{employee: true}, ttl: {1, :hour}) do
      render(conn, "auth.json", %{user: user, token: token})
    end
  end
end
