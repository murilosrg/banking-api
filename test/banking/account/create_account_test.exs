defmodule Banking.CreateAccountTest do
  use Banking.DataCase, async: true

  alias Banking.CreateAccount

  import Banking.Factory

  describe "run/1" do
    test "returns a struct when the params are valid" do
      account = build(:create_account)
      assert {:ok, %{account: account, user: user}} = CreateAccount.run(account)
      assert account.balance == 1000
      assert account.user_id == user.id
    end
  end
end
