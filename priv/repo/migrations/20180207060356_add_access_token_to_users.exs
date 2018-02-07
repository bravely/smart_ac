defmodule SmartAc.Repo.Migrations.AddAccessTokenToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :access_token, :string
    end

    create unique_index(:users, [:access_token])
  end
end
