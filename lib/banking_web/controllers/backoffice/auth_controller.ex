defmodule BankingWeb.Backoffice.AuthController do
  use BankingWeb, :controller

  alias Banking.SignInBackoffice
  alias BankingWeb.Guardian

  def create(conn, %{"email" => email, "password" => password}) do
    case SignInBackoffice.run(email, password) do
      {:ok, user} ->
        {:ok, token, _} = Guardian.encode_and_sign(user)
        render(conn, "auth.json", %{user: user, token: token})

      {:error, _} ->
        conn
        |> put_status(401)
        |> json(%{"error" => "Unauthorized"})
    end
  end
end
