defmodule IOT.Rows.Event do
  use N2O, with: [:n2o, :nitro]
  use FORM, with: [:form]
  require IOT
  require Logger
  require Record

  def doc(),
    do:
      "Event from particular device."

  def id(), do: IOT."Event"()

  def new(name, IOT."Event"(id: id, code: code, type: type, kind: kind, date: date, time: time)) do
    panel(
      id: FORM.atom([:tr, name]),
      class: :td,
      body: [
        panel(
          class: :column6,
          body: NITRO.compact(id)
        ),
        panel(
          class: :column6,
          body: NITRO.compact(date)
        ),
        panel(
          class: :column6,
          body: NITRO.compact(time)
        ),
        panel(
          class: :column6,
          body: NITRO.compact(code)
        ),
        panel(
          class: :column6,
          body: NITRO.compact(type)
        ),
        panel(
          class: :column20,
          body: NITRO.compact(kind)
        )
      ]
    )
  end
end
