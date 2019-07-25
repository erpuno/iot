-ifndef(PROVISION_HRL).
-define(PROVISION_HRL, true).

-include("firmware.hrl").
-include("device.hrl").

-record('Provision', { id           = [] :: [] | term(),
                       program      = [] :: [] | binary(),
                       path         = [] :: [] | binary(),
                       firmware     = [] :: [] | #'Firmware'{},
                       paramaters   = [] :: [] | #'Device'{},
                       target       = [] :: [] | #'Device'{}
                    }).

-endif.
