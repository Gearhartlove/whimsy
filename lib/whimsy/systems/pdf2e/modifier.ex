defmodule Whimsy.Systems.Pdf2e.Modifier do
  alias Whimsy.Systems.Pdf2e.Roll
  use Ecto.Schema

  import Ecto.Changeset

  schema "modifiers" do
    field :value, :integer
    field :source, :string

    belongs_to :roll, Roll
  end

  def changeset(modifier, params \\ %{}) do
    modifier
    |> cast(params, [:roll_id, :value, :source])
    |> validate_required([:value, :source])
  end
end
