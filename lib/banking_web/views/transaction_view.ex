defmodule BankingWeb.TransactionView do
  use BankingWeb, :view

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      balance: account.balance
    }
  end

  def render("422.json", %{message: message}) do
    %{
      message: message
    }
  end
end
