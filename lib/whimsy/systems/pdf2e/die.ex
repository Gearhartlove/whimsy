defmodule Whimsy.Systems.Pdf2e.Die do
  use Ecto.Schema

  import Ecto.Changeset

  schema "dice" do
    field :sides, :integer
    field :value, :integer

    belongs_to :roll, Roll

    timestamps()
  end

  def changeset(die, params \\ %{}) do
    sides = die.sides || params.sides

    die
    |> cast(params, [:roll_id, :sides, :value])
    |> validate_required([:sides, :value])
    |> validate_inclusion(:value, 1..sides)
  end
end
