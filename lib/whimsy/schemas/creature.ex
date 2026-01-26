defmodule Whimsy.Schemas.Creature do
  use Ecto.Schema

  schema "creatures" do
    field :name, :string
    field :embedded_phrase, :string
    field :data, :map

    # TODO: add a pg vector style vector entry to this 
  end
end
