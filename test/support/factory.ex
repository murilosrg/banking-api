defmodule Banking.Factory do
  @moduledoc """
  Users factory
  """
  use ExMachina.Ecto, repo: Banking.Repo

  def employee_factory do
    %Banking.User{
      name: "Jane Smith",
      email: sequence(:email, &"employee-#{&1}@example.com"),
      password_hash: Bcrypt.hash_pwd_salt("123456"),
      employee: true
    }
  end

  def client_factory do
    %Banking.User{
      name: "Will Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password_hash: Bcrypt.hash_pwd_salt("123456"),
      employee: false
    }
  end

  def account_factory do
    %Banking.Account{
      balance: 1000,
      user: build(:client)
    }
  end
end
