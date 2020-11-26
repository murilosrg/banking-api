defmodule Banking.SignInBackofficeTest do
  use Banking.DataCase, async: true

  import Banking.Factory

  alias Banking.{SignInBackoffice, User}

  describe "run/2" do
    setup do
      insert(:client)
      insert(:employee)
      :ok
    end

    test "returns ok when email and password match" do
      assert {:ok, %User{}} = SignInBackoffice.run("employee@example.com", "123456")
    end

    test "returns error when there is not user this email" do
      assert {:error, :email_or_password_invalid} =
               SignInBackoffice.run("employee1@example.com", "123456")
    end

    test "returns error when the password is invalid" do
      assert {:error, :email_or_password_invalid} =
               SignInBackoffice.run("employee@example.com", "1234567")
    end

    test "returns error when not an employee" do
      assert {:error, :email_or_password_invalid} =
               SignInBackoffice.run("client@email.com", "123456")
    end
  end
end
