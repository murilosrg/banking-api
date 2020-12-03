defmodule Banking.ValidateTransactionTest do
  use Banking.DataCase, async: true

  alias Banking.ValidateTransaction

  import Banking.Factory

  describe "valid_transaction?/1" do
    test "returns account when a valid transaction" do
      account = build(:account)
      assert {:ok, %Banking.Account{}} = ValidateTransaction.valid_transaction?(account, 999)
    end

    test "returns error when a invalid transaction" do
      account = build(:account)
      assert {:error} = ValidateTransaction.valid_transaction?(account, 1001)
    end
  end

  describe "debit_from_account/2" do
    test "returns account when a valid transaction" do
      account = insert(:account)

      assert {:ok, result} = ValidateTransaction.debit_from_account(account, 999)
      assert result.account.balance == Decimal.new(1)
    end
  end

  describe "transfer_to_account/3" do
    test "returns account when a valid transaction" do
      account_from = insert(:account)
      account_to = insert(:account)

      assert {:ok, result} =
               ValidateTransaction.transfer_to_account(account_from, account_to.user.email, 999)

      assert result.balance == Decimal.new(1)
    end
  end
end
