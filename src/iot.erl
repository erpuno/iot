-module(iot).
-compile(export_all).
-behaviour(application).
-behaviour(supervisor).
-include("device.hrl").
-include("person.hrl").
-include("firmware.hrl").
-include("location.hrl").
-include("organization.hrl").
-include("event.hrl").
-include("provision.hrl").
-export([start/2, stop/1, init/1]).

start(_, _) ->
   kvs:join(),
   iot_boot:boot(),
   supervisor:start_link({local, ?MODULE}, ?MODULE, []).
stop(_State) -> ok.
init([]) -> {ok, { {one_for_one, 5, 10}, []} }.
