% F-16's Flight Dynamic Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole nonlinear equations are calculated in this function and result of
% these equations give derivatives of parameters. All nonlinear equations
% are found in Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
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
%   Outputs:
%       ders => Derivative of state parameters.
%           tas_dot => Derivative of true airspeed (ft/s^2)
%           alpha_dot => Derivative of angle of attack (rad/s)
%           beta_dot => Derivative of angle of sideslip (rad/s)
%           phi_dot => Derivative of roll angle (rad/s)
%           theta_dot => Derivative of pitch angle (rad/s)
%           psi_dot => Derivative of yaw angle (rad/s)
%           p_dot => Derivative of roll rate (rad/s^2)
%           q_dot => Derivative of pitch rate (rad/s^2)
%           r_dot => Derivative of yaw rate (rad/s^2)
%           x_e_dot => Derivative of north position (ft/s)
%           y_e_dot => Derivative of east position (ft/s)
%           z_e_dot => Derivative of down position (ft/s)
%           power_dot => Derivative of power values (hp/s)
%       calcs => Calculated informations
%           q_i => Quaternions ()
%           a_n => Normal acceleration (g)
%           a_y => Lateral acceleration (g)
%           lat => Latitude (deg)
%           long => Longitude (deg)
% -------------------------------------------------------------------------
% =========================================================================

function [ders, states] = getFlightDynamic_Eulers(states, controls)
    %% ---------------------|Loading Aerodynamic Data|---------------------
    data.aero = load('highFidelityF16AeroData.mat');
    data.acSpec = load('highFidelityF16ACSpecData.mat');
    data.engine = load('highFidelityF16EngineData.mat');
    data.aero = data.aero.aero; % Aerodynamic Data Correction.
    data.acSpec = data.acSpec.acSpec; % A/C Spec Data Correction.
    data.engine = data.engine.engine; % Engine Data Correction
    % ---------------------------------------------------------------------
    %% -----------------------|Environment Modules|------------------------
    atmParams = getAtmosphereParams(states);
    graParams = getGravityParams(states);
    % ---------------------------------------------------------------------
    %% -----------------------|Aerodynamic Modules|------------------------
    % Force and Moment Coefficients Interpolation
    coeffs.xaxis = interpCxCoeffs(states, controls, data);
    coeffs.yaxis = interpCyCoeffs(states, data);
    coeffs.zaxis = interpCzCoeffs(states, controls, data);
    coeffs.roll = interpClCoeffs(states, controls, data);
    coeffs.pitch = interpCmCoeffs(states, controls, data);
    coeffs.yaw = interpCnCoeffs(states, controls, data);
    % Total Aerodynamic Force and Moment Coefficients
    coeffs.total.Cx = getTotalCxCoeff(coeffs, data, states, controls);
    coeffs.total.Cy = getTotalCyCoeff(coeffs, data, states, controls);
    coeffs.total.Cz = getTotalCzCoeff(coeffs, data, states, controls);
    coeffs.total.Cl = getTotalClCoeff(coeffs, data, states, controls);
    coeffs.total.Cm = getTotalCmCoeff(coeffs, data, states, controls);
    coeffs.total.Cn = getTotalCnCoeff(coeffs, data, states, controls);
    % Aerodynamic Forces and Moments
    [forces, moments] = getAeroFM(coeffs, data, atmParams, states);
    % ---------------------------------------------------------------------
    %% ---------------------------|Engine Model|---------------------------
    % Thrust calculations
    thrust.idle = interpIdleThrust(data, states, atmParams);
    thrust.military = interpMilitaryThrust(data, states, atmParams);
    thrust.maximum = interpMaximumThrust(data, states, atmParams);
    thrust.total.T = getThrustValue(thrust, states);
    % Power calculation
    cmdPower = getCommandedPower(controls);
    %% ------------------------|Utility Equations|-------------------------
    [states.u, states.v, states.w] = convWindParams2bodyParams(states);
    [states.q0, states.q1, states.q2, states.q3] = ...
        convEulerAngle2Quaternions(states);
    % ---------------------------------------------------------------------
    %% -----------------------|Equations of Motion|------------------------
    %  Navigation Parameters
    ders.nav = getDerivativeOfNavigation(states);
    % Kinematic Parameters
    ders.eulerAngles = getDerivativeOfKinematics(states);
    % Conservation of Linear Momentum
    ders.bodySpeeds = getCLMEforces(states, forces, graParams, thrust, ...
    data);
    % Conservaton of Angular Momentum
    ders.angRates = getCAMEmoments(states,moments, data);
    % Power Parameters
    ders.power = getDerivativeOfPower(states, cmdPower);
    % Wind Parameters
    ders.windParams = getDerivativeOfWindParameters(states, ders);
    %% ---------------------------|Sensor Data|----------------------------
    [states.aN, states.aY] = getAccelerationParameters(states, ...
        graParams, ders);
    % ---------------------------------------------------------------------
end % End of "Eular version of Flight Dynamics" Function.