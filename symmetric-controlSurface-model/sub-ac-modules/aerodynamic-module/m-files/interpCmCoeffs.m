% Whole Pitch Moment Coefficients
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole pitch moment coefficients for specific state and control conditions.
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

function pitch = interpCmCoeffs(states, controls, data)
    %% -------------------------|Data Information|-------------------------
    % Look-up table
    Cm = data.aero.coeffs.table.pitch.Cm; % Cm table.
    Cm_q = data.aero.coeffs.table.pitch.Cm_q; % Cm_q table.
    Cm_lef = data.aero.coeffs.table.pitch.Cm_lef; % Cm_lef table.
    Cm_lef_q = data.aero.coeffs.table.pitch.Cm_lef_q; % Cm_lef_q table.
    Cm_diff = data.aero.coeffs.table.pitch.Cm_diff; % Cm difference table.
    Cm_ds = data.aero.coeffs.table.pitch.Cm_ds; % Cm_ds table..
    Cm_sb = data.aero.coeffs.table.pitch.Cm_sb; %Cm_sb table.
    Cm_eta = data.aero.coeffs.table.pitch.Cm_eta; % Cm_eta table.
    % Reference Signal
    refAlphaLong = data.aero.coeffs.table.refSignals.alphaLong; % Ref AoA v1
    refAlphaShort = data.aero.coeffs.table.refSignals.alphaShort; % Ref AoA
    refBeta = data.aero.coeffs.table.refSignals.beta; % Ref AoS
    refEleLong = data.aero.coeffs.table.refSignals.eleLong; % Ref Ele v2
    refEleLongest = data.aero.coeffs.table.refSignals.eleLongest; % Ref Ele
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
    pitch.Cm = interp3(refBeta, refAlphaLong, refEleLong, Cm, beta, ...
        alpha, ele);
    pitch.Cm_de0 = interp3(refBeta, refAlphaLong, refEleLong, Cm, beta,...
        alpha, 0);
    % ---------------------------------------------------------------------
    %% ------------------|Damping Pitch Coefficient|-----------------------
    pitch.Cm_q = interp1(refAlphaLong, Cm_q, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----|Pitch Moment Coeffs Effects on Control Surface Deflection|-----
    pitch.Cm_sb = interp1(refAlphaLong, Cm_sb, alpha, 'linear', 'extrap');
    % ---------------------------------------------------------------------
    %% ----------|Pitch Moment Coeffs Effect on Surface Deflects.|---------
    pitch.Cm_diff = interp1(refAlphaLong, Cm_diff, alpha, 'linear', ...
        'extrap');
    % ---------------------------------------------------------------------
    %% ---------|Pitch Moment Coeffs Effect on Normalized Elevator|--------
    pitch.Cm_ds = interp2(refEleLongest, refAlphaLong, Cm_ds, ele, ...
        alpha);
    % ---------------------------------------------------------------------
    %% -----------------------|Second Limitter|----------------------------
    if alpha < -20; alpha = -20; end; if alpha >= 45; alpha = 45; end
    % ---------------------------------------------------------------------
    %% ------------------|LEF Effect on Main Coeff.|-----------------------
    pitch.Cm_lef = interp2(refBeta, refAlphaShort, Cm_lef, beta, alpha);
    % ---------------------------------------------------------------------
    %% ----------------|LEF Effect on Dynamic Coeff.|----------------------
    pitch.Cm_lef_q = interp1(refAlphaShort, Cm_lef_q ,alpha, 'linear', ...
        'extrap'); 
    % ---------------------------------------------------------------------
    %% --------------------|Normalized Elevator|---------------------------
    pitch.Cm_eta = interp1(refEleLong, Cm_eta, ele, 'linear', 'extrap');
    % ---------------------------------------------------------------------
end % End of "Pitch Moment Interpolation" Function