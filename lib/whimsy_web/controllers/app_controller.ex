defmodule WhimsyWeb.AppController do
  use WhimsyWeb, :controller

  def index(conn, _params) do
    conn
    |> render(:index)
  end

  def generate_encounter(conn, _params) do
    Process.sleep(2000)

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(:encounter)
  end
end
