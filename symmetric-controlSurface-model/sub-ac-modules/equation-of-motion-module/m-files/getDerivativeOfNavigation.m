% Derivative of Flight Path Parameters Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of navigation (flight path) parameters calculation with
% using body axis speeds, euler angles. The flight path equations
% are found in Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           phi => Roll angle (rad)
%           theta => Pitch angle (rad)
%           psi => Yaw angle (rad)
%           u => Body X-Axis speeds (ft/s)
%           v => Body Y-Axis speeds (ft/s)
%           w => Body Z-Axis speeds (ft/s)
%   Outputs:
%       ders => Derivative of state parameters.
%           x_e_dot => Derivative of north position (ft/s)
%           y_e_dot => Derivative of east position (ft/s)
%           z_e_dot => Derivative of down position (ft/s)
% -------------------------------------------------------------------------
% =========================================================================

function nav = getDerivativeOfNavigation(states)
    %% -------------------------|State Information|------------------------
    phi = states.phi;
    theta = states.theta;
    psi = states.psi;
    u = states.u;
    v = states.v;
    w = states.w;
    %% ------------------|Some Trigonometric Shortcuts|--------------------
    sph = sin(phi); cph = cos(phi);
    sth = sin(theta); cth = cos(theta);
    sps = sin(psi); cps = cos(psi);
    % ---------------------------------------------------------------------
    %% ---------------|Derivative of Navigational Equations|---------------
    nav.x_e = u*cth*cps+v*(-cph*sps+sph*sth*cps)+w*(sph*sps+cph*sth*cps);
    nav.y_e = u*cth*sps+v*(cph*cps+sph*sth*sps)+w*(-sph*cps+cph*sth*sps);
    nav.z_e = u*sth-v*sph*cth-w*cph*cth;
    % ---------------------------------------------------------------------
end % End of "Derivative of Navigation Parameters" Function.