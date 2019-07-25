-ifndef(FIRMWARE_HRL).
-define(FIRMWARE_HRL, true).

-include("device.hrl").

-record('Firmware', { id         = [] :: [] | term(),
                      vsn        = [] :: [] | term(),
                      models     = [] :: list(),
                      devices    = [] :: [] | #'Device'{}, % wildcard pattern
                      payload    = [] :: [] | binary() }).

-endif.
