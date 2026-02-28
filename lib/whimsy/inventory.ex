defmodule Whimsy.Inventory do
  use GenServer

  @starting_inventory [
    %{
      name: "Sword",
      price: 10
    },
    %{
      name: "Chair",
      price: 1
    }
  ]

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  @impl true
  def init(_) do
    {:ok, @starting_inventory}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:add, %{name: _, price: _} = item}, _from, state) do
    new_state = [item | state]
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call({:delete, item_name}, _from, state) do
    new_state =
      Enum.reduce(
        state,
        [],
        fn item, acc ->
          if item_name == item.name do
            acc
          else
            [item | acc]
          end
        end
      )

    {:reply, new_state, new_state}
  end
end
