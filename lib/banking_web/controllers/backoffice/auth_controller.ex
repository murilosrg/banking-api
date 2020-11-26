defmodule BankingWeb.Backoffice.AuthController do
  use BankingWeb, :controller

  alias Banking.SignInBackoffice

  def create(conn, %{"email" => email, "password" => password}) do
    case SignInBackoffice.run(email, password) do
      {:ok, user} ->
        render(conn, "auth.json", %{user: user})

      {:error, _} ->
        conn
        |> put_status(401)
        |> json(%{"error" => "Unauthorized"})
    end
  end
end
