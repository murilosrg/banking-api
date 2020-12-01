defmodule Banking.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :employee, :boolean, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
