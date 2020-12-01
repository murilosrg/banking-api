defmodule Banking.Transaction do
  @moduledoc """
  Transaction schema
  """

  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "transactions" do
    field :account_to, Ecto.UUID
    field :amount, :decimal
    field :type, :integer

    belongs_to :account, Banking.Account, foreign_key: :account_from, references: :id

    timestamps()
  end
end
