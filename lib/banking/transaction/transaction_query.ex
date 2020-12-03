defmodule Banking.TransactionQuery do
  @moduledoc """
  Transaction query schema
  """

  use Ecto.Schema

  embedded_schema do
    field :filter, :string
    field :value, :string
  end
end
