defmodule Banking.WithdrawalTransactionTest do
  use Banking.DataCase, async: true

  alias Banking.{Transaction, WithdrawalTransaction}

  import Banking.Factory

  describe "run/1" do
    test "returns a struct when the params are valid" do
      account = insert(:account)
      params = %{amount: 15.5, account_from: account.id}
      assert {:ok, %Transaction{} = transaction} = WithdrawalTransaction.run(params)
      assert transaction.amount == Decimal.new("15.5")
      assert transaction.account_from == account.id
      assert transaction.account_to == nil
      assert transaction.type == 2
    end

    test "returns error when is account_from invalid" do
      params = %{amount: 15.5, account_from: "d1b62026-3415-11eb-adc1-0242ac120002"}
      assert {:error, %Ecto.Changeset{} = changeset} = WithdrawalTransaction.run(params)
      assert %{account_from: ["does not exist"]} = errors_on(changeset)
    end

    test "returns error when is amount is missing" do
      account = insert(:account)
      params = %{account_from: account.id}
      assert {:error, %Ecto.Changeset{} = changeset} = WithdrawalTransaction.run(params)
      assert %{amount: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
