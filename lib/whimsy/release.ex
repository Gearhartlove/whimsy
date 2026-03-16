defmodule Whimsy.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.

  Usage:

      bin/whimsy eval "Whimsy.Release.migrate"
      bin/whimsy eval "Whimsy.Release.rollback(Whimsy.Repo, 20240101000000)"
  """

  @app :whimsy

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
