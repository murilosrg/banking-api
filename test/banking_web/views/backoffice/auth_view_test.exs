defmodule BankingWeb.Backoffice.AuthViewTest do
  use ExUnit.Case, async: true

  alias BankingWeb.Backoffice.AuthView

  import Banking.Factory

  describe "render/2" do
    test "returns ok and user data" do
      user = params_for(:employee)

      assert %{email: "employee@example.com", token: "valid-token"} =
               AuthView.render("auth.json", %{user: user, token: "valid-token"})
    end
  end
end
