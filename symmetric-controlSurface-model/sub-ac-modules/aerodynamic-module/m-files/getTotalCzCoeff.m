% Whole Z-Axis Force Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole z-axis force coefficients for specific state and control conditions
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
%           Cz => Z-Axis force main coefficient.
%           Cz_q => Z-Axis force damping derivative coefficieint on xaxis.
%           Cz_sb => Z-Axis force effect on speed breaker.
%           Cz_lef => Z-Axis force coeffiicent effect on lef.
%           Cz_lef_q => Z-Axis force damping coeff effect on lef/xaxis.
%           Cz_diff => Z-Axis force effect on differentials.
%           Cz_ds=> Z-Axis force effect of surface deflections.
%           Cz_eta => Z-Axis force effect on normalized elevator.
% -------------------------------------------------------------------------
% =========================================================================

function Cz = getTotalCzCoeff(coeffs, data, states, controls)
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
    Cz = coeffs.zaxis.Cz; % Main zaxis Force coefficient
    Cz_de0 = coeffs.zaxis.Cz_de0; % Main zaxis force coefficient at de=0
    Cz_q = coeffs.zaxis.Cz_q; % Q damping effect
    Cz_lef = coeffs.zaxis.Cz_lef; % LEF effect
    Cz_lef_q = coeffs.zaxis.Cz_lef_q; % Q damping and LEF effect
    Cz_sb = coeffs.zaxis.Cz_sb; % Speed breaker
    % ---------------------------------------------------------------------
    %% ---------------|Total Zaxis Coefficient Calculation|----------------
    % Pre-Calculations
    cons = (cbar)/(2*tas);
    Cz_damp = cons*(Cz_q+Cz_lef_q*normLEF);
    Cz_lef = Cz_lef-Cz_de0;
    % Total Cz
    Cz = Cz+...
         Cz_lef*normLEF+...
         Cz_sb*normSB+...
         Cz_damp*q;
    % ---------------------------------------------------------------------
end % End of "Total Z-Axis Force Coefficient" Function.