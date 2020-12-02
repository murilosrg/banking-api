defmodule BankingWeb.AccountView do
  use BankingWeb, :view

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      user_id: account.user_id,
      balance: account.balance
    }
  end
end
