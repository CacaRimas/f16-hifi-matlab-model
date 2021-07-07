% Acceleration Parameters Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% The calculation of acceleration parameters which is normal acceleration
% and lateral acceleration can be found with using body axis speeds, 
% body axis rates and euler angles. The acceleration parameter equations
% are found in Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           p => Body roll rate (rad/s)
%           q => Body pitch rate (rad/s)
%           r => Body yaw rate (rad/s)  
%           u => Body X-Axis speeds (ft/s)
%           v => Body Y-Axis speeds (ft/s)
%           w => Body Z-Axis speeds (ft/s)
%           phi => Roll angle (rad)
%           theta => Pitch angle (rad)ü
%       graParams => Gravity Parameters.
%           g_z => Gravity acceleration on Z-Axis (ft/s^2)
%       ders => Derivative parameters information.
%           bodySpeeds => Derivative of body peed parameter information.
%               w_dot => Z-Axis body speed derivation.
%               v_dot => Y-Axis body speed derivation.
%   Outputs:
%       states => State Information.
%           aN => Normal acceleration.
%           aY => Lateral acceleration.
% -------------------------------------------------------------------------
% =========================================================================

function [aN, aY] = getAccelerationParameters(states, graParams, ders)
%% -------------------------|State Variables|--------------------------
    u = states.u;
    v = states.v;
    w = states.w;
    phi = states.phi;
    theta = states.theta;
    p = states.p;
    q = states.q;
    r = states.r;
    % ---------------------------------------------------------------------
    %% ------------------------|Gravity Parameters|------------------------
    g = graParams.g_z;
    % ---------------------------------------------------------------------
    %% ----------------------|Derivative Information|----------------------
    v_dot = ders.bodySpeeds.v;
    w_dot = ders.bodySpeeds.w;
    % ---------------------------------------------------------------------
    %% --------------|Calculation of Acceleration Parameters|--------------
    % Comes from "F=m*a => a = F/m"
    aN = (q*u-p*v+g*cos(theta)*cos(phi)-w_dot)/g; 
    aY = (-p*w+r*u-g*cos(theta)*sin(phi)+v_dot)/g;
    % ---------------------------------------------------------------------
end % End of "Acceleration Parameters Calculation" Function.