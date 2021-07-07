% Whole Pitch Moment Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole pitch moment coefficients for specific state and control conditions
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
%           x_cg => Center of gravity on X-axis (ft)
%           x_cg_ref => Nominal center of gravity on X-axis (ft)
%       states => Aircraft state information.
%           q => Body axis pitch rate (rad/s)
%           tas => True airspeed (ft/s)
%       controls => Aircraft control input information.
%           lef => Leading edge flap deflection (deg)
%           sb => Speed breaker deflection (deg)
%   Outputs:
%       pitch: Pitch moment coefficients.
%           Cm => Pitch Moment main coefficient.
%           Cm_q => Pitch Moment damping derivative coefficieint on pitch.
%           Cm_sb => Pitch Moment effect on speed breaker.
%           Cm_lef => Pitch Moment coeffiicent effect on lef.
%           Cm_lef_q => Pitch Moment damping coeff effect on lef/pitch.
%           Cm_diff => Pitch Moment effect on differentials.
%           Cm_ds=> Pitch Moment effect of surface deflections.
%           Cm_eta => Pitch Moment effect on normalized elevator.
% -------------------------------------------------------------------------
% =========================================================================

function Cm = getTotalCmCoeff(coeffs, data, states, controls)
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
    x_cg = data.acSpec.fusalage.x_cg; % Center of gravity (ft)
    x_cg_ref = data.acSpec.fusalage.x_cg_ref; % Nominal center of grav (ft)
    % ---------------------------------------------------------------------
    %% ----------------------------|Coefficients|--------------------------
    Cm = coeffs.pitch.Cm; % Main pitch moment coefficient
    Cm_de0 = coeffs.pitch.Cm_de0; % Main pitch moment coefficient at de=0
    Cm_q = coeffs.pitch.Cm_q; % Q damping effect
    Cm_lef = coeffs.pitch.Cm_lef; % LEF effect
    Cm_lef_q = coeffs.pitch.Cm_lef_q; % Q damping and LEF effect
    Cm_diff = coeffs.pitch.Cm_diff; % Differential effect
    Cm_ds = coeffs.pitch.Cm_ds; %ds
    Cm_eta = coeffs.pitch.Cm_eta; % Eta elevator
    Cm_sb = coeffs.pitch.Cm_sb; % Speed breaker
    Cz = coeffs.total.Cz; % Total Z-Axis force Coeffient
    % ---------------------------------------------------------------------
    %% ---------------|Total Pitch Coefficient Calculation|----------------
    % Pre-Calculations
    cons = (cbar)/(2*tas);
    Cm_damp = cons*(Cm_q+Cm_lef_q*normLEF);
    Cm_lef = Cm_lef-Cm_de0;
    % Total Cm
    Cm = Cm*Cm_eta+...
         Cz*(x_cg_ref-x_cg)+...
         Cm_lef*normLEF+...
         Cm_sb*normSB+...
         Cm_damp*q+...
         Cm_diff+...
         Cm_ds;  
    % ---------------------------------------------------------------------
end % End of "Total Pitch Moment Coefficient" Function.