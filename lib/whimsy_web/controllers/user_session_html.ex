defmodule WhimsyWeb.UserSessionHTML do
  use WhimsyWeb, :html

  embed_templates "user_session_html/*"

  defp local_mail_adapter? do
    Application.get_env(:whimsy, Whimsy.Mailer)[:adapter] == Swoosh.Adapters.Local
  end
end
