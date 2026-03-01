defmodule WhimsyWeb.Plugs.HtmxPlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(options) do
    {:ok, options}
  end

  def call(conn, _opts) do
    is_htmx = get_req_header(conn, "hx-request") == ["true"]
    is_boosted = get_req_header(conn, "hx-boosted") == ["true"]

    if is_htmx and not is_boosted do
      conn
      |> put_root_layout(false)
      |> put_layout(false)
    else
      conn
    end
  end
end
