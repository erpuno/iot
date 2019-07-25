-ifndef(EVENT_HRL).
-define(EVENT_HRL, true).

-include("location.hrl").

-record('Event', { id           = [] :: [] | term(),
                   date         = [] :: [] | date(),
                   time         = [] :: [] | time().
                   code         = [] :: [] | binary(),
                   type         = [] :: [] | atom(),
                   kind         = [] :: [] | atom(),
                   subsystem    = [] :: [] | atom(),
                   device       = [] :: [] | binary(),
                   payload      = [] :: [] | binary(),
        }).

-endif.
