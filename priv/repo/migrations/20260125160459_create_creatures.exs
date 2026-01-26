defmodule Whimsy.Repo.Migrations.CreateCreatures do
  use Ecto.Migration

  def change do
    create table(:creatures) do
      add :name, :string
      add :embedded_phrase, :string
      add :data, :map
      add :embedding, :vector, size: 1536

      timestamps()
    end

    # IVFFlat index with cosine distance for fast similarity search
    create index(:creatures, ["embedding vector_cosine_ops"], using: :ivfflat)
  end
end
