% Whole Yaw Moment Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole yaw moment coefficients for specific state and control conditions.
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
%       yaw: Yaw moment coefficients.
%           Cn => Yaw Moment main coefficient.
%           Cn_p => Yaw Moment damping derivative coefficieint on yaw.
%           Cn_r => Yaw Moment damping derivative coefficieint on yaw.
%           Cn_lef => Yaw Moment coeffiicent effect on lef.
%           Cn_lef_p Yaw yaw Moment damping coefficient effect on lef/yaw.
%           Cn_lef_r => Yaw Moment damping coefficient effect on lef/yaw.
%           Cn_ail => Yaw Moment coeffiicent effect on control deflects.
%           Cn_rud => Yaw Moment coeffiicent effect on control deflects.
%           Cn_lef_ail => Yaw Moment coeffiicent effect on lef/aileron.
%           Cn_beta => Yaw  Moment coeffiicent effect on AoS.
% -------------------------------------------------------------------------
% =========================================================================

function yaw = interpCnCoeffs(states, controls, data)
    %% -------------------------|Data Information|-------------------------
    % Look-up table
    Cn = data.aero.coeffs.table.yaw.Cn; % Cn table.
    Cn_p = data.aero.coeffs.table.yaw.Cn_p; % Cn_p table.
    Cn_r = data.aero.coeffs.table.yaw.Cn_r; % Cn_r table.
    Cn_ail = data.aero.coeffs.table.yaw.Cn_ail; % Cn_ail table.
    Cn_rud = data.aero.coeffs.table.yaw.Cn_rud; % Cn_ail table.
    Cn_beta = data.aero.coeffs.table.yaw.Cn_beta; %Cn_beta table.
    Cn_lef = data.aero.coeffs.table.yaw.Cn_lef; % Cn_lef table.
    Cn_lef_ail = data.aero.coeffs.table.yaw.Cn_lef_ail; % Cn_lef table.
    Cn_lef_p = data.aero.coeffs.table.yaw.Cn_lef_p; % Cn_lef_p table.
    Cn_lef_r = data.aero.coeffs.table.yaw.Cn_lef_r; % Cn_lef_r table.
    Cn_da_diff = data.aero.coeffs.table.yaw.Cn_da_diff; % Cn_da_diff table
    % Reference Signal
    refAlphaLong = data.aero.coeffs.table.refSignals.alphaLong; % Ref AoA v1
    refAlphaShort = data.aero.coeffs.table.refSignals.alphaShort; % Ref AoA
    refBeta = data.aero.coeffs.table.refSignals.beta; % Ref AoS
    refEleShort = data.aero.coeffs.table.refSignals.eleShort; % Ref Ele v2 
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
    yaw.Cn = interp3(refBeta, refAlphaLong, refEleShort, Cn, beta, ...
        alpha, ele);
    yaw.Cn_de0 = interp3(refBeta, refAlphaLong, refEleShort, Cn, beta,...
        alpha, 0);
    % ---------------------------------------------------------------------
    %% ------------------|Damping yaw Coefficient|-------------------------
    yaw.Cn_p = interp1(refAlphaLong, Cn_p, alpha, 'linear', 'extrap');
    yaw.Cn_r = interp1(refAlphaLong, Cn_r, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----|yaw Moment Coeffs Effects on Control Surface Deflection|-------
    yaw.Cn_ail = interp2(refBeta, refAlphaLong, Cn_ail, beta, alpha);
    yaw.Cn_rud = interp2(refBeta, refAlphaLong, Cn_rud, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------|yaw Moment Coeffs Effect on Angle of Sideslip|----------
    yaw.Cn_beta = interp1(refAlphaLong, Cn_beta, alpha, 'linear', ...
        'extrap');
    % ---------------------------------------------------------------------
    %% ---------|yaw Moment Coeffs Effect on Aileron Differentials|--------
    yaw.Cn_da_diff = interp1(refAlphaLong, Cn_da_diff, alpha, 'linear', ...
        'extrap');
    % ---------------------------------------------------------------------
    %% -----------------------|Second Limitter|----------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 45; alpha = 45; end
    % ---------------------------------------------------------------------
    %% ------------------|LEF Effect on Main Coeff.|-----------------------
    yaw.Cn_lef = interp2(refBeta, refAlphaShort, Cn_lef, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Control Coeff.|----------------------
    yaw.Cn_lef_ail = interp2(refBeta, refAlphaShort, Cn_lef_ail, ...
        beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Dynamic Coeff.|----------------------
    yaw.Cn_lef_p = interp1(refAlphaShort, Cn_lef_p ,alpha, 'linear', ...
        'extrap'); 
    yaw.Cn_lef_r = interp1(refAlphaShort, Cn_lef_r ,alpha, 'linear', ...
        'extrap'); 
    % ---------------------------------------------------------------------
end % End of "Yaw Moment Interpolation" Function.