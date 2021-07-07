% Whole X-Axis Force Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole x-axis force coefficients for specific state and control conditions
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       coeffs => Aerodynamic coefficients.
%           C_i => Whole necessery aerodynamic coefficient data after
% interpolation
%       data => Aircraft specification data.
%           cbar => Mean aerodynamic chord (ft)
%       states => Aircraft state information.
%           q => Body axis pitch rate (rad/s)
%           tas => True airspeed (ft/s)
%       controls => Aircraft control input information.
%           lef => Leading edge flap deflection (deg)
%           sb => Speed breaker deflection (deg)
%   Outputs:
%       xaxis: xaxis Force coefficients.
%           Cx => X-Axis force main coefficient.
%           Cx_q => X-Axis force damping derivative coefficieint on xaxis.
%           Cx_sb => X-Axis force effect on speed breaker.
%           Cx_lef => X-Axis force coeffiicent effect on lef.
%           Cx_lef_q => X-Axis force damping coeff effect on lef/xaxis.
%           Cx_diff => X-Axis force effect on differentials.
%           Cx_ds=> X-Axis force effect of surface deflections.
%           Cx_eta => X-Axis force effect on normalized elevator.
% -------------------------------------------------------------------------
% =========================================================================

function Cx = getTotalCxCoeff(coeffs, data, states, controls)
    %% ----------------------|State Variables|-----------------------------
    q = states.q; % Body axis pitch rate (rad/s)
    tas = states.tas; % True airspeed (ft/s)
    % ---------------------------------------------------------------------
    %% -----------------------|Control Inputs|-----------------------------
    lef = controls.lef; % Leading edge flap deflection (deg)
    sb = controls.sb; % Speed breaker deflection (deg)
    normLEF = 1-(lef/25); % Normalized LEF ()
    normSB = sb/60; % Normalized SB ()
    % ---------------------------------------------------------------------
    %% ---------------------|Aircraft Specifications|----------------------
    cbar = data.acSpec.wing.cbar; % Mean aerodynamic chord (ft)
    % ---------------------------------------------------------------------
    %% ----------------------------|Coefficients|--------------------------
    Cx = coeffs.xaxis.Cx; % Main xaxis Force coefficient
    Cx_de0 = coeffs.xaxis.Cx_de0; % Main xaxis force coefficient at de=0
    Cx_q = coeffs.xaxis.Cx_q; % Q damping effect
    Cx_lef = coeffs.xaxis.Cx_lef; % LEF effect
    Cx_lef_q = coeffs.xaxis.Cx_lef_q; % Q damping and LEF effect
    Cx_sb = coeffs.xaxis.Cx_sb; % Speed breaker
    % ---------------------------------------------------------------------
    %% ---------------|Total Xaxis Coefficient Calculation|----------------
    % Pre-Calculations
    cons = (cbar)/(2*tas);
    Cx_damp = cons*(Cx_q+Cx_lef_q*normLEF);
    Cx_lef = Cx_lef-Cx_de0;
    % Total Cx
    Cx = Cx+...
         Cx_lef*normLEF+...
         Cx_sb*normSB+...
         Cx_damp*q;
    % ---------------------------------------------------------------------
end % End of "Total X-Axis Force Coefficient" Function.