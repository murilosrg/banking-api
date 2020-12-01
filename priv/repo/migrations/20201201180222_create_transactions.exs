defmodule Banking.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :amount, :decimal
      add :account_to, :uuid
      add :type, :integer, null: false

      add :account_from, references(:accounts, on_delete: :nothing, type: :uuid, null: false), null: false

      timestamps()
    end

    create index(:transactions, [:account_from])
  end
end
