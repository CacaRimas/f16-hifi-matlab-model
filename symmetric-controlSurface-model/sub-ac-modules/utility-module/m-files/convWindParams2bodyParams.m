% Wind Axis Parameters to Body Axis Parameters.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Obtain body axis parameters with using wind axis parameters such as,
% angle of attack, angle of sideslip and true airspeed. Equations can be
% found in Steven's "Aircraft Control and Simulation" The textbook are
% in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Aircraft state variables.
%           tas => True airspeed (ft/s)
%           alpha => Angle of attack (rad)
%           beta => Angle of sideslip (rad)
%   Outputs:
%       u => Body X-axis speed (ft/s)
%       v => Body Y-axis speed (ft/s)
%       w => Body Z-axis speed (ft/s)
% -------------------------------------------------------------------------
% =========================================================================

function [u, v, w] = convWindParams2bodyParams(states)
    %% -------------------------|State Variables|--------------------------
    tas = states.tas; % True Airspeed (ft/sec)
    alpha = states.alpha; % Angle of Attack (rad)
    beta = states.beta; % Sideslip Angle (rad)
    % ---------------------------------------------------------------------
    %% ------------------------|Body Axes Speeds|--------------------------
    u = tas*cos(alpha)*cos(beta);
    v = tas*sin(beta);
    w = tas*sin(alpha)*cos(beta);
    % ---------------------------------------------------------------------
end % End of "Wind Parameters to Body Axis Parameters" Function.