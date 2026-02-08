defmodule WhimsyWeb.EncounterController do
  use WhimsyWeb, :controller
  use WhimsyWeb.HtmlFragments, base_path: "/encounters"

  @encounters [
    %{
      display_name: "HX-GET",
      path: "hx-get"
    },
    %{
      display_name: "WASD_DUNGEON",
      path: "wasd_dungeon"
    }
  ]

  def index(conn, _params) do
    render(conn, :index, encounters: @encounters)
  end

  def hx_get(conn, _params) do
    render(conn, :hx_get)
  end

  def wasd_dungeon(conn, _params) do
    render(conn, :wasd_dungeon, coord_x: 0, coord_y: 0)
  end

  def _fight(conn, _params) do
    case Enum.random(1..2) do
      1 ->
        render(conn, :_death)

      2 ->
        render(conn, :_victory)
    end
  end

  def _move(conn, %{
        "direction" => direction,
        "coord_x" => coord_x,
        "coord_y" => coord_y
      }) do
    coord_x = String.to_integer(coord_x)
    coord_y = String.to_integer(coord_y)

    {coord_x, coord_y} =
      case direction do
        "north" -> {coord_x, coord_y + 1}
        "west" -> {coord_x - 1, coord_y}
        "east" -> {coord_x + 1, coord_y}
        "south" -> {coord_x, coord_y - 1}
      end

    render(conn, :_coords, coord_x: coord_x, coord_y: coord_y)
  end
end
