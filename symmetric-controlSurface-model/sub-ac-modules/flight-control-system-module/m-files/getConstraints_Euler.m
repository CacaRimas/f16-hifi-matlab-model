% F-16's Constraints Define Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Constraint function is define the general constraints for F-16 such as
% AoA limits, deflection limits, etc. After obtaining these constraints,
% flight dynamic function can be applied to find derivative of state
% variables.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           tas => True airspeed (ft/s)
%           alpha => Angle of attack (rad)
%           beta => Angle of sideslip (rad)
%           phi => Roll angle (rad)
%           theta => Pitch angle (rad)
%           psi => Yaw angle (rad)
%           p => Roll rate (rad/s)
%           q => Pitch rate (rad/s)
%           r => Yaw rate (rad/s)
%           x_e => North position (ft)
%           y_e => East position (ft)
%           z_e => Down position (ft)
%           power => Power values (hp)
%       controls => Whole control input variables.
%           throttle => Throttle position ()
%           elevator => Elevator deflection (deg)
%           aileron => Aileron deflection (deg)
%           rudder => Rudder deflection (deg)
%           lef => Leading edge flap deflection (deg)
%           sb => Speed breaker deflection (deg)
%       initials => Initial values for specific variables.
%           phi_dot => Derivative of roll angle (deg/s)
%           theta_dot => Derivative of pitch angle (deg/s)
%           psi_dot => Derivative of yaw angle (deg/s)
%   Outputs:
%       outputs => Output of A/C's trim function.
%       states => Whole aircraft constrainted state variables.
%           tas => True airspeed (ft/s)
%           alpha => Angle of attack (rad)
%           beta => Angle of sideslip (rad)
%           phi => Roll angle (rad)
%           theta => Pitch angle (rad)
%           psi => Yaw angle (rad)
%           p => Roll rate (rad/s)
%           q => Pitch rate (rad/s)
%           r => Yaw rate (rad/s)
%           x_e => North position (ft)
%           y_e => East position (ft)
%           z_e => Down position (ft)
%           power => Power values (hp)
%       controls => Whole control input variables.
%           throttle => Throttle position ()
%           elevator => Elevator deflection (deg)
%           aileron => Aileron deflection (deg)
%           rudder => Rudder deflection (deg)
%           lef => Leading edge flap deflection (deg)
% -------------------------------------------------------------------------
% Notes:
%   For this version of constraint function just steady level wing flight
% is investigated.
% =========================================================================

