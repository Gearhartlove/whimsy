defmodule WhimsyWeb.PageController do
  use WhimsyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
