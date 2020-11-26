defmodule BankingWeb.Backoffice.AuthView do
  use BankingWeb, :view

  def render("auth.json", %{user: user}) do
    %{
      name: user.name
    }
  end
end
