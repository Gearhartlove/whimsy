defmodule WhimsyWeb.NavigationComponents do
  use Phoenix.Component

  @doc """
  Renders a quest-style destination card linking to a section of the app.

  ## Examples

      <.destination_card href="/encounters" title="Encounters" description="seek your destiny" />
  """
  attr :href, :string, required: true
  attr :title, :string, required: true
  attr :description, :string, required: true

  def destination_card(assigns) do
    ~H"""
    <div class="relative">
      <span class="absolute -top-3 -left-3 text-primary/50 text-xl select-none">✦</span>
      <span class="absolute -top-3 -right-3 text-primary/50 text-xl select-none">✦</span>
      <span class="absolute -bottom-3 -left-3 text-primary/50 text-xl select-none">✦</span>
      <span class="absolute -bottom-3 -right-3 text-primary/50 text-xl select-none">✦</span>

      <a
        href={@href}
        class="group relative flex flex-col items-center gap-5 w-72 px-10 py-10 rounded-lg bg-base-200 border border-primary/20 hover:border-primary/60 hover:shadow-lg hover:shadow-primary/10 transition-all duration-300 hover:scale-[1.03]"
      >
        <div class="absolute -top-3 left-1/2 -translate-x-1/2 w-6 h-6 rounded-full bg-base-300 border-2 border-primary/40 group-hover:border-primary/80 transition-colors duration-300">
        </div>

        <div class="flex items-center gap-3 text-primary/50 group-hover:text-primary/80 transition-colors duration-300 mt-2">
          <span>⚔</span>
          <span class="w-14 h-px bg-current"></span>
          <span>⚔</span>
        </div>

        <div class="text-center">
          <p style="font-family: 'Pacifico', cursive;" class="text-3xl text-primary leading-tight">
            {@title}
          </p>
          <p class="text-base-content/40 text-xs tracking-[0.25em] uppercase mt-2 group-hover:text-base-content/60 transition-colors duration-300">
            {@description}
          </p>
        </div>

        <div class="flex items-center gap-3 text-primary/50 group-hover:text-primary/80 transition-colors duration-300">
          <span class="w-14 h-px bg-current"></span>
          <span>✦</span>
          <span class="w-14 h-px bg-current"></span>
        </div>
      </a>
    </div>
    """
  end
end
