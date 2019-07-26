defmodule IOT.Rows.Device do
  use N2O, with: [:n2o, :nitro]
  use FORM, with: [:form]
  require IOT
  require Logger
  require Record

  def doc(),
    do:
      "This is the Device represenration."

  def id(), do: IOT."Device"()

  def new(name,
    IOT."Device"(id: id,
                 type: type,
                 location: loc,
                 serial: sn,
                 model: model)) do

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
          body: NITRO.compact(name)
        ),
        panel(
          class: :column6,
          body: NITRO.compact(type)
        ),
        panel(
          class: :column20,
          body: NITRO.compact(loc)
        ),
        panel(
          class: :column20,
          body: NITRO.compact(model)
        ),
        panel(
          class: :column10,
          body: NITRO.compact(sn)
        )
      ]
    )
  end
end
