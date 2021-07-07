% Idle Thrust Interpolation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Idle Thrust calculation function at specific altitude and speed
% conditions. Idle thrust data are taken from Steven's "Aircraft Control 
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
%           idle => Idle thrust data.
%   Outputs:
%       idle: Idle thrust value.
% -------------------------------------------------------------------------
% =========================================================================

function idle = interpIdleThrust(data, states, atmParams)
    %% -------------------------|Data Information|-------------------------
    % Look-up Table
    tableIdle = data.engine.thrust.table.idle.T;
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
    %% ------------------|Idle Thrust Interpolation|-----------------------
    idle = interp2(refAlt, refMach, tableIdle, z_e, mach);
    % ---------------------------------------------------------------------
end % End of "Idle Thrust Calculation" Function.