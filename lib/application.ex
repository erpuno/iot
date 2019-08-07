defmodule IOT.Application do
  use Application
  require IOT

  def auth(cn, _branch) do
    case :kvs.get(:PersonCN, cn) do
      {:ok, IOT."PersonCN"(id: id)} -> :kvs.get('/iot/clients', id)
      x -> x
    end
  end

  def start(_, _) do
    :kvs.join()
    :iot_boot.boot()
    :cowboy.start_tls(:http, :n2o_cowboy.env(:iot), %{env: %{dispatch: :n2o_cowboy2.points()}})
    :n2o.start_ws
    :n2o_mqtt5.start_mqtt
    Supervisor.start_link([], strategy: :one_for_one, name: IOT.Supervisor)
  end
end
