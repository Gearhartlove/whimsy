defmodule Whimsy.Schemas.Creature do
  use Ecto.Schema
  import Ecto.Changeset

  schema "creatures" do
    field :name, :string
    field :data, :map
    field :embedded_phrase, :string
    field :embedding, Pgvector.Ecto.Vector

    timestamps()
  end

  def changeset(module, params) do
    module
    |> cast(params, [:name, :data, :embedded_phrase, :embedding])
    |> validate_required([:name, :data])
    |> unique_constraint(:name)
  end

  def new(name, data) do
    %__MODULE__{
      name: name,
      data: data
    }
  end

  def new(%{"name" => name} = data) do
    %__MODULE__{
      name: name,
      data: data
    }
  end
end
