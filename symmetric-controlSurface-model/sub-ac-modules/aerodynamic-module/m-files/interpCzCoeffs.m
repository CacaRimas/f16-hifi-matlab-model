% Whole Z-Axis Force Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole z-axis force coefficients for specific state and control conditions.
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
%       zaxis: Z-Axis force coefficients.
%           Cz => Z-Axis force main coefficient.
%           Cz_q => Z-Axis force damping derivative coefficieint on zaxis.
%           Cz_sb => Z-Axis force effect on speed breaker.
%           Cz_lef => Z-Axis force coeffiicent effect on lef.
%           Cz_lef_q => Z-Axis force damping coeff effect on lef/zaxis.
%           Cz_diff => Z-Axis force effect on differentials.
%           Cz_ds=> Z-Axis force effect of surface deflections.
%           Cz_eta => Z-Axis force effect on normalized elevator.
% -------------------------------------------------------------------------
% =========================================================================

function zaxis = interpCzCoeffs(states, controls, data)
    %% -------------------------|Data Information|-------------------------
    % Look-up table
    Cz = data.aero.coeffs.table.zaxis.Cz; % Cz table.
    Cz_q = data.aero.coeffs.table.zaxis.Cz_q; % Cz_q table.
    Cz_lef = data.aero.coeffs.table.zaxis.Cz_lef; % Cz_lef table.
    Cz_lef_q = data.aero.coeffs.table.zaxis.Cz_lef_q; % Cz_lef_q table.
    Cz_sb = data.aero.coeffs.table.zaxis.Cz_sb; %Cz_sb table.
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
    zaxis.Cz = interp3(refBeta, refAlphaLong, refEleLong, Cz, beta, ...
        alpha, ele);
    zaxis.Cz_de0 = interp3(refBeta, refAlphaLong, refEleLong, Cz, beta, ...
        alpha, 0);
    % ---------------------------------------------------------------------
    %% ------------------|Damping zaxis Coefficient|-----------------------
    zaxis.Cz_q = interp1(refAlphaLong, Cz_q, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----|Z-Axis Force Coeffs Effects on Control Speed Breaker Defl|-----
    zaxis.Cz_sb = interp1(refAlphaLong, Cz_sb, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% -----------------------|Second Limitter|----------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 45; alpha = 45; end
    % ---------------------------------------------------------------------
    %% ------------------|LEF Effect on Main Coeff.|-----------------------
    zaxis.Cz_lef = interp2(refBeta, refAlphaShort, Cz_lef, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Dynamic Coeff.|----------------------
    zaxis.Cz_lef_q = interp1(refAlphaShort, Cz_lef_q ,alpha, 'linear', ...
        'extrap'); 
    % ---------------------------------------------------------------------
end % End of "Z-Axis Force Interpolation" Function