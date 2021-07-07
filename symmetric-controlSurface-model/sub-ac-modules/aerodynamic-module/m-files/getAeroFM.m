% Aerodynamic Forces and Moments Calculation Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Aerodynamic force and calculation function, whole calculations done with
% atmospheric information, aircraft states and aeordynamic coefficients.
% Equations can be found both Steven's "Aircraft Simulation and Control"
% textbook and Nguyen's "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability" paper. Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       coeffs => Total aerodynamic coefficients.
%       data => Aircraft specification data.
%           cbar => Mean aerodynamic chord (ft)
%           b => Wing span (ft)
%           S => Reference wing area (ft^2)
%       atmParams => Atmospheric specifications.
%           qbar => Dynamic pressure (lb/ft^2)
%       states => Aircraft state information.
%           alpha => Angle of attack (rad)
%           beta => Angle of sideslip (rad)
%   Outputs:
%       F => Aerodynamic forces.
%           X => X-Axis aerodynamic forces (lbf)
%           Y => Y-Axis aerodynamic forces (lbf)
%           Z => Z-Axis aerodynamic forces (lbf)
%           D => Drag force (lbf)
%           L => Lift force (lbf)
%           C => Crosswind force (lbf).
%       M => Aerodynamic moments.
%           L = Roll moment (lbf*ft)
%           M = Pitch moment (lbf*ft)
%           N = Yaw moment (lbf*ft)
% -------------------------------------------------------------------------
% =========================================================================

function [F, M] = getAeroFM(coeffs, data, atmParams, states)
    %% --------------------------|State Information|-----------------------
    alpha = states.alpha; % Angle of Attack [rad]
    beta = states.beta; % Sideslip Angle [rad]
    % ---------------------------------------------------------------------
    %% --------------------|Atmospheric Specifications|--------------------
    qbar = atmParams.qbar; % Dynamic Pressure [lb/ft^2]
    % ---------------------------------------------------------------------
    %% ----------------------|Aircraft Specifications|---------------------
    cbar = data.acSpec.wing.cbar; % Mean aerodynamic chord [ft]
    b = data.acSpec.wing.b; % Wing span [ft]
    S = data.acSpec.wing.S; % Wing area [ft]
    % ---------------------------------------------------------------------
    %% ------------------------|Total Coefficients|------------------------
    Cx = coeffs.total.Cx; % X-axis force coefficients
    Cy = coeffs.total.Cy; % Y-axis force coefficients
    Cz = coeffs.total.Cz; % Z-axis force coefficients
    Cl = coeffs.total.Cl; % Roll moment coefficients
    Cm = coeffs.total.Cm; % Pitch moment coefficients
    Cn = coeffs.total.Cn; % Yaw moment coefficients
    % ---------------------------------------------------------------------
    %% ------------------------|Aerodynamic Forces|------------------------
    F.X = qbar*S*Cx; % X-axis force
    F.Y = qbar*S*Cy; % Y-axis force
    F.Z = qbar*S*Cz; % Z-axis force
    % ---------------------------------------------------------------------
    %% ------------------------|Aerodynamic Moments|-----------------------
    M.L = qbar*S*b*Cl; % Roll moments
    M.M = qbar*S*cbar*Cm; % Pitch moments
    M.N = qbar*S*b*Cn; % Yaw moments
    % ---------------------------------------------------------------------
    %% -------------------|Wind Axis Aerodynamic Forces|-------------------
    % Transformation Matrix
    DCM = [cos(alpha)*cos(beta)  sin(beta) sin(alpha)*cos(beta);
    -cos(alpha)*sin(beta) cos(beta) -sin(alpha)*sin(beta);
    -sin(alpha)   0 cos(alpha)];
    % Obtaining Wind Axis Aerodynamic Forces
    windF = DCM*[F.X; F.Y; F.Z];
    F.D = -windF(1);
    F.C = -windF(2);
    F.L = -windF(3);
% -------------------------------------------------------------------------
end % End of "Aerodynamic Forces and Moments Calculation" Function.