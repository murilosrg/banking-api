defmodule BankingWeb.Backoffice.AuthController do
  use BankingWeb, :controller

  alias Banking.SignInBackoffice
  alias BankingWeb.Guardian

  action_fallback BankingWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    case SignInBackoffice.run(email, password) do
      {:ok, user} ->
        {:ok, token, _} = Guardian.encode_and_sign(user, %{employee: true}, ttl: {1, :hour})
        render(conn, "auth.json", %{user: user, token: token})

      {:error, :unauthorized} ->
        {:error, :unauthorized}
    end
  end
end
