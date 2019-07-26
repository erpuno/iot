defmodule IOT.Index do
  require Logger
  use N2O, with: [:n2o, :kvs, :nitro]
  use FORM
  require IOT
  require KVS

  def index_header() do
    panel(
      id: :header,
      class: :th,
      body: [
        panel(class: :column6, body: "Id"),
        panel(class: :column20, body: "Manufacturer"),
        panel(class: :column10, body: "Name"),
        panel(class: :column6, body: "Type"),
        panel(class: :column20, body: "Location"),
        panel(class: :column20, body: "Model"),
        panel(class: :column20, body: "SN")
      ]
    )
  end

  def event(:init) do
    NITRO.clear(:tableRow)
    NITRO.clear(:tableHead)
    NITRO.insert_top(:tableHead, index_header())
    NITRO.clear(:frms)
    NITRO.clear(:ctrl)
    mod = IOT.Forms.Create
    NITRO.insert_bottom(:frms, FORM.new(mod.new(mod, mod.id()), mod.id()))

    NITRO.insert_bottom(
      :ctrl,
      link(
        id: :creator,
        body: "New Device",
        postback: :create,
        class: [:button, :sgreen]
      )
    )

    NITRO.hide(:frms)

    IO.inspect :n2o.user()

    devices = case :n2o.user() do
        [] -> KVS.all('/iot/dev')
        IOT."Person"(cn: name) -> KVS.all('/iot/dev/'++ name)
    end

    IO.inspect devices

    for i <- devices do
      NITRO.insert_bottom(:tableRow,
        IOT.Rows.Device.new(
           FORM.atom([:iot, IOT."Device"(i, :id)]), i))
    end
  end

  def event({:device, id}) do
    NITRO.redirect('dev.htm?p=' ++ id)
  end

  def event({:discard, []}), do: [NITRO.hide(:frms), NITRO.show(:ctrl)]
  def event(:create), do: [NITRO.hide(:ctrl), NITRO.show(:frms)]
  def event(_), do: []
end
