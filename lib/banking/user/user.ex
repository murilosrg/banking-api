defmodule Banking.User do
  @moduledoc """
  User schema
  """
  use Ecto.Schema

  schema "users" do
    field :email, :string
    field :employee, :boolean
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end
end
