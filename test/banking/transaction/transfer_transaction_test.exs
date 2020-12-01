defmodule Banking.TransferTransactionTest do
  use Banking.DataCase, async: true

  alias Banking.{Transaction, TransferTransaction}

  import Banking.Factory

  describe "run/1" do
    test "returns a struct when the params are valid" do
      account_from = insert(:account)
      account_to = insert(:account)
      params = %{amount: 15.5, account_from: account_from.id, account_to: account_to.id}
      assert {:ok, %Transaction{} = transaction} = TransferTransaction.run(params)
      assert transaction.amount == Decimal.new("15.5")
      assert transaction.account_from == account_from.id
      assert transaction.account_to == account_to.id
      assert transaction.type == 1
    end

    test "returns error when is account_from invalid" do
      params = %{
        amount: 15.5,
        account_from: "d1b62026-3415-11eb-adc1-0242ac120002",
        account_to: "12b62026-3415-11eb-adc1-0242ac120002"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = TransferTransaction.run(params)
      assert %{account_from: ["does not exist"]} = errors_on(changeset)
    end
  end
end
