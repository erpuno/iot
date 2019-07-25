-ifndef(EVENT_HRL).
-define(EVENT_HRL, true).

-include("location.hrl").

-record('Event', { id           = [] :: [] | term(),
                   date         = [] :: [] | {integer(),integer(),integer()},
                   time         = [] :: [] | {integer(),integer(),integer()},
                   code         = [] :: [] | binary(),
                   type         = [] :: [] | atom(),
                   kind         = [] :: [] | atom(),
                   subsystem    = [] :: [] | atom(),
                   device       = [] :: [] | binary(),
                   payload      = [] :: [] | binary()
        }).

-endif.
