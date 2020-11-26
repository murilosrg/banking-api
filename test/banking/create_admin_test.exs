defmodule Banking.CreateUserTest do
  use Banking.DataCase, async: true

  alias Banking.{CreateUser, User}

  describe "run/1" do
    test "returns a struct when params are valid" do
      params = %{name: "user", email: "user@email.com", password: "123456", employee: false}
      assert {:ok, %User{} = user} = CreateUser.run(params)
      assert user.name == "user"
      assert user.email == "user@email.com"
      assert user.employee == false
      refute user.password_hash == "123456"
    end

    test "returns error when is name missing" do
      params = %{name: "", email: "user@email.com", password: "123456", employee: false}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when email is missing" do
      params = %{name: "user", email: "", password: "123456", employee: false}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when password is missing" do
      params = %{name: "user", email: "user@email.com", password: "", employee: false}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{password: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when employee is missing" do
      params = %{name: "user", email: "user@email.com", password: "123456"}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{employee: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when email is invalid" do
      params = %{
        name: "user",
        email: "user.email.com",
        password: "123456",
        employee: false
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{email: ["has invalid format"]} = errors_on(changeset)
    end

    test "returns error when password not contains the min lengh" do
      params = %{name: "user", email: "user@email.com", password: "12345", employee: false}
      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
    end

    test "returns error when password exceeds max lengh" do
      params = %{
        name: "user",
        email: "user@email.com",
        password: "123456789012345678901",
        employee: false
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateUser.run(params)
      assert %{password: ["should be at most 20 character(s)"]} = errors_on(changeset)
    end
  end
end
