defmodule Banking.FindAccountTest do
  use Banking.DataCase, async: true

  alias Banking.FindAccount

  import Banking.Factory

  describe "run/1" do
    test "returns valid account when email are valid" do
      account = insert(:account)
      assert %Banking.Account{} = user = FindAccount.run(account.user.email)
    end

    test "returns error when email are invalid" do
      assert nil == FindAccount.run("test@email")
    end
  end
end
