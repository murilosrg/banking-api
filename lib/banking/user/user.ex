defmodule Banking.User do
  @moduledoc """
  User schema
  """
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "users" do
    field :email, :string
    field :employee, :boolean
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_one :account, Banking.Account

    timestamps()
  end
end
