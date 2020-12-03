defmodule Banking.SignInTest do
  use Banking.DataCase, async: true

  import Banking.Factory

  alias Banking.{SignIn, User}

  describe "run/2" do
    test "returns ok when email and password match" do
      client = insert(:client)
      assert {:ok, %User{}} = SignIn.run(client.email, "123456")
    end

    test "returns error when there is not user this email" do
      assert {:error, :unauthorized} = SignIn.run("client1@example.com", "123456")
    end

    test "returns error when the password is invalid" do
      client = insert(:client)
      assert {:error, :unauthorized} = SignIn.run(client.email, "1234567")
    end

    test "returns error when not an client" do
      employee = insert(:employee)

      assert {:error, :unauthorized} = SignIn.run(employee.email, "123456")
    end
  end
end