function [states, controls] = getConstraints_Euler(states, controls, ...
     initials)
    %% -------------------------|Global Variables|-------------------------
    global flag
    % ---------------------------------------------------------------------
    %% -----------------------------|Gravity|------------------------------
    graParams = getGravityParams(states);
    % ---------------------------------------------------------------------
    %% ------------------------ |Initial Conditions|-----------------------
    phi = states.phi;
    phi_dot = initials.phi_dot;
    theta_dot = initials.theta_dot;
    psi_dot = initials.psi_dot;
    rateOfClimb = initials.rateOfClimb;
    gamma = initials.gamma;
    % ---------------------------------------------------------------------
    %% ------------------------|Trigonometric Eqs|-------------------------
    calph = cos(states.alpha); salph = sin(states.alpha);
    cbeta = cos(states.beta); sbeta = sin(states.beta);
    % ---------------------------------------------------------------------
    %% ------------------------|State Constraints|-------------------------
    if flag.corTurn == 'Y' % Climb is On
        sgamma = rateOfClimb;
        grand_G = psi_dot*states.tas/graParams.g_z;
        % Phi
        a_phi = 1-grand_G*tan(states.alpha)*sbeta;
        b_phi = sgamma/cbeta;
        c_phi = 1+(grand_G^2)*(cbeta)^2;
        tan_phi = grand_G*(cbeta/calph)*(((a_phi-b_phi^2)+ ...
            b_phi*tan(states.alpha)*(c_phi*(1-b_phi^2)+(grand_G^2)*sbeta^2)^(0.5))/ ...
            (a_phi^2 - b_phi^2*(1+c_phi*tan(states.alpha)^2)));
        phi = atan(tan_phi);
        % Theta
        a_theta = calph*cbeta;
        b_theta = sin(phi)*sbeta+cos(phi)*salph*cbeta;
        tan_theta = (a_theta*b_theta+sgamma*sqrt((a_theta^2)-(sgamma^2)+...
            b_theta^2))/(a_theta^2-(sgamma^2));
        theta = atan(tan_theta);
        % PQR
        C_br = [1  0        -sin(theta);
                0  cos(phi)  sin(phi)*cos(theta);
                0 -sin(phi)  cos(phi)*cos(theta)];
        w_br = C_br*[phi_dot; theta_dot; psi_dot];
        p = w_br(1); q = w_br(2); r = w_br(3);
        % Outputs
        states.phi = phi;
        states.theta = theta;
        states.p = p;
        states.q = q;
        states.r = r;
    elseif flag.corTurn == 'N'
        sgamma = sin(gamma);
        % Theta
        a_theta = calph*cbeta;
        b_theta = sin(phi)*sbeta+cos(phi)*salph*cbeta;
        tan_theta = (a_theta*b_theta+sgamma*sqrt((a_theta^2)-(sgamma^2)+...
            b_theta^2))/(a_theta^2-(sgamma^2));
        theta = atan(tan_theta);
        % PQR
        C_br = [1  0        -sin(theta);
                0  cos(phi)  sin(phi)*cos(theta);
                0 -sin(phi)  cos(phi)*cos(theta)];
        w_br = C_br*[phi_dot; theta_dot; psi_dot];
        p = w_br(1); q = w_br(2); r = w_br(3);
        % Outputs
        states.phi = phi;
        states.theta = theta;
        states.p = p;
        states.q = q;
        states.r = r;
    elseif flag.trimCon == 3
        sgamma = sin(gamma);
        % Theta
        a_theta = calph*cbeta;
        b_theta = sin(phi)*sbeta+cos(phi)*salph*cbeta;
        tan_theta = (a_theta*b_theta+sgamma*sqrt((a_theta^2)-(sgamma^2)+...
            b_theta^2))/(a_theta^2-(sgamma^2));
        theta = atan(tan_theta);
        % PQR
        C_br = [1  0        -sin(theta);
                0  cos(phi)  sin(phi)*cos(theta);
                0 -sin(phi)  cos(phi)*cos(theta)];
        w_br = C_br*[phi_dot; theta_dot; psi_dot];
        p = w_br(1); q = w_br(2); r = w_br(3);
        % Outputs
        states.phi = phi;
        states.theta = theta;
        states.p = p;
        states.q = q;
        states.r = r;
    elseif flag.trimCon == 4
        sgamma = sin(gamma);
        % Theta
        a_theta = calph*cbeta;
        b_theta = sin(phi)*sbeta+cos(phi)*salph*cbeta;
        tan_theta = (a_theta*b_theta+sgamma*sqrt((a_theta^2)-(sgamma^2)+...
            b_theta^2))/(a_theta^2-(sgamma^2));
        theta = atan(tan_theta);
        % PQR
        C_br = [1  0        -sin(theta);
                0  cos(phi)  sin(phi)*cos(theta);
                0 -sin(phi)  cos(phi)*cos(theta)];
        w_br = C_br*[phi_dot; theta_dot; psi_dot];
        p = w_br(1); q = w_br(2); r = w_br(3);
        % Outputs
        states.phi = phi;
        states.theta = theta;
        states.p = p;
        states.q = q;
        states.r = r;
    elseif flag.trimCon == 5
        sgamma = rateOfClimb/states.tas;
        % Theta
        a_theta = calph*cbeta;
        b_theta = sin(phi)*sbeta+cos(phi)*salph*cbeta;
        tan_theta = (a_theta*b_theta+sgamma*sqrt((a_theta^2)-(sgamma^2)+...
            b_theta^2))/(a_theta^2-(sgamma^2));
        theta = atan(tan_theta);
        % PQR
        C_br = [1  0        -sin(theta);
                0  cos(phi)  sin(phi)*cos(theta);
                0 -sin(phi)  cos(phi)*cos(theta)];
        w_br = C_br*[phi_dot; theta_dot; psi_dot];
        p = w_br(1); q = w_br(2); r = w_br(3);
        % Outputs
        states.phi = phi;
        states.theta = theta;
        states.p = p;
        states.q = q;
        states.r = r;
    else
        gamma = 0; % Flight Path Angle it is 0 for steady level flights.
        a_theta = calph*cbeta;
        b_theta = sphi*sbeta+cphi*salph*cbeta;
        tan_theta = (a_theta*b_theta+gamma*sqrt(a_theta^2-gamma^2+ ...
         b_theta^2))/(a_theta^2-gamma^2);
        theta = atan(tan_theta);
        C_br = [1  0        -sin(theta);
                0  cos(phi)  sin(phi)*cos(theta);
                0 -sin(phi)  cos(phi)*cos(theta)];
        w_br = C_br*[phi_dot; theta_dot; psi_dot];
        p = w_br(1); q = w_br(2); r = w_br(3);
        % Outputs
        states.theta = theta;
        states.p = p;
        states.q = q;
        states.r = r;
    end
    % ---------------------------------------------------------------------
    %% ------------------------------|Limits|------------------------------
    % Throttle Limit
    if controls.throttle > 1; controls.throttle = 1;
    elseif controls.throttle < 0; controls.throttle = 0;
    end
    % Elevator Limit
    if controls.elevator > 25; controls.elevator = 25;
    elseif controls.elevator < -25; controls.elevator = -25;
    end
    % Aileron Limit
    if controls.aileron > 21.5; controls.aileron = 21.5;
    elseif controls.aileron < -21.5; controls.aileron = -21.5;
    end
    % Rudder Limit
    if controls.rudder > 30; controls.rudder = 30;
    elseif controls.rudder < -30; controls.rudder = -30;
    end
    % Leading Edge Flap Limit
    if controls.lef > 25; controls.lef = 25;
    elseif controls.lef < 0; controls.lef = 0;
    end
    % Speed Breaker Limit
    if controls.sb > 60; controls.sb = 60;
    elseif controls.sb < 0; controls.sb = 0;
    end
    % Angle of Attack Limit
    if states.alpha > deg2rad(90); states.alpha = deg2rad(90);
    elseif states.alpha < deg2rad(-20); states.alpha = deg2rad(-20);
    end
    % Angle of Sideslip Limit
    if states.beta > deg2rad(30); states.beta = deg2rad(30);
    elseif states.beta < deg2rad(-30); states.beta = deg2rad(-30);
    end
    % ---------------------------------------------------------------------
end % End of "F-16 Constraint" Function.
