defmodule SmartAc.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :enabled, :boolean, default: true, null: false

      timestamps()
    end

  end
end
