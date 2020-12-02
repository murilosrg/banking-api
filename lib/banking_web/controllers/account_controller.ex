defmodule BankingWeb.AccountController do
  use BankingWeb, :controller
  alias Banking.{CreateAccount, SignIn}
  alias BankingWeb.Guardian

  action_fallback BankingWeb.FallbackController

  def create(conn, params) do
    with {:ok, %{account: account, user: user}} <-
           CreateAccount.run(params) do
      conn
      |> put_status(:created)
      |> render("account.json", %{account: account, user: user})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case SignIn.run(email, password) do
      {:ok, user} ->
        {:ok, token, _} = Guardian.encode_and_sign(user, %{employee: false}, ttl: {1, :hour})

        conn
        |> put_status(:ok)
        |> render("auth.json", %{user: user, token: token})

      {:error, :unauthorized} ->
        {:error, :unauthorized}
    end
  end
end
