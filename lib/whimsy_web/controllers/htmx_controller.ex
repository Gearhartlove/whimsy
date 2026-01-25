defmodule WhimsyWeb.HtmxController do
  @moduledoc """
  Controller for HTMX endpoints that return HTML fragments.
  """
  use WhimsyWeb, :controller

  def greeting(conn, _params) do
    greeting =
      Enum.random([
        "Hello, adventurer!",
        "Greetings, brave soul!",
        "Welcome, weary traveler!",
        "Hail, noble hero!",
        "Well met, wanderer!"
      ])

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(:greeting, greeting: greeting)
  end

  def roll_dice(conn, %{"sides" => sides}) do
    sides = String.to_integer(sides)
    result = :rand.uniform(sides)

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(:dice_result, sides: sides, result: result)
  end

  def roll_dice(conn, _params) do
    # Default to d20
    result = :rand.uniform(20)

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(:dice_result, sides: 20, result: result)
  end
end
