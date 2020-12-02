defmodule BankingWeb.AccountViewTest do
  use ExUnit.Case, async: true
  use Banking.DataCase, async: true

  alias BankingWeb.AccountView

  import Banking.Factory

  describe "render/2" do
    test "returns ok and user data" do
      account = insert(:account)

      assert %{
               id: account.id,
               user_id: account.user_id,
               email: account.user.email,
               balance: account.balance
             } ==
               AccountView.render("account.json", %{account: account, user: account.user})
    end
  end
end
