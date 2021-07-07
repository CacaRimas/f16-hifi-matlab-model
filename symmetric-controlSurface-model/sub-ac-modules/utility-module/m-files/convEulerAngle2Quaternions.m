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
%           phi => Roll Angle (rad)
%           theta => Pitch Angle (rad)
%           psi => Yaw Angle (rad)
%   Outputs:
%       q_i => Quaternion parameters (i = 0, 1, 2, 3)
% -------------------------------------------------------------------------
% =========================================================================

function [q0, q1, q2, q3] = convEulerAngle2Quaternions(states)
    %% --------------------------|State Variables|-------------------------
    phi = states.phi; % Roll Angle (rad)
    theta = states.theta; % Theta Angle (rad)
    psi = states.psi; % Yaw Angle (rad)
    % ---------------------------------------------------------------------
    %% --------------------|Quaternion Calculations|-----------------------
    q0 = cos(phi/2)*cos(theta/2)*cos(psi/2)+ ...
     sin(phi/2)*sin(theta/2)*sin(psi/2);
    q1 = sin(phi/2)*cos(theta/2)*cos(psi/2)- ...
     cos(phi/2)*sin(theta/2)*sin(psi/2);
    q2 = cos(phi/2)*sin(theta/2)*cos(psi/2)+ ...
     sin(phi/2)*cos(theta/2)*sin(psi/2);
    q3 = cos(phi/2)*cos(theta/2)*sin(psi/2)- ...
     sin(phi/2)*sin(theta/2)*cos(psi/2);
    % ---------------------------------------------------------------------
end % End of "Euler to Quaternion Conversion" Function