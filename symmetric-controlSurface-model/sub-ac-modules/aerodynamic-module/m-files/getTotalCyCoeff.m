% Whole Y-Axis Force Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole y-axis force coefficients for specific state and control conditions
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
% Parameters:
%   Inputs:
%       coeffs => Aerodynamic coefficients.
%           C_i => Whole necessery aerodynamic coefficient data after
% interpolation
%       data => Aircraft specification data.
%           b => Wing span (ft)
%       states => Aircraft state information.
%           p => Body axis roll rate (rad/s)
%           r => Body axis yaw rate (rad/s)
%           tas => True airspeed (ft/s)
%       controls => Aircraft control input information.
%           ail => Aileron deflection (deg)
%           lef => Leading edge flap deflection (deg)
%           rud => Rudder deflection (deg)
%   Outputs:
%       yaxis: yaxis Force coefficients.
%           Cy => Y-Axis force main coefficient.
%           Cy_p => Y-Axis force damping derivative coefficieint on roll.
%           Cy_r => Y-Axis force damping derivative coefficieint on yaw.
%           Cy_ail => Y-Axis force effect on aileron.
%           Cy_rud => Y-Axis force effect on rudder
%           Cy_lef => Y-Axis force coeffiicent effect on lef.
%           Cy_lef_p => Y-Axis force damping coeff effect on lef/roll.
%           Cy_lef_r => Y-Axis force damping coeff effect on lef/yaw.
%           Cy_lef_ail => Y-Axis force effect on both aileron and LEF.
% -------------------------------------------------------------------------
% =========================================================================

function Cy = getTotalCyCoeff(coeffs, data, states, controls)
    %% ----------------------|State Variables|-----------------------------
    p = states.q; % Body axis roll rate (rad/s)
    r = states.q; % Body axis yaw rate (rad/s)
    tas = states.tas; % True airspeed (ft/s)
    % ---------------------------------------------------------------------
    %% -----------------------|Control Inputs|-----------------------------
    lef = controls.lef; % Leading edge flap deflection (deg)
    ail = controls.aileron; % Aileron deflection (deg)
    rud = controls.rudder; % Rudder deflection (deg)
    normLEF = 1-(lef/25); % Normalized LEF ()
    normAil = ail/21.5; % Normalized Aileron ()
    normRud = rud/30; % Normalized Rudder ()
    % ---------------------------------------------------------------------
    %% ---------------------|Aircraft Specifications|----------------------
    b = data.acSpec.wing.b; % Mean aerodynamic chord (ft)
    % ---------------------------------------------------------------------
    %% ----------------------------|Coefficients|--------------------------
    Cy = coeffs.yaxis.Cy; % Main yaxis force coefficient
    Cy_p = coeffs.yaxis.Cy_p; % P damping effect
    Cy_r = coeffs.yaxis.Cy_r; % P damping effect
    Cy_lef = coeffs.yaxis.Cy_lef; % LEF effect
    Cy_ail = coeffs.yaxis.Cy_ail; % Aileron effect
    Cy_rud = coeffs.yaxis.Cy_rud; % Rudder effect
    Cy_lef_p = coeffs.yaxis.Cy_lef_p; % p damping and LEF effect
    Cy_lef_r = coeffs.yaxis.Cy_lef_r; % R damping and LEF effect
    Cy_lef_ail = coeffs.yaxis.Cy_lef_ail; % Aileron and LEF effect
    % ---------------------------------------------------------------------
    %% ---------------|Total Yaxis Coefficient Calculation|----------------
    % Pre-Calculations
    Cy_ail = Cy_ail-Cy;
    Cy_lef_ail = Cy_lef_ail-Cy_lef-Cy_ail;
    Cy_lef = Cy_lef-Cy;
    Cy_rud = Cy_rud-Cy;
    Cy_tot_ail = Cy_ail+Cy_lef_ail*normLEF;
    Cy_dampR = Cy_r+Cy_lef_r*normLEF;
    Cy_dampP = Cy_p+Cy_lef_p*normLEF;
    cons = (b/(2*tas));
    % Total Cy
    Cy = Cy+...
         Cy_lef*normLEF+...
         Cy_tot_ail*normAil+...
         Cy_rud*normRud+...
         cons*r*Cy_dampR+...
         cons*p*Cy_dampP;
    % ---------------------------------------------------------------------
end % End of "Total Y-Axis Force Coefficient" Function.