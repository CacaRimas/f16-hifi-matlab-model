% Derivative of Kinematic Parameters Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of kinematic parameters calculation with using body axis
% angular rates, euler angles. The flight path equations are found in
% Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           phi => Roll angle (rad)
%           theta => Pitch angle (rad)
%           p => Body roll rate (rad/s)
%           q => Body pitch rate (rad/s)
%           r => Body yaw rate (rad/s)
%   Outputs:
%       ders => Derivative of state parameters.
%           phi_dot => Derivative of roll angle (rad/s)
%           theta_dot => Derivative of pitch angle (rad/s)
%           psi_dot => Derivative of yaw angle (rad/s)
% -------------------------------------------------------------------------
% =========================================================================

function eulerAngles = getDerivativeOfKinematics(states)
    %% -------------------------|State Variables|--------------------------
    phi = states.phi;
    theta = states.theta;
    p = states.p;
    q = states.q;
    r = states.r;
	% ---------------------------------------------------------------------
    %% ----------------|Derivative of Kinematic Equations|-----------------
    eulerAngles.phi = p+tan(theta)*(q*sin(phi)+r*cos(phi));
    eulerAngles.theta = q*cos(phi)-r*sin(phi);
    eulerAngles.psi = (q*sin(phi)+r*cos(phi))/cos(theta);
    % ---------------------------------------------------------------------
end % End of "Derivative of Kinematic Variables" Function.