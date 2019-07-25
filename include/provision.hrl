-ifndef(PROVISION_HRL).
-define(PROVISION_HRL, true).

-include("firmware.hrl").
-include("device.hrl").

% target -- wildcard pattern for all devices
%            we should apply the new firmware

% parameters -- the new device records that patch the device tabe

-record('Provision', { id           = [] :: [] | term(),
                       program      = [] :: [] | binary(), % scripts
                       path         = [] :: [] | binary(),
                       firmware     = [] :: [] | #'Firmware'{},
                       paramaters   = [] :: [] | #'Device'{},
                       target       = [] :: [] | #'Device'{}
                    }).

-endif.
