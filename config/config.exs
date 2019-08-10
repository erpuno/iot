use Mix.Config

config :n2o,
  pickler: :n2o_secret,
  mqtt_services: [:siemens,:"SATEC",:"GreenEmbedded"],
  ws_services: [:chat,:erp],
  proto: IOT.Server,
  mq: :n2o_syn,
  port: 8044,
  ttl: 60*3,
  upload: "./priv/static",
  protocols: [:n2o_heart, :n2o_nitro],
  routes: NITRO.Routes

config :kvs,
  dba: :kvs_rocks,
  dba_st: :kvs_st,
  schema: [:kvs]
