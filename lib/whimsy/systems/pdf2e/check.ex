defmodule Whimsy.Systems.Pdf2e.Check do
  alias Whimsy.Systems.Pdf2e.Roll
  alias Whimsy.Systems.Pdf2e.Action
  use Ecto.Schema

  import Ecto.Changeset

  schema "checks" do
    field :dc, :integer
    field :outcome, Ecto.Enum, values: [:critical_success, :success, :failure, :critical_failure]
    field :check_type, :string

    has_one :roll, Roll
    belongs_to :action, Action

    timestamps()
  end

  def changeset(check, params \\ %{}) do
    check
    |> cast(params, [:action_id, :dc, :outcome, :check_type])
    |> cast_assoc(:roll, with: &Roll.changeset/2, required: true)
    |> validate_required([:dc, :check_type])
  end
end
