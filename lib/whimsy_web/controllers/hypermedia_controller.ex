defmodule WhimsyWeb.HypermediaController do
  use WhimsyWeb, :controller

  def index(conn, params) do
    conn
    |> render(:index)
  end

  def settings(conn, params) do
    conn
    |> render(:settings)
  end

  def help(conn, params) do
    conn
    |> render(:help)
  end

  def contacts(conn, params) do
    conn
    |> render(:contacts)
  end

  def delete_contact(conn, params) do
    contact = %{id: 1, name: "Kristoff"}

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> put_flash(:info, "Deleted Contact!")
    |> render(:delete_contact)
  end
end
