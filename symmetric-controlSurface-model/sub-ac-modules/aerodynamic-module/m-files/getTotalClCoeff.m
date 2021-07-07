% Whole Roll Moment Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole roll moment coefficients for specific state and control conditions
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
%           b => Wing span (ft)
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
%       roll: Roll moment coefficients.
%           Cl => roll moment main coefficient.
%           Cl_de0 => roll moment main coefficient at 0 degree ele defl.
%           Cl_p => roll moment damping derivative coefficieint on roll.
%           Cl_r => roll moment damping derivative coefficieint on roll.
%           Cl_ail => roll moment effect on aileron.
%           Cl_rud => roll moment effect on rudder
%           Cl_lef => roll moment coeffiicent effect on lef.
%           Cl_lef_p => roll moment damping coeff effect on lef/roll.
%           Cl_lef_r => roll moment damping coeff effect on lef/roll.
%           Cl_lef_ail => roll moment effect on both aileron and LEF.
%           Cl_beta => roll moment effect on angle of sideslip.
% -----------------------------------------------------------------------
% -------------------------------------------------------------------------
% =========================================================================

function Cl = getTotalClCoeff(coeffs, data, states, controls)
    %% ----------------------|State Variables|-----------------------------
    p = states.q; % Body axis roll rate (rad/s)
    r = states.q; % Body axis roll rate (rad/s)
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
    b = data.acSpec.wing.b; % Mean aerodynamic chord (ft)
    % ---------------------------------------------------------------------
    %% ----------------------------|Coefficients|--------------------------
    Cl = coeffs.roll.Cl; % Main roll moment coefficient
    Cl_de0 = coeffs.roll.Cl_de0; % Main roll moment at 0 elevator.
    Cl_p = coeffs.roll.Cl_p; % P damping effect
    Cl_r = coeffs.roll.Cl_r; % P damping effect
    Cl_lef = coeffs.roll.Cl_lef; % LEF effect
    Cl_ail = coeffs.roll.Cl_ail; % Aileron effect
    Cl_rud = coeffs.roll.Cl_rud; % Rudder effect
    Cl_lef_p = coeffs.roll.Cl_lef_p; % p damping and LEF effect
    Cl_lef_r = coeffs.roll.Cl_lef_r; % R damping and LEF effect
    Cl_lef_ail = coeffs.roll.Cl_lef_ail; % Aileron and LEF effect
    Cl_beta = coeffs.roll.Cl_beta; % roll moment coeffiicent effect on AoS
    % ---------------------------------------------------------------------
    %% ---------------|Total Roll Coefficient Calculation|----------------
    % Pre-Calculations
    Cl_ail = Cl_ail-Cl_de0;
    Cl_lef_ail = Cl_lef_ail-Cl_lef-Cl_ail;
    Cl_lef = Cl_lef-Cl_de0;
    Cl_rud = Cl_rud-Cl_de0;
    Cl_tot_ail = Cl_ail+Cl_lef_ail*normLEF;
    Cl_dampR = Cl_r+Cl_lef_r*normLEF;
    Cl_dampP = Cl_p+Cl_lef_p*normLEF;
    cons = (b/(2*tas));
    % Total Cl
    Cl = Cl+...
         Cl_lef*normLEF+...
         Cl_tot_ail*normAil+...
         Cl_rud*normRud+...
         cons*r*Cl_dampR+...
         cons*p*Cl_dampP+...
         Cl_beta*beta;
    % ---------------------------------------------------------------------
end % End of "Total Roll Moment Coefficient" Function.