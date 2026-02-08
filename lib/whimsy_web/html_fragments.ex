defmodule WhimsyWeb.HtmlFragments do
  defmacro __using__(opts) do
    base_path = Keyword.fetch!(opts, :base_path)

    quote do
      def f(name) do
        "#{unquote(base_path)}/fragments/#{name}"
      end

      def fragments(conn, %{"fragment" => fragment} = params) do
        fragment = String.to_atom(fragment)

        if function_exported?(__MODULE__, fragment, 2) do
          apply(__MODULE__, fragment, [conn, params])
        else
          render(conn, fragment)
        end
      end
    end
  end
end
