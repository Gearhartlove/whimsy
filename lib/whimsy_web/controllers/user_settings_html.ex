defmodule WhimsyWeb.UserSettingsHTML do
  use WhimsyWeb, :html

  embed_templates "user_settings_html/*"

  def avatar_presets do
    dir = Path.join([:code.priv_dir(:whimsy), "static", "images", "avatars"])

    case File.ls(dir) do
      {:ok, files} ->
        files
        |> Enum.filter(&(Path.extname(&1) in ~w(.svg .png .jpg .jpeg .gif .webp)))
        |> Enum.sort()
        |> Enum.map(&"/images/avatars/#{&1}")

      {:error, _} ->
        []
    end
  end
end
