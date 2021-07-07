% Military Thrust Interpolation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Military Thrust calculation function at specific altitude and speed
% conditions. Military thrust data are taken from Steven's "Aircraft Control 
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
%           military => military thrust data.
%   Outputs:
%       military: Military thrust value.
% -------------------------------------------------------------------------
% =========================================================================

function military = interpMilitaryThrust(data, states, atmParams)
    %% -------------------------|Data Information|-------------------------
    % Look-up Table
    tableMilitary = data.engine.thrust.table.military.T;
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
    %% ------------------|Military Thrust Interpolation|-------------------
    military = interp2(refAlt, refMach, tableMilitary, z_e, mach);
    % ---------------------------------------------------------------------
end % End of "Military Thrust Calculation" Function.