-module(iot_boot).
-compile(export_all).
-include("organization.hrl").
-include("device.hrl").
-include("person.hrl").
-include("firmware.hrl").
-include("location.hrl").
-include("event.hrl").
-include("provision.hrl").
-include("person.hrl").
-include_lib("kvs/include/kvs.hrl").
-include_lib("kvs/include/metainfo.hrl").
-include_lib("kvs/include/cursors.hrl").
-define(IOT_PF,"/iot/").

select_rnd(MF) ->
    #'Manufacturer'{name=N} =  lists:nth(rand:uniform(length(MF)), MF),
    N.

register_devices(Client, Model) ->
    kvs:append(#'Device'{id = kvs:seq([], []),
			 manufacturer =
			     select_rnd(kvs:all('/iot/manufacturer'))},
	       "/iot/dev/" ++ Client ++ "/" ++ Model).

register_event(Id,#'Event'{}=Event) ->
   kvs:append(Event#'Event'{id = kvs:seq([],[])}, "/iot/" ++ Id).

boot_events() ->
   lists:map(fun(#'Person'{cn=Client}=Person) ->
      lists:map(fun(#'Device'{id=Id}) ->
        register_event(Id,
          #'Event'{id=kvs:seq([],[]),
                   device=id,
                   from=Client,
                   to=Client
                   }) end, kvs:all("/iot/dev/" ++ Client))
      end, kvs:all("/iot/clients")).

boot_models(#'Person'{cn=Client}) ->
   lists:map(fun (Model) ->
      register_devices(Client,Model) end, models()).

models() ->
   ["Android","iPhone","Windows"].

boot_clients() ->
   lists:map(fun (Client) ->
      boot_models(Client) end, clients()).

clients() ->
  [ #'Person'{id="1",cn="Maxim"},
    #'Person'{id="2",cn="Radostin"},
    #'Person'{id="3",cn="Anton"},
    #'Person'{id="4",cn="Georgi"},
    #'Person'{id="5",cn="Vyacheslav"} ].

index_PersonCN() ->
   lists:map(fun (#'Person'{id=ID,cn=CN}) ->
      kvs:put(#'PersonCN'{cn=CN,id=ID}) end, clients()).
   
boot_manufacturer()->
   [kvs:append(M,"/iot/manufacturer") || M <- manufacturer()].

manufacturer()->
   [#'Manufacturer'{id = kvs:seq([],[]), name = N} || 
      N <- ["siemens","SATEC","GreenEmbedded"]].

boot() ->
   boot_manufacturer(),
   boot_root(),
   boot_clients(),
   index_PersonCN(),
   boot_events().

boot_root() ->
    Group   = [ #'Organization'{name="Quanterall"} ],
   
    Structure    = [ {"/iot/clients", clients()},
                     {"/iot/company", Group}
                  ],

    lists:foreach(fun({Feed, Data}) ->
        case kvs:get(writer, Feed) of
             {ok,_} -> skip;
          {error,_} -> lists:map(fun(X) ->
                       kvs:append(X,Feed) end, Data) end
                  end, Structure).
