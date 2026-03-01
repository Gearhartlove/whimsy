defmodule Whimsy.Systems.Pdf2e.Action do
  @moduledoc """
  The ways in which characters and their adversaries affect the world of Pahtfinder.
  """

  alias Whimsy.Systems.Pdf2e.Check
  use Ecto.Schema
  import Ecto.Changeset

  schema "actions" do
    field :name, :string
    field :level, :integer
    field :prerequisites, :string
    field :frequency, :string
    field :trigger, :string
    field :requirements, :string
    field :effect, :string
    field :special, :string
    field :action_cost, :integer

    field :action_type,
          Ecto.Enum,
          values: [:single_action, :two_action, :three_action, :reaction, :free_action]

    has_one :check, Check
  end

  def changeset(action, params \\ %{}) do
    action
    |> cast(
      params,
      [
        :name,
        :level,
        :prerequisites,
        :frequency,
        :trigger,
        :requirements,
        :effect,
        :special,
        :action_cost,
        :action_type
      ]
    )
    |> cast_assoc(:check, &Check.changeset/2)
    |> validate_inclusion(:action_cost, 0..3)
    |> validate_required([:name, :level, :effect, :action_cost, :action_type])
  end
end
