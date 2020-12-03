defmodule Banking.AccountBalanceTest do
  use Banking.DataCase, async: true

  alias Banking.AccountBalance

  import Banking.Factory

  describe "debit/2" do
    test "returns new balance after debit" do
      account = insert(:account)
      assert {:ok, account} = AccountBalance.debit(account, 1)
      assert account.balance == Decimal.new(999)
    end
  end

  describe "credit/2" do
    test "returns new balance after credit" do
      account = insert(:account)
      assert {:ok, account} = AccountBalance.credit(account, 1)
      assert account.balance == Decimal.new(1001)
    end
  end
end
