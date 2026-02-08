defmodule WhimsyWeb.Plugs.HtmxPlug do
  import Plug.Conn
  import Phoenix.Controller

  def init(options) do
    {:ok, options}
  end

  def call(conn, _opts) do
    if get_req_header(conn, "hx-request") == ["true"] do
      conn
      |> put_root_layout(false)
      |> put_layout(false)
    else
      conn
    end
  end
end
