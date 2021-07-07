% Derivative of Wind Parameters Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of wing parameters calculation with using body axis speeds,
% true airspeed and angle of sideslip. The wind parameter equations
% are found in Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           tas => True airspeed (ft/s)
%           beta => Angle of sideslip (rad/s)
%           u => Body X-Axis speeds (ft/s)
%           v => Body Y-Axis speeds (ft/s)
%           w => Body Z-Axis speeds (ft/s)
%   Outputs:
%       ders => Derivative of state parameters.
%           tas_dot => Derivative of true airspeed (ft/s^2)
%           alpha_dot => Derivative of angle of attack (rad/s)
%           beta_dot => Derivative of angle of sideslip (rad/s)
% -------------------------------------------------------------------------
% =========================================================================

function windParams = getDerivativeOfWindParameters(states, ders)
    %% -------------------------|State Variables|--------------------------
    tas = states.tas;
    beta = states.beta;
    u = states.u;
    v = states.v;
    w = states.w;
    % ---------------------------------------------------------------------
    %% -----------------------|Derivative Variables|-----------------------
    uDot = ders.bodySpeeds.u;
    vDot = ders.bodySpeeds.v;
    wDot = ders.bodySpeeds.w;
    % ---------------------------------------------------------------------
    %% ----------------|Derivative of Wind Params Equations|---------------
    windParams.tas = (u*uDot+v*vDot+w*wDot)/tas;
    windParams.alpha = (u*wDot-w*uDot)/((u^2)+(w^2));
    windParams.beta = 0;
    windParams.beta = (tas*vDot-v*windParams.tas)*cos(beta)/((u^2)+(w^2));
    % ---------------------------------------------------------------------
end % End of "Wind Parameters Derivative Calculation" Function.