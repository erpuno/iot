defmodule IOT.Server do
  use N2O, with: [:n2o, :kvs]
  require IOT

  def info(IOT."Device"(id: id) = msg, r, s) do
    key = '/iot/' ++ id
    KVS.append(msg, key)
    IO.inspect msg
    {:reply, {:binary, "1234"}, r, s}
  end

  def info(msg, r, s), do: {:unknown, msg, r, s}
end
