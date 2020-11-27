defmodule Banking.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :balance, :decimal
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:accounts, [:user_id])
  end
end
