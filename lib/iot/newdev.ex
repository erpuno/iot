defmodule IOT.Forms.Create do
  use N2O, with: [:n2o, :nitro]
  use FORM, with: [:form]
  use KVS
  require Logger

  def doc(), do: "Dialog for creation of IOT device."
  def id(), do: {:pi, []}

  def new(name, {:pi, _code}) do
    document(
      name: FORM.atom([:pi, name]),
      sections: [sec(name: "New device: ")],
      buttons: [
        but(
          id: FORM.atom([:pi, :decline]),
          title: "Discard",
          class: :cancel,
          postback: {:discard, []}
        ),
        but(
          id: FORM.atom([:pi, :proceed]),
          title: "Create",
          class: [:button, :sgreen],
          sources: [:process_type],
          postback: {:spawn, []}
        )
      ],
      fields: [
        field(
          name: :process_type,
          id: :process_type,
          type: :select,
          title: "Type",
          tooltips: [],
          options: [
            opt(name: '1', title: "Apple"),
            opt(name: '2', title: "Microsoft"),
            opt(
              name: '3',
              checked: true,
              title: "Google"
            )
          ]
        )
      ]
    )
  end
end
