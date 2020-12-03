defmodule Banking.ReportTransactionTest do
  use Banking.DataCase, async: true

  alias Banking.{ReportTransaction, WithdrawalTransaction}

  import Banking.Factory

  describe "run/1" do
    test "returns a total when the params are valid" do
      create_transaction()
      params = %{filter: "total"}
      assert {:ok, total} = ReportTransaction.run(params)
      assert total == Decimal.new("15.50")
    end
  end

  defp create_transaction do
    account = insert(:account)
    params = %{amount: 15.5, account_from: account.id}
    WithdrawalTransaction.run(params)
  end
end
