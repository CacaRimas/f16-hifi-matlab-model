% Euler Angles Parameters to Quaternion Parameters
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Obtain quaternion parameters with using euler angles phi, theta, psi
% Equations can be found in Steven's "Aircraft Control and Simulation"
% The textbook are in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Aircraft state variables.
%           q_i => Quaternion parameters (i = 0, 1, 2, 3)
%   Outputs:
%       phi => Roll Angle (rad)
%       theta => Pitch Angle (rad)
%       psi => Yaw Angle (rad)       
% -------------------------------------------------------------------------
% =========================================================================

function [phi, theta, psi] = convQuaternions2EulerAngles(states)
    %% --------------------------|State Variables|-------------------------
    q0 = states.q0; % q0 Parameters (rad)
    q1 = states.q1; % q0 Parameters (rad)
    q2 = states.q2; % q0 Parameters (rad)
    q3 = states.q3; % q0 Parameters (rad)
    % ---------------------------------------------------------------------
    %% -------------------|Euler Angles Calculations|----------------------
    % DCM Matrix Elements
    cons1 = q0^2+q1^2-q2^2-q3^2;
    cons2 = 2*(q1*q2+q0*q3);
    cons3 = 2*(q1*q3-q0*q2);
    cons4 = 2*(q2*q3+q0*q1);
    cons5 = q0^2-q1^2-q2^2+q3^2;
    % Trigonometric Releations
    phi = atan2(cons4, cons5);
    theta = -atan(cons3);
    psi = atan2(cons2, cons1);
    % ---------------------------------------------------------------------
end % End of "Quaternion to Euler Conversion" Function