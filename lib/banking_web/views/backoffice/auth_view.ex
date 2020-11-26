defmodule BankingWeb.Backoffice.AuthView do
  use BankingWeb, :view

  def render("auth.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end
end
