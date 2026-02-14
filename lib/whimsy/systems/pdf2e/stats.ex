defmodule Whimsy.Systems.Pdf2e.Stats do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    # indicates charm, persuasiveness, and force of personality
    field :charisma, :integer
    # indicates character's overall health and well-being
    field :constitution, :integer
    # represents agility and ability to avoid danger
    field :dexterity, :integer
    # represents raw knowledge and problem-solving
    field :intelligence, :integer
    # represents a character's physical might
    field :strength, :integer
    # measures a character's insight and the ability to evaluate a situation
    field :wisdom, :integer
  end

  def changeset(stats, params \\ %{}) do
    stats
    |> cast(
      params,
      [
        :charisma,
        :constitution,
        :dexterity,
        :intelligence,
        :strength,
        :wisdom
      ]
    )
    |> validate_required([
      :charisma,
      :constitution,
      :dexterity,
      :intelligence,
      :strength,
      :wisdom
    ])
  end
end
