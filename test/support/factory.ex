defmodule Banking.Factory do
  @moduledoc """
  Users factory
  """
  use ExMachina.Ecto, repo: Banking.Repo

  def employee_factory do
    %Banking.User{
      name: "Jane Smith",
      email: "employee@example.com",
      password_hash: Bcrypt.hash_pwd_salt("123456"),
      employee: true
    }
  end

  def client_factory do
    %Banking.User{
      name: "Will Smith",
      email: "client@example.com",
      password_hash: Bcrypt.hash_pwd_salt("123456"),
      employee: false
    }
  end
end
