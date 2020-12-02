defmodule BankingWeb.AccountView do
  use BankingWeb, :view

  def render("auth.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end

  def render("account.json", %{account: account, user: user}) do
    %{
      id: account.id,
      user_id: user.id,
      email: user.email,
      balance: account.balance
    }
  end
end
