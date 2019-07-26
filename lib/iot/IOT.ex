defmodule IOT do
  use N2O, with: [:nitro]
  use FORM
  require Record

  def extract(name, path, form) do
    [name, path, form]
      |> FORM.atom()
      |> NITRO.q()
      |> NITRO.to_list()
  end

  def box(mod, r) do
    NITRO.clear(:stand)

    rec =
      case r do
        [] -> mod.id
        x -> x
      end

    NITRO.insert_bottom(:stand, FORM.new(mod.new(mod, rec), rec))
  end

  Enum.each(
    [
      :device,
      :provision,
      :location,
      :organization,
      :person,
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
