defmodule Banking.Account do
  @moduledoc """
  Account schema
  """

  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "accounts" do
    field :balance, :decimal, default: 1000

    belongs_to :user, Banking.User
    has_many :transactions, Banking.Transaction, foreign_key: :account_from, references: :id

    timestamps()
  end
end
