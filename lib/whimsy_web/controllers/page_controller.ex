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
    render(conn, :home, destinations: @destinations)
  end
end
