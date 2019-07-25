-ifndef(EVENT_HRL).
-define(EVENT_HRL, true).

-include("location.hrl").

% 2. emit new device event
% kvs:append(#'Event'{id = kvs:seq([],[])},
%              "/iot/:device_id").

-record('Event', { id           = [] :: [] | term(),
                   date         = [] :: [] | {integer(),integer(),integer()},
                   time         = [] :: [] | {integer(),integer(),integer()},
                   code         = [] :: [] | binary(),
                   type         = [] :: [] | atom(),
                   kind         = [] :: [] | atom(),
                   subsystem    = [] :: [] | atom(),
                   device       = [] :: [] | binary(),
                   from         = [] :: [] | binary(),
                   to           = [] :: [] | binary(),
                   payload      = [] :: [] | binary()
        }).

-endif.
