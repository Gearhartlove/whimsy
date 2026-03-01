defmodule WhimsyWeb.PageController do
  use WhimsyWeb, :controller

  @destinations [
    %{
      href: "/encounters",
      title: "Encounters",
      description: "seek your destiny"
    }
  ]

  def home(conn, _params) do
    conn
    |> put_layout(html: {WhimsyWeb.Layouts, :hud})
    |> render(:home, destinations: @destinations)
  end
end
