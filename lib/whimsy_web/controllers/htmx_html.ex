defmodule WhimsyWeb.HtmxHTML do
  @moduledoc """
  This module contains HTML fragments rendered by HtmxController.

  These templates return partial HTML meant to be swapped into the page
  by HTMX rather than full page renders.
  """
  use WhimsyWeb, :html

  embed_templates "htmx_html/*"
end
