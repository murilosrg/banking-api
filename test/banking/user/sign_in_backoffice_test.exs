defmodule Banking.SignInBackofficeTest do
  use Banking.DataCase, async: true

  import Banking.Factory

  alias Banking.{SignInBackoffice, User}

  describe "run/2" do
    test "returns ok when email and password match" do
      employee = insert(:employee)
      assert {:ok, %User{}} = SignInBackoffice.run(employee.email, "123456")
    end

    test "returns error when there is not user this email" do
      assert {:error, :unauthorized} = SignInBackoffice.run("employee1@example.com", "123456")
    end

    test "returns error when the password is invalid" do
      assert {:error, :unauthorized} = SignInBackoffice.run("employee@example.com", "1234567")
    end

    test "returns error when not an employee" do
      client = insert(:client)

      assert {:error, :unauthorized} = SignInBackoffice.run(client.email, "123456")
    end
  end
end
