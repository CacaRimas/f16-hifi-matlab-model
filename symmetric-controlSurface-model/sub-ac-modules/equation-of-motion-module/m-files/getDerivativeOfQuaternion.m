% Derivative of Quaternion Parameters Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of quaternion parameters calculation with using body axis
% angular rates and quaternions. The equation of quaternion parameters
% calculation is in Steven's "Aircraft Control and Simulation"
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           q_i => Quaternion parameters.
%           p => Body roll rate (rad/s)
%           q => Body pitch rate (rad/s)
%           r => Body yaw rate (rad/s)
%   Outputs:
%       ders => Derivative of state parameters.
%           q_i => Derivative of quaternion parameters.
% -------------------------------------------------------------------------
% =========================================================================

function quaternion = getDerivativeOfQuaternion(states)
%% ---------------------------|State Variables|----------------------------
    q0 = states.q0; % q0 Angle [rad]
    q1 = states.q1; % q1 Angle [rad]
    q2 = states.q2; % q2 Angle [rad]
    q3 = states.q3; % q3 Angle [rad]
    p = states.p; % Roll Rate [rad/sec]
    q = states.q; % Pitch rate [rad/sec]
    r = states.r; % Yaw rate [rad/sec]
% -------------------------------------------------------------------------
%% ------------------|Derivative of Kinematic Equations|-------------------
    quaternion.q0 = 0.5*(-p*q1-q*q2-r*q3);
    quaternion.q1 = 0.5*(p*q0+r*q2-q*q3);
    quaternion.q2 = 0.5*(q*q0-r*q1+p*q3);
    quaternion.q3 = 0.5*(r*q0+q*q1-p*q2);
% -------------------------------------------------------------------------
end % End of "Derivative of Quaternion Variables" Function.

