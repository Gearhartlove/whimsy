defmodule Whimsy.Systems.Pdf2e.Roll do
  alias Whimsy.Systems.Pdf2e.Die
  alias Whimsy.Systems.Pdf2e.Modifier
  alias Whimsy.Systems.Pdf2e.Check
  use Ecto.Schema

  import Ecto.Changeset

  schema "rolls" do
    has_many :dice, Die
    has_many :modifiers, Modifier

    belongs_to :check, Check

    timestamps()
  end

  def changeset(roll, params \\ %{}) do
    roll
    |> cast(params, [:check_id])
    |> cast_assoc(:dice, with: &Die.changeset/2, required: true)
    |> cast_assoc(:modifiers, with: &Modifier.changeset/2)
    |> validate_length(:dice, min: 1)
  end
end
