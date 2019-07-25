defmodule IOT do
  require Record

  Enum.each(
    [
      :device,
      :provision,
      :location,
      :event,
      :firmware
    ],
    fn t ->
      Enum.each(
        Record.extract_all(
          from_lib: "iot/include/" <> :erlang.list_to_binary(:erlang.atom_to_list(t)) <> ".hrl"
        ),
        fn {name, definition} ->
          prev = :application.get_env(:kernel, :iot_tables, [])
          case :lists.member(name, prev) do
            true ->
              :skip

            false ->
              Record.defrecord(name, definition)
              :application.set_env(:kernel, :iot_tables, [name | prev])
          end
        end
      )
    end
  )

  defmacro __using__(opts \\ []) do
    imports =
      opts
      |> Macro.expand(__CALLER__)
      |> Keyword.get(:with, [:iot])

    Enum.map(imports, fn mod ->
      if Code.ensure_compiled?(mod) do
        upcased = Module.concat([String.upcase(to_string(mod))])

        quote do
          import unquote(upcased)
          alias unquote(mod), as: unquote(upcased)
        end
      else
        IO.warn("🚨 Unknown module #{mod} was requested to be used by :iot. Skipping.")
      end
    end)
  end
end
