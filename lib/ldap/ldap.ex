defmodule LDAP.Index do
  use N2O, with: [:n2o, :nitro]
  use FORM
  require IOT
  require Logger

  def event(:init) do
    case N2O.user() do
      [] -> event({:off, []})
      _ -> event(:on)
    end
  end

  def event({:auth, form}) do
    cn = IOT.extract(:cn, :otp, form)
    branch = IOT.extract(:branch, :otp, form)
    IO.inspect cn

    case IOT.Application.auth(cn, branch) do
      {:ok, p} ->
        N2O.user(p) # IOT."Person" is stored into :ets.tab2list :cookies
        NITRO.redirect("iot.htm")

      {:error, e} ->
        IOT.box(
          LDAP.Forms.Error,
          {:error, 1, "The user cannot be found in this branch.", []}
        )
    end
  end

  def event({:close, _}), do: NITRO.redirect("kvs.htm")
  def event({:revoke, x}), do: [N2O.user([]), event({:off, x})]
  def event(:on), do: IOT.box(LDAP.Forms.Access, [])
  def event({:off, _}), do: IOT.box(LDAP.Forms.Credentials, [])
  def event(_), do: []
end
