% Whole Yaw Moment Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole yaw moment coefficients for specific state and control conditions
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
%           x_cg => Center of gravity on X-axis (ft)
%           x_cg_ref => Nominal center of gravity on X-axis (ft)
%       states => Aircraft state information.
%           p => Body axis roll rate (rad/s)
%           r => Body axis yaw rate (rad/s)
%           beta => Angle of sideslip (rad)
%           tas => True airspeed (ft/s)
%       controls => Aircraft control input information.
%           ail => Aileron deflection (deg)
%           lef => Leading edge flap deflection (deg)
%           rud => Rudder deflection (deg)
%   Outputs:
%       yaw: Yaw moment coefficients.
%           Cn => Yaw moment main coefficient.
%           Cn_de0 => Yaw moment main coefficient at 0 degree ele defl.
%           Cn_p => Yaw moment damping derivative coefficieint on roll.
%           Cn_r => Yaw moment damping derivative coefficieint on yaw.
%           Cn_ail => Yaw moment effect on aileron.
%           Cn_rud => Yaw moment effect on rudder
%           Cn_lef => Yaw moment coeffiicent effect on lef.
%           Cn_lef_p => Yaw moment damping coeff effect on lef/roll.
%           Cn_lef_r => Yaw moment damping coeff effect on lef/yaw.
%           Cn_lef_ail => Yaw moment effect on both aileron and LEF.
%           Cn_beta => Yaw moment effect on angle of sideslip.
% -----------------------------------------------------------------------
% -------------------------------------------------------------------------
% =========================================================================

function Cn = getTotalCnCoeff(coeffs, data, states, controls)
    %% ----------------------|State Variables|-----------------------------
    p = states.q; % Body axis roll rate (rad/s)
    r = states.q; % Body axis yaw rate (rad/s)
    beta = states.beta * 57.29578; % Angle of sideslip (rad)
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
    cbar = data.acSpec.wing.cbar; % Mean aerodynamic chord (ft)
    b = data.acSpec.wing.b; % Mean aerodynamic chord (ft)
    x_cg = data.acSpec.fusalage.x_cg; % Center of gravity (ft)
    x_cg_ref = data.acSpec.fusalage.x_cg_ref; % Nominal center of grav (ft)
    % ---------------------------------------------------------------------
    %% ----------------------------|Coefficients|--------------------------
    Cn = coeffs.yaw.Cn; % Main yaw moment coefficient
    Cn_de0 = coeffs.yaw.Cn_de0; % Main yaw moment at 0 elevator.
    Cn_p = coeffs.yaw.Cn_p; % P damping effect
    Cn_r = coeffs.yaw.Cn_r; % P damping effect
    Cn_lef = coeffs.yaw.Cn_lef; % LEF effect
    Cn_ail = coeffs.yaw.Cn_ail; % Aileron effect
    Cn_rud = coeffs.yaw.Cn_rud; % Rudder effect
    Cn_lef_p = coeffs.yaw.Cn_lef_p; % p damping and LEF effect
    Cn_lef_r = coeffs.yaw.Cn_lef_r; % R damping and LEF effect
    Cn_lef_ail = coeffs.yaw.Cn_lef_ail; % Aileron and LEF effect
    Cn_beta = coeffs.yaw.Cn_beta; % Yaw moment coeffiicent effect on AoS
    Cy = coeffs.total.Cy; % Total Y-Axis force coefficient
    % ---------------------------------------------------------------------
    %% ---------------|Total Yaw Coefficient Calculation|----------------
    % Pre-Calculations
    Cn_ail = Cn_ail-Cn_de0;
    Cn_lef_ail = Cn_lef_ail-Cn_lef-Cn_ail;
    Cn_lef = Cn_lef-Cn_de0;
    Cn_rud = Cn_rud-Cn_de0;
    Cn_tot_ail = Cn_ail+Cn_lef_ail*normLEF;
    Cn_dampR = Cn_r+Cn_lef_r*normLEF;
    Cn_dampP = Cn_p+Cn_lef_p*normLEF;
    cons = (b/(2*tas));
    % Total Cn
    Cn = Cn+...
         Cn_lef*normLEF+...
         Cn_tot_ail*normAil+...
         Cn_rud*normRud+...
         cons*r*Cn_dampR+...
         cons*p*Cn_dampP+...
         Cn_beta*beta+...
         Cy*(x_cg_ref-x_cg)*(cbar/b);
    % ---------------------------------------------------------------------
end % End of "Total Yaw Moment Coefficient" Function.