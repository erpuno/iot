defmodule NITRO.Routes do
  use N2O, with: [:n2o, :nitro]

  def finish(state, context), do: {:ok, state, context}

  def init(state, context) do
    %{path: path} = cx(context, :req)
    {:ok, state, cx(context, path: path, module: route_prefix(path))}
  end

  defp route_prefix(<<"/ws/", p::binary>>), do: route(p)
  defp route_prefix(<<"/", p::binary>>), do: route(p)
  defp route_prefix(path), do: route(path)

  def route(<<"ldap", _::binary>>), do: LDAP.Index
  def route(<<"kvs", _::binary>>), do: KVS.Index
  def route(<<"iot", _::binary>>), do: IOT.Index
  def route(<<"app/ldap", _::binary>>), do: LDAP.Index
  def route(<<"app/kvs", _::binary>>), do: KVS.Index
  def route(<<"app/iot", _::binary>>), do: IOT.Index
  def route(_), do: LDAP.Index
end
