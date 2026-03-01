defmodule WhimsyWeb.AttributionController do
  use WhimsyWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
