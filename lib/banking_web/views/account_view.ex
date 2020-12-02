defmodule BankingWeb.AccountView do
  use BankingWeb, :view

  def render("account.json", %{account: account, user: user}) do
    %{
      id: account.id,
      user_id: user.id,
      email: user.email,
      balance: account.balance
    }
  end
end
