% Whole Pitch Moment Coefficients Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole pitch moment coefficients data read function. Data are taken from
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       pitch: Pitch moment coefficients.
%           Cm => Pitch Moment main coefficient.
%           Cm_q => Pitch Moment damping derivative coefficieint.
%           Cm_lef => Pitch Moment coeffiicent effect on lef.
%           Cm_lef_q => Pitch Moment damping coefficient effect on lef.
%           Cm_sb => Pitch Moment coeffiicent effect on speed breaker.
%           Cm_eta => Pitch Moment coefficient effect on Normalized Ele.
%           Cm_diff => Pitch Momment coefficient effect on differentials.
%           Cm_ds => Pitch Moment coefficient effect on surface deflection.
% -------------------------------------------------------------------------
% =========================================================================

function pitch = readPitchMomentDataTables()
    %% ------------------|Pitch Moment Main Coefficient|-------------------
    tableCm = load('cm-table.dat');
    pitch.Cm(:,:,1) = tableCm(1:20,:);
    pitch.Cm(:,:,2) = tableCm(21:40,:);
    pitch.Cm(:,:,3) = tableCm(41:60,:);
    pitch.Cm(:,:,4) = tableCm(61:80,:);
    pitch.Cm(:,:,5) = tableCm(81:100,:);
    % ---------------------------------------------------------------------
    %% -----------------|Pitch Moment Damping Coefficient|-----------------
    tableCm_q = load('cm_q-table.dat');
    pitch.Cm_q = tableCm_q;
    % ---------------------------------------------------------------------
    %% ---------|Pitch Moment Coefficient Effect of Speed Breaker|---------
    tableCm_sb = load('cm_sb-table.dat');
    pitch.Cm_sb = tableCm_sb;
    % ---------------------------------------------------------------------    
    %% -------|Pitch Moment Coefficient Effect of Leading Edge Flap|-------
    tableCm_lef = load('cm_lef-table.dat');
    pitch.Cm_lef = tableCm_lef;
    % ---------------------------------------------------------------------
    %% ---|Pitch Moment Damping Coefficient Effect of Leading Edge Flap|---
    tableCm_lef_q = load('cm_lef_q-table.dat');
    pitch.Cm_lef_q = tableCm_lef_q;
    % ---------------------------------------------------------------------
    %% ---------|Pitch Moment Coefficient Effect of Differences|-----------
    tableCm_diff = load('cm_diff-table.dat');
    pitch.Cm_diff = tableCm_diff;
    % ---------------------------------------------------------------------
    %% -----|Pitch Moment Coefficient Effect of Surface Deflection|--------
    tableCm_ds = load('cm_ds-table.dat');
    pitch.Cm_ds = tableCm_ds;
    % ---------------------------------------------------------------------
    %% -----|Pitch Moment Coefficient Effect of Normalized Elevator|-------
    tableCm_eta = load('cm_eta-table.dat');
    pitch.Cm_eta = tableCm_eta;
    % ---------------------------------------------------------------------
end % End of "Pitch Moment Coefficients Data Read" Function.