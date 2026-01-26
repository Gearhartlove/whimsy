Postgrex.Types.define(
  Whimsy.PostgrexTypes,
  [Pgvector.Extensions.Vector] ++ Ecto.Adapters.Postgres.extensions()
)
