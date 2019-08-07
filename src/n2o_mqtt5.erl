-module(n2o_mqtt5).
-compile(export_all).
-include_lib("n2o/include/n2o.hrl").

start_mqtt(Node) ->
    n2o_pi:start(#pi{module=n2o_mqtt5,table=mqtt, sup=n2o,state=[],name=Node}).

start_mqtt() ->
    lists:map(fun start_mqtt/1, n2o_ring:members(mqtt)).

proc(init,#pi{name=Name}=Async) ->
    {ok, Conn} = emqtt:start_link([{host,"xio-2.n2o.space"},
                                  {port,1883},
                                  {force_ping,true},
                                  {proto_ver,v5},
                                  {client_id,Name}]),
    io:format("INIT: ~p~n~p~n",[emqtt:connect(Conn),emqtt:subscribe(Conn, {<<"#">>,2})]),
    {ok,Async#pi{state=Conn}};

proc(Unknown,Async) ->
    io:format("MQTTv5: ~p~n",[Unknown]),
    {reply,{uknown,Unknown,0},Async}.
