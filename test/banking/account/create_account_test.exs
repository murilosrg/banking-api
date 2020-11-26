defmodule Banking.CreateAccountTest do
  use Banking.DataCase, async: true

  alias Banking.{Account, CreateAccount}

  import Banking.Factory

  describe "run/1" do
    test "returns a struct when the params are valid" do
      user = insert(:client)
      params = %{user_id: user.id}
      assert {:ok, %Account{} = account} = CreateAccount.run(params)
      assert account.balance == 1000
      assert account.user_id == user.id
    end

    test "returns error when is user_id missing" do
      params = %{user_id: "a27ef11e-302f-11eb-adc1-0242ac120002"}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateAccount.run(params)
      assert %{user_id: ["does not exist"]} = errors_on(changeset)
    end
  end
end
