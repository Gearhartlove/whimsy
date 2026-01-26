defmodule Whimsy.Embedding do
  require IEx
  alias Ecto.Repo
  alias Whimsy.Schemas.Creature

  import Ecto.Query

  @embedding_model "openai:text-embedding-3-small"
  @chat_model "openai:gpt-4o-mini"
  @limit 10

  def embed(phrase) do
    ReqLLM.Embedding.embed(@embedding_model, phrase)
  end

  # MOVE
  def save_creature_in_db(embedding) when is_list(embedding) do
  end

  # MOVE
  def generate_embedded_phrase(%Creature{} = creature) do
    generate = fn ->
      IO.puts("starting embedding")

      ReqLLM.generate_text(
        @chat_model,
        "Please generate a short and succinct phrase that will be embedded and use to lookup this particular DnD monster:\n#{inspect(creature)}",
        reasoning_effort: :low
      )
    end

    case generate.() do
      {:ok, response} ->
        {:ok, ReqLLM.Response.text(response)}

      {:error, error} ->
        {:error, "Colud not generate embedded phrase. Error: #{error}"}
    end
  end

  def search_by_phrase(phrase) do
    case embed(phrase) do
      {:ok, query_embedding} ->
        vector = Pgvector.new(query_embedding)

        results =
          Creature
          |> select(
            [c],
            %{creature: c, score: fragment("1 - (embedding <=> ?)", ^vector)}
          )
          |> where([c], not is_nil(c.embedding))
          |> order_by([c], fragment("embedding <=> ?", ^vector))
          |> limit(^@limit)
          |> Whimsy.Repo.all()

        {:ok, results}

      {:error, _} = error ->
        error
    end
  end

  # MOVE
  def foobar() do
    {:ok, red_dragon_json} =
      File.read!(
        Path.join([
          "priv",
          "static",
          "documents",
          "adult_red_dragon.json"
        ])
      )
      |> Jason.decode()

    creature = Creature.new(red_dragon_json)
    IO.puts("Creature created")
    {:ok, embedded_phrase} = generate_embedded_phrase(creature)
    IO.puts("Phrase embedded created")
    {:ok, embedding} = embed(embedded_phrase)
    IEx.pry()
    IO.puts("Creature embedded")

    changeset =
      Creature.changeset(
        creature,
        %{embedded_phrase: embedded_phrase, embedding: embedding}
      )

    {:ok, record} = Whimsy.Repo.insert(changeset)
  end
end
