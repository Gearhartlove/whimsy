defmodule Whimsy.Schemas.Creature do
  use Ecto.Schema

  schema "creatures" do
    field :name, :string
    field :embedded_phrase, :string
    field :data, :map
    field :embedding, Pgvector.Ecto.Vector

    timestamps()
  end
end
