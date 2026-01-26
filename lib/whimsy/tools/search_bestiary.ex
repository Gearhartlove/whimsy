defmodule Whimsy.Tools.SearchBestiary do
  def get! do
    {:ok, tool} =
      ReqLLM.tool(
        name: "search_bestiary",
        description: "Search the bestiary for a monster",
        parameter_schema: [
          search_phrase: [
            type: :string,
            required: true,
            doc: "The search phrase to search the beastiary with."
          ]
        ],
        calback: {__MODULE__, :callback}
      )

    tool
  end

  @doc """
  Search the embedded database for a red dragon.
  """
  def callback do
    result = nil
    {:ok, result}
  end
end
