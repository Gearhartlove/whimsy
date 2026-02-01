defmodule WhimsyWeb.EncounterController do
  use WhimsyWeb, :controller

  @encounters [
    %{
      display_name: "HX-GET",
      path: "hx-get"
    },
    %{
      display_name: "HX-POST",
      path: "hx-post"
    }
  ]

  def index(conn, _params) do
    render(conn, :index, encounters: @encounters)
  end

  def hx_get(conn, _params) do
    render(conn, :hx_get)
  end

  def hx_post(conn, _params) do
    render(conn, :hx_post)
  end

  def fight(conn, _params) do
    case Enum.random(1..2) do
      1 ->
        render_fragment(conn, :death)

      2 ->
        render_fragment(conn, :victory)
    end
  end

  def fragments(conn, %{"fragment" => fragment} = params) do
    fragment = String.to_atom(fragment)

    # if my module has a function named after the fragment, then go with that,
    # otherwise just render the fragment straight up
    if function_exported?(__MODULE__, fragment, 2) do
      apply(__MODULE__, fragment, [conn, params])
    else
      render_fragment(conn, fragment)
    end
  end

  @doc """
  Helper function to reference encounter fragments
  """
  def f(name) do
    "/encounters/fragments/#{name}"
  end

  @doc """
  Helper function to render fragment with conn
  """
  def render_fragment(conn, fragment) do
    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(fragment)
  end
end
