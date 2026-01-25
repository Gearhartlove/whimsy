defmodule WhimsyWeb.AppController do
  use WhimsyWeb, :controller

  def index(conn, _params) do
    conn
    |> render(:index)
  end

  def generate_encounter(conn, %{"description" => description}) do
    model = "openai:gpt-4o-mini"

    response =
      ReqLLM.generate_text!(
        model,
        ~s(Please generate a succinct description of a dungion room matching the user's descirption:\n<user_description>\n#{description}\n</user_description>),
        temperature: 1.0,
        max_tokens: 5000
      )

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(:encounter, response: response)
  end
end
