defmodule WhimsyWeb.InventoryController do
  use WhimsyWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render(items: Whimsy.Inventory.get())
  end

  def delete(conn, %{"id" => id}) do
    Whimsy.Inventory.delete(id)
    send_resp(conn, 200, "")
  end

  def reset(conn, _params) do
    Whimsy.Inventory.reset()

    render(conn, :item_list, items: Whimsy.Inventory.get())
  end
end
