% F-16's Cost Values Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Cost values function to calculate specific cost values with respect to
% trim conditions. To do that, optimization methodologies are used. These
% methodlogies can be found in MATLAB's documentation.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       initials => Initial condition of A/C's cost function.
%           tas => True airspeed (ft/s)
%           alpha => Angle of attack (deg)
%           beta => Angle of sideslip (deg)
%           phi => Roll angle (deg)
%           theta => Pitch angle (deg)
%           psi => Yaw angle (deg)
%           p => Roll rate (deg/s)
%           q => Pitch rate (deg/s)
%           r => Yaw rate (deg/s)
%           x_e => North position (ft)
%           y_e => East position (ft)
%           z_e => Down position (ft)
%           thrtl => Throttle position ()
%           ele => Elevator deflection ()
%           ail => Aileron deflection (deg)
%           rud => Rudder deflection (deg)
%           lef => Leading edge flap deflection (deg)
%           sb => Speed breaker deflection (deg)
%           phi_dot => Derivative of roll angle (deg/s)
%           theta_dot => Derivative of pitch angle (deg/s)
%           psi_dot => Derivative of yaw angle (deg/s)
%   Outputs:
%       outputs => Output of A/C's trim function.
%           trim => Trim information of F-16 such as states and controls
%           cost => Final cost value of trim optimization.
% -------------------------------------------------------------------------
% Notes:
%   For this version of cost function just steady level wing flight
% is investigated.
% =========================================================================

function [cost, states, controls] = getCostValues_Euler(initialsVar)
%% -------------------------|Global Variables|-------------------------
    global initials
    % ---------------------------------------------------------------------
    %% ------------------------|Initial Conditions|------------------------
    % State Variables Information
    states.tas = initials.tas; % True airspeed (ft)
    states.alpha = initialsVar(3); % Angle of attack (rad)
    states.beta = initialsVar(6); % Angle of sideslip (rad)
    states.phi = initials.phi; % Roll angle (rad)
    states.theta = initials.theta; % Pitch angle (rad)
    states.psi = initials.psi; % Yaw angle (rad)
    states.p = initials.p; % Roll angle (rad)
    states.q = initials.q; % Pitch angle (rad)
    states.r = initials.r; % Yaw angle (rad)
    states.x_e = initials.x_e; % North position (ft)
    states.y_e = initials.y_e; % East position (ft)
    states.z_e = initials.z_e; % Down position (ft)
    % Latitude and Longitude Addition
    states.lat = initials.lat; % Latitude (deg)
    states.long = initials.long; % Longitude (deg)
    % Control Inputs Information
    controls.throttle = initialsVar(1); % Throttle position ()
    controls.elevator = initialsVar(2); % Elevator deflection (deg)
    controls.aileron = initialsVar(4); % Aileron deflection (deg)
    controls.rudder = initialsVar(5); % Rudder deflection (deg)
    controls.sb = initials.sb; % Speed breaker deflection (deg)
    % Leading edge flap deflection (deg)
    controls.lef = getLeadingEdgeFlap(states); 
    states.power = getCommandedPower(controls); % Commanded Power (hp)
    % ---------------------------------------------------------------------
    %% ----------------------------|Constarints|---------------------------
    [states, controls] = getConstraints_Euler(states, controls, initials);
    % ---------------------------------------------------------------------
    %% -------------------------|Cost Caclulation|-------------------------
    % Flight Dynamics & EOM
    [ders, states] = getFlightDynamic_Eulers(states, controls);
    % Latitude and Longitude Addition
    states.lat = initials.lat; states.long = initials.long;
    % Structure Fields to Variable Conversion
    states_dot(1:3) = cell2mat(struct2cell(ders.windParams));
    states_dot(4:6) = cell2mat(struct2cell(ders.eulerAngles));
    states_dot(7:9) = cell2mat(struct2cell(ders.angRates));
    states_dot(10:12) = cell2mat(struct2cell(ders.nav));
    states_dot(13) = cell2mat(struct2cell(ders.power));
    % Cost Calculation
    weight = [1, 100, 100, 0, 0, 0, 10, 10, 10, 0, 0, 0, 0];
    cost = weight*(states_dot'.*states_dot');
    % ---------------------------------------------------------------------
end % End of "F-16's Cost Values" Function.