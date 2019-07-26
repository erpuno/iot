defmodule IOT.Device do
  use N2O, with: [:n2o, :kvs, :nitro]
  use FORM, with: [:form]
  require IOT
  require Logger

  def header() do
    panel(
      id: :header,
      class: :th,
      body: [
        panel(class: :column6, body: "No"),
        panel(class: :column6, body: "Date"),
        panel(class: :column6, body: "Time"),
        panel(class: :column6, body: "Code"),
        panel(class: :column6, body: "Type"),
        panel(class: :column6, body: "Kind")
      ]
    )
  end

  def ok(id) do
    NITRO.insert_top(:tableHead, IOT.Device.header())

    IO.inspect id
    for i <- :kvs.all('/iot/'++id) do
      NITRO.insert_bottom(
        :tableRow,
        IOT.Rows.Event.new(NITRO.to_list(IOT."Event"(i, :id)), i))
    end
  end

  def event(:init) do
    id = :p |> NITRO.qc() |> NITRO.to_list()
    NITRO.update(:num, id)
    NITRO.update(:n, id)

    case N2O.user() do
      [] ->
        IOT.box(
          IOT.Forms.Error,
          {:error, 1, "Not authenticated",
           "User must be authenticated in order to view the device events."}
        )

      _ ->
        event({:txs, id})
    end
  end

  def event({:txs, id}) do
    NITRO.clear(:tableHead)
    NITRO.clear(:tableRow)
    ok(id)
  end

  def event(_), do: []
end
