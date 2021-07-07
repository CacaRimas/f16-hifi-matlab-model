% Derivative of Force Parameters Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of force parameters calculation with using body axis
% speeds, aerodynamic forces, euler angles, gravity, thrust and body axis
% angular rates. The flight path equations are found in
% Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           u => Body X-Axis speeds (ft/s)
%           v => Body Y-Axis speeds (ft/s)
%           w => Body Z-Axis speeds (ft/s)           
%           phi => Roll angle (rad)
%           theta => Pitch angle (rad)
%           p => Body roll rate (rad/s)
%           q => Body pitch rate (rad/s)
%           r => Body yaw rate (rad/s)
%       forces => Aerodynamic forces.
%           X => X-Axis aerodynamic forces (lbf)
%           Y => Y-Axis aerodynamic forces (lbf)
%           Z => Z-Axis aerodynamic forces (lbf)
%       graParams => Gravity Parameters.
%           g_z => Gravity acceleration on Z-Axis (ft/s^2)
%       thrust => Thrust Information.
%           T => Thrust magnitude value. (lbf)
%       data => Aircraft Specifications.
%           G => Aircraft Weight (empty) (lbf)
%   Outputs:
%       ders => Derivative of state parameters.
%           u_dot => Derivative of X-axis speed (ft/s^2)
%           v_dot => Derivative of Y-axis speed (ft/s^2)
%           w_dot => Derivative of Z-axis speed (ft/s^2)
% -------------------------------------------------------------------------
% =========================================================================

function bodySpeeds = getCLMEforces(states, forces, graParams, thrust, ...
    data)
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
    %% ------------------------|Aerodynamic Forces|------------------------
    X = forces.X;
    Y = forces.Y;
    Z = forces.Z;
    % ---------------------------------------------------------------------
    %% ------------------------|Gravity Parameters|------------------------
    g = graParams.g_z;
    % ---------------------------------------------------------------------
    %% ---------------------------|Thrust Value|---------------------------
    T = thrust.total.T;
    % ---------------------------------------------------------------------
    %% ---------------------|Aircraft Specifications|----------------------
    weight = data.acSpec.general.empWeight;
    mass = weight/g;
    % ---------------------------------------------------------------------
    %% ----------------|Derivative of Body Speed Equations|----------------
    bodySpeeds.u = r*v-q*w-g*sin(theta)+(X+T)/mass;
    bodySpeeds.v = p*w-r*u+g*cos(theta)*sin(phi)+Y/mass;
    bodySpeeds.w = q*u-p*v+g*cos(theta)*cos(phi)+Z/mass;
    % ---------------------------------------------------------------------
end % End of "Derivative of Kinematic Variables" Function.