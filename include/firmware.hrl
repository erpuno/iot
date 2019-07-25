-ifndef(FIRMWARE_HRL).
-define(FIRMWARE_HRL, true).

-include("device.hrl").

-record('Firmware', { id         = [] :: [] | term(),
                      vsn        = [] :: [] | term(),
                      devices    = [] :: [] | #'Device'{},
                      payload    = [] :: [] | binary() }).

-endif.
