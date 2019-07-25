-ifndef(DEVICE_HRL).
-define(DEVICE_HRL, true).

-include("location.hrl").

-record('Device', { id           = [] :: [] | term(),
                    cn           = [] :: [] | binary(),
                    owner        = [] :: [] | binary(),
                    name         = [] :: [] | binary(),
                    location     = [] :: #'Loc'{},
                    type         = 00 :: integer(),
                    model        = [] :: term(),
                    manufacturer = [] :: [] | binary(),
                    serial       = [] :: [] | binary(),
                    firmware     = [] :: [] | binary(),
                    hardware     = [] :: [] | binary(),
                    mac          = [] :: [] | binary(),
                    ipv4         = [] :: [] | binary(),
                    ipv6         = [] :: [] | binary(),
                    os           = [] :: [] | atom(),
                    properties   = [] :: list(),
                    protocol     = [] :: list(),
                    speed        = 00 :: integer(),
                    path         = [] :: list(),
                    pki_info     = 00 :: integer()
        }).

-endif.
