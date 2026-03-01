defmodule Whimsy.Repo.Migrations.AddNameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, null: false, default: "Adventurer"
    end
  end
end
