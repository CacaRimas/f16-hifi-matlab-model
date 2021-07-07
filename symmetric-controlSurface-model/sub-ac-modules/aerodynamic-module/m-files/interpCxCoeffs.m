% Whole X-Axis Force Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole x-axis force coefficients for specific state and control conditions.
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states: Aircraft state information.
%           alpha => Angle of attack (rad)
%           beta => Angle of sideslip (rad)
%       controls: Aircraft control information.
%           ele => Elevator deflection.
%       data: Aircraft aerodynamic data.
%           C_i => Aerodynamic coefficient tables.
%   Outputs:
%       xaxis: X-Axis force coefficients.
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

function xaxis = interpCxCoeffs(states, controls, data)
    %% -------------------------|Data Information|-------------------------
    % Look-up table
    Cx = data.aero.coeffs.table.xaxis.Cx; % Cx table.
    Cx_q = data.aero.coeffs.table.xaxis.Cx_q; % Cx_q table.
    Cx_lef = data.aero.coeffs.table.xaxis.Cx_lef; % Cx_lef table.
    Cx_lef_q = data.aero.coeffs.table.xaxis.Cx_lef_q; % Cx_lef_q table.
    Cx_sb = data.aero.coeffs.table.xaxis.Cx_sb; %Cx_sb table.
    % Reference Signal
    refAlphaLong = data.aero.coeffs.table.refSignals.alphaLong; % Ref AoA v1
    refAlphaShort = data.aero.coeffs.table.refSignals.alphaShort; % Ref AoA
    refBeta = data.aero.coeffs.table.refSignals.beta; % Ref AoS
    refEleLong = data.aero.coeffs.table.refSignals.eleLong; % Ref Ele v2
    % ---------------------------------------------------------------------
    %% -------------------------|State Variables|--------------------------
    alpha = rad2deg(states.alpha); % Angle of attack (deg)
    beta = rad2deg(states.beta); % Angle of sideslip (deg)
    % ---------------------------------------------------------------------
    %% --------------------------|Control Inputs|--------------------------
    ele = controls.elevator; % Elevator deflection (deg)
    % ---------------------------------------------------------------------
    %% --------------------------|First Limitter|--------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 90; alpha = 90; end
    if beta < -30; beta = -30; end; if beta > 30; beta = 30; end
    if ele < -25; ele = -25; end; if ele > 25; ele = 25; end
    % ---------------------------------------------------------------------
    %% ----------------------|Main Body Coefficient|-----------------------
    xaxis.Cx = interp3(refBeta, refAlphaLong, refEleLong, Cx, beta, ...
        alpha, ele);
    xaxis.Cx_de0 = interp3(refBeta, refAlphaLong, refEleLong, Cx, beta,...
        alpha, 0);
    % ---------------------------------------------------------------------
    %% ------------------|Damping xaxis Coefficient|-----------------------
    xaxis.Cx_q = interp1(refAlphaLong, Cx_q, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----|X-Axis Force Coeffs Effects on Control Speed Breaker Defl|-----
    xaxis.Cx_sb = interp1(refAlphaLong, Cx_sb, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% -----------------------|Second Limitter|----------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 45; alpha = 45; end
    % ---------------------------------------------------------------------
    %% ------------------|LEF Effect on Main Coeff.|-----------------------
    xaxis.Cx_lef = interp2(refBeta, refAlphaShort, Cx_lef, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Dynamic Coeff.|----------------------
    xaxis.Cx_lef_q = interp1(refAlphaShort, Cx_lef_q ,alpha, 'linear', ...
        'extrap'); 
    % ---------------------------------------------------------------------
end % End of "X-Axis Force Interpolation" Function