defmodule WhimsyWeb.EncounterHTML do
  use WhimsyWeb, :html

  import WhimsyWeb.EncounterController, only: [f: 1]

  embed_templates "encounter_html/*"

  def death(assigns) do
    ~H"""
    <div>
      <p>You have died :(</p>
      <button hx-get={f("dungeon")} hx-target="closest div">Try again</button>
    </div>
    """
  end

  def victory(assigns) do
    ~H"""
    <p>You are victorious!</p>
    <button hx-get="/encounters" hx-target="closest div">Bring home your spoils!</button>
    """
  end
end
