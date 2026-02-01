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

  def coords(assigns) do
    ~H"""
    <div id="coords">
      <input type="hidden" name="coord_x" value={@coord_x} />
      <input type="hidden" name="coord_y" value={@coord_y} />
      <p>({@coord_x}, {@coord_y})</p>
    </div>
    """
  end

  def wasd_dungeon(assigns) do
    ~H"""
    <div id="wasd-dungeon" class="flex flex-col gap-4 min-h-screen items-center justify-center">
      <p>Press WASD to move around</p>
      <p>Coordinates</p>
      {coords(assigns)}
      <p
        class="kbd transition-all duration-150"
        hx-post={f("move")}
        hx-trigger="keyup[key == 'w'] from:body"
        hx-vals='{"direction": "north"}'
        hx-target="#coords"
        hx-include="#coords"
      >
        W
      </p>
      <div class="flex flex-row gap-4">
        <p
          class="kbd transition-all duration-150"
          hx-post={f("move")}
          hx-trigger="keyup[key == 'a'] from:body"
          hx-vals='{"direction": "west"}'
          hx-target="#coords"
          hx-include="#coords"
        >
          A
        </p>
        <p
          class="kbd transition-all duration-150"
          hx-post={f("move")}
          hx-trigger="keyup[key == 's'] from:body"
          hx-vals='{"direction": "south"}'
          hx-target="#coords"
          hx-include="#coords"
        >
          S
        </p>
        <p
          class="kbd transition-all duration-150"
          hx-post={f("move")}
          hx-trigger="keyup[key == 'd'] from:body"
          hx-vals='{"direction": "east"}'
          hx-target="#coords"
          hx-include="#coords"
        >
          D
        </p>
      </div>
    </div>
    """
  end
end
