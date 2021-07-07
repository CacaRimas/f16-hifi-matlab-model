% Whole Roll Moment Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole roll moment coefficients for specific state and control conditions.
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
%       roll: Roll moment coefficients.
%           Cl => Roll Moment main coefficient.
%           Cl_p => Roll Moment damping derivative coefficieint on roll.
%           Cl_r => Roll Moment damping derivative coefficieint on yaw.
%           Cl_lef => Roll Moment coeffiicent effect on lef.
%           Cl_lef_p => Roll Moment damping coefficient effect on lef/roll.
%           Cl_lef_r => Roll Moment damping coefficient effect on lef/yaw.
%           Cl_ail => Roll Moment coeffiicent effect on control deflects.
%           Cl_rud => Roll Moment coeffiicent effect on control deflects.
%           Cl_lef_ail => Roll Moment coeffiicent effect on lef/aileron.
%           Cl_beta => Roll Moment coeffiicent effect on AoS.
% -------------------------------------------------------------------------
% =========================================================================

function roll = interpClCoeffs(states, controls, data)
    %% -------------------------|Data Information|-------------------------
    % Look-up table
    Cl = data.aero.coeffs.table.roll.Cl; % Cl table.
    Cl_p = data.aero.coeffs.table.roll.Cl_p; % Cl_p table.
    Cl_r = data.aero.coeffs.table.roll.Cl_r; % Cl_r table.
    Cl_ail = data.aero.coeffs.table.roll.Cl_ail; % Cl_ail table.
    Cl_rud = data.aero.coeffs.table.roll.Cl_rud; % Cl_ail table.
    Cl_beta = data.aero.coeffs.table.roll.Cl_beta; %Cl_beta table.
    Cl_lef = data.aero.coeffs.table.roll.Cl_lef; % Cl_lef table.
    Cl_lef_ail = data.aero.coeffs.table.roll.Cl_lef_ail; % Cl_lef table.
    Cl_lef_p = data.aero.coeffs.table.roll.Cl_lef_p; % Cl_lef_p table.
    Cl_lef_r = data.aero.coeffs.table.roll.Cl_lef_r; % Cl_lef_r table.
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
    roll.Cl = interp3(refBeta, refAlphaLong, refEleShort, Cl, beta, ...
        alpha, ele);
    roll.Cl_de0 = interp3(refBeta, refAlphaLong, refEleShort, Cl, beta,...
        alpha, 0);
    % ---------------------------------------------------------------------
    %% ------------------|Damping Roll Coefficient|------------------------
    roll.Cl_p = interp1(refAlphaLong, Cl_p, alpha, 'linear', 'extrap');
    roll.Cl_r = interp1(refAlphaLong, Cl_r, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----|Roll Moment Coeffs Effects on Control Surface Deflection|------
    roll.Cl_ail = interp2(refBeta, refAlphaLong, Cl_ail, beta, alpha);
    roll.Cl_rud = interp2(refBeta, refAlphaLong, Cl_rud, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------|Roll Moment Coeffs Effect on Angle of Sideslip|----------
    roll.Cl_beta = interp1(refAlphaLong, Cl_beta, alpha, 'linear', ...
        'extrap');
    % ---------------------------------------------------------------------
    %% -----------------------|Second Limitter|----------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 45; alpha = 45; end
    % ---------------------------------------------------------------------
    %% ------------------|LEF Effect on Main Coeff.|-----------------------
    roll.Cl_lef = interp2(refBeta, refAlphaShort, Cl_lef, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Control Coeff.|----------------------
    roll.Cl_lef_ail = interp2(refBeta, refAlphaShort, Cl_lef_ail, ...
        beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Dynamic Coeff.|----------------------
    roll.Cl_lef_p = interp1(refAlphaShort, Cl_lef_p ,alpha, 'linear', ...
        'extrap'); 
    roll.Cl_lef_r = interp1(refAlphaShort, Cl_lef_r ,alpha, 'linear', ...
        'extrap'); 
    % ---------------------------------------------------------------------
end % End of "Roll Moment Interpolation" Function.