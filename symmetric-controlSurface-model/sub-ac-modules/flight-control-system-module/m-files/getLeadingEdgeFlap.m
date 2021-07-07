% Leading Edge Flap Calculation Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% LEF calculation function to calculate leading edge flap deflection wtih
% using some state and atmospheric parameters. To LEF calculation
% function's are taken from Steven's "Aircraft Control and Simulation"
% textbook. The textbook also, be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Aircraft state variables.
%           tas => True airspeed (ft/s)
%           alpha => Angle of attack (rad)
%           z_e => Down position (ft)
%   Outputs:
%       lef = Leading edge flap deflection (deg)
% -------------------------------------------------------------------------
% =========================================================================

function lef = getLeadingEdgeFlap(states)
    %% --------------------------|State Variables|-------------------------
    alpha = rad2deg(states.alpha);
    % ---------------------------------------------------------------------
    %% ----------------------|Atmospheric Properties|----------------------
    atmParams = getAtmosphereParams(states);
    qbar = atmParams.qbar;
    psta = atmParams.psta;
    % ---------------------------------------------------------------------
    %% --------------------------|LEF Deflection|--------------------------
    lef = 1.38*alpha-9.05*qbar/psta+1.45;
    % ---------------------------------------------------------------------
end % End of "Leading Edge Flap Deflection Calculation" Function.