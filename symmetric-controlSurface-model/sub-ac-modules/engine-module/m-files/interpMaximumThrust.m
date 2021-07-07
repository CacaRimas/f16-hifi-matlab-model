% Maximum Thrust Interpolation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Maximum Thrust calculation function at specific altitude and speed
% conditions. Maximum thrust data are taken from Steven's "Aircraft Control 
% and Simulation" textbook. The textbook can be found in "references"
% folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states: Aircraft state information.
%           z_e => Altitude (ft)
%       atmParams: Atmospheric Properties.
%           mach => Mach number ()
%       data => Engine thrust data.
%           maximum => maximum thrust data.
%   Outputs:
%       maximum: maximum thrust value.
% -------------------------------------------------------------------------
% =========================================================================

function maximum = interpMaximumThrust(data, states, atmParams)
    %% -------------------------|Data Information|-------------------------
    % Look-up Table
    tableMaximum = data.engine.thrust.table.maximum.T;
    % Reference Signals
    refMach = data.engine.thrust.table.refSignals.mach;
    refAlt = data.engine.thrust.table.refSignals.z_e;
    % ---------------------------------------------------------------------
    %% --------------------------|State Variables|-------------------------
    z_e = states.z_e;
    % ---------------------------------------------------------------------
    %% ---------------------|Atmospheric Properties|-----------------------
    mach = atmParams.mach;
    % ---------------------------------------------------------------------
    %% ------------------|Maximum Thrust Interpolation|--------------------
    maximum = interp2(refAlt, refMach, tableMaximum, z_e, mach);
    % ---------------------------------------------------------------------
end % End of "Maximum Thrust Calculation" Function.