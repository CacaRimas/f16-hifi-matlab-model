% Whole Y-Axis Force Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole y-axis Force coefficients for specific state and control conditions.
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states: Aircraft state information.
%           alpha => Angle of attack (rad)
%           beta => Angle of sideslip (rad)
%       data: Aircraft aerodynamic data.
%           C_i => Aerodynamic coefficient tables.
%   Outputs:
%       yaxis: Y-Axis Force coefficients.
%           Cy => Y-Axis force main coefficient.
%           Cy_p => Y-Axis force damping derivative coefficieint on yaxis.
%           Cy_r => Y-Axis force damping derivative coefficieint on yaw.
%           Cy_lef => Y-Axis force coeffiicent effect on lef.
%           Cy_lef_p => Y-Axis force damping coefficient effect on lef/yaxis.
%           Cy_lef_r => Y-Axis force damping coefficient effect on lef/yaw.
%           Cy_ail => Y-Axis force coeffiicent effect on control deflects.
%           Cy_rud => Y-Axis force coeffiicent effect on control deflects.
%           Cy_lef_ail => Y-Axis force coeffiicent effect on lef/aileron.
%           Cy_beta => Y-Axis force coeffiicent effect on AoS.
% -------------------------------------------------------------------------
% =========================================================================

function yaxis = interpCyCoeffs(states, data)
    %% -------------------------|Data Information|-------------------------
    % Look-up table
    Cy = data.aero.coeffs.table.yaxis.Cy; % Cy table.
    Cy_p = data.aero.coeffs.table.yaxis.Cy_p; % Cy_p table.
    Cy_r = data.aero.coeffs.table.yaxis.Cy_r; % Cy_r table.
    Cy_ail = data.aero.coeffs.table.yaxis.Cy_ail; % Cy_ail table.
    Cy_rud = data.aero.coeffs.table.yaxis.Cy_rud; % Cy_ail table.
    Cy_lef = data.aero.coeffs.table.yaxis.Cy_lef; % Cy_lef table.
    Cy_lef_ail = data.aero.coeffs.table.yaxis.Cy_lef_ail; % Cy_lef table.
    Cy_lef_p = data.aero.coeffs.table.yaxis.Cy_lef_p; % Cy_lef_p table.
    Cy_lef_r = data.aero.coeffs.table.yaxis.Cy_lef_r; % Cy_lef_r table.
    % Reference Signal
    refAlphaLong = data.aero.coeffs.table.refSignals.alphaLong; % Ref AoA v1
    refAlphaShort = data.aero.coeffs.table.refSignals.alphaShort; % Ref AoA
    refBeta = data.aero.coeffs.table.refSignals.beta; % Ref AoS
    % ---------------------------------------------------------------------
    %% -------------------------|State Variables|--------------------------
    alpha = rad2deg(states.alpha); % Angle of attack (deg)
    beta = rad2deg(states.beta); % Angle of sideslip (deg)
    % ---------------------------------------------------------------------
    %% --------------------------|Control Inputs|--------------------------
    % ---------------------------------------------------------------------
    %% --------------------------|First Limitter|--------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 90; alpha = 90; end
    if beta < -30; beta = -30; end; if beta > 30; beta = 30; end
    % ---------------------------------------------------------------------
    %% ----------------------|Main Body Coefficient|-----------------------
    yaxis.Cy = interp2(refBeta, refAlphaLong, Cy, beta, alpha);
    % ---------------------------------------------------------------------
    %% ------------------|Damping yaxis Coefficient|------------------------
    yaxis.Cy_p = interp1(refAlphaLong, Cy_p, alpha, 'linear', 'extrap');
    yaxis.Cy_r = interp1(refAlphaLong, Cy_r, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----|yaxis Force Coeffs Effects on Control Surface Deflection|------
    yaxis.Cy_ail = interp2(refBeta, refAlphaLong, Cy_ail, beta, alpha);
    yaxis.Cy_rud = interp2(refBeta, refAlphaLong, Cy_rud, beta, alpha);
    % ---------------------------------------------------------------------
    %% -----------------------|Second Limitter|----------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 45; alpha = 45; end
    % ---------------------------------------------------------------------
    %% ------------------|LEF Effect on Main Coeff.|-----------------------
    yaxis.Cy_lef = interp2(refBeta, refAlphaShort, Cy_lef, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Control Coeff.|----------------------
    yaxis.Cy_lef_ail = interp2(refBeta, refAlphaShort, Cy_lef_ail, ...
        beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Dynamic Coeff.|----------------------
    yaxis.Cy_lef_p = interp1(refAlphaShort, Cy_lef_p ,alpha, 'linear', ...
        'extrap'); 
    yaxis.Cy_lef_r = interp1(refAlphaShort, Cy_lef_r ,alpha, 'linear', ...
        'extrap'); 
    % ---------------------------------------------------------------------
end % End of "yaxis Force Interpolation" Function.