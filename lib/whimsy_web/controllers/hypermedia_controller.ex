defmodule WhimsyWeb.HypermediaController do
  use WhimsyWeb, :controller

  def index(conn, _params) do
    conn
    |> render(:index)
  end

  def settings(conn, _params) do
    conn
    |> render(:_settings)
  end

  def help(conn, _params) do
    conn
    |> render(:_help)
  end

  def contacts(conn, _params) do
    conn
    |> render(:_contacts)
  end

  def delete_contact(conn, _params) do
    _contact = %{id: 1, name: "Kristoff"}

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> put_flash(:info, "Deleted Contact!")
    |> render(:_delete_contact)
  end

  def experiments(conn, _params) do
    render(conn, :experiments)
  end

  def search_contacts(conn, %{"q" => contact}) do
    render(conn, :_search_contacts, contact: contact)
  end
end
