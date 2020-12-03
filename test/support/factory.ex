defmodule Banking.Factory do
  @moduledoc """
  Users factory
  """
  use ExMachina.Ecto, repo: Banking.Repo

  alias Banking.{Account, Transaction, User}

  def employee_factory do
    %User{
      name: "Jane Smith",
      email: sequence(:email, &"employee-#{&1}@example.com"),
      password_hash: Bcrypt.hash_pwd_salt("123456"),
      employee: true
    }
  end

  def client_factory do
    %User{
      name: "Will Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: Bcrypt.hash_pwd_salt("123456"),
      employee: false
    }
  end

  def account_factory do
    %Account{
      balance: 1000,
      user: build(:client)
    }
  end

  def transaction_factory do
    %Transaction{
      amount: 10,
      type: 1,
      account_from: build(:account)
    }
  end

  def create_account_factory do
    %{
      "name" => "Jaden Smith",
      "email" => sequence(:email, &"email-#{&1}@example.com"),
      "password" => "123456"
    }
  end
end
