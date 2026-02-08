defmodule WhimsyWeb.EncounterHTML do
  use WhimsyWeb, :html

  import WhimsyWeb.EncounterController, only: [f: 1]

  embed_templates "encounter_html/*"
end
