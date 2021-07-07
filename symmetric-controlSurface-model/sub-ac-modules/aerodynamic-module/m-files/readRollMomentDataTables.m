% Whole Roll Moment Coefficients Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole roll moment coefficients data read function. Data are taken from
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
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

function roll = readRollMomentDataTables()
    %% ------------------|Roll Moment Main Coefficient|--------------------
    tableCl = load('cl-table.dat');
    roll.Cl(:,:,1) = tableCl(1:20,:);
    roll.Cl(:,:,2) = tableCl(21:40,:);
    roll.Cl(:,:,3) = tableCl(41:60,:);
    % ---------------------------------------------------------------------
    %% -----------------|Roll Moment Damping Coefficients|-----------------
    tableCl_p = load('cl_p-table.dat');
    roll.Cl_p = tableCl_p;
    tableCl_r = load('cl_r-table.dat');
    roll.Cl_r = tableCl_r;
    % ---------------------------------------------------------------------
    %% ------|Roll Moment Coefficient Effect of Control Deflections|-------
    tableCl_ail = load('cl_ail-table.dat');
    roll.Cl_ail = tableCl_ail;
    tableCl_rud = load('cl_rud-table.dat');
    roll.Cl_rud = tableCl_rud;
    % ---------------------------------------------------------------------    
    %% -------|Roll Moment Coefficient Effect of Leading Edge Flap|-------
    tableCl_lef = load('cl_lef-table.dat');
    roll.Cl_lef = tableCl_lef;
    % ---------------------------------------------------------------------
    %% ---|Roll Moment Damping Coefficient Effect of Leading Edge Flap|---
    tableCl_lef_p = load('cl_lef_p-table.dat');
    roll.Cl_lef_p = tableCl_lef_p;
    tableCl_lef_r = load('cl_lef_r-table.dat');
    roll.Cl_lef_r = tableCl_lef_r;
    % ---------------------------------------------------------------------    
    %% -------|Roll Moment Coefficient Effect on Angle of Sideslip|--------
    tableCl_beta = load('cl_beta-table.dat');
    roll.Cl_beta = tableCl_beta;
    % ---------------------------------------------------------------------
    %% ---------|Roll Moment Coefficient Effect of Differences|-----------
    tableCl_lef_ail = load('cl_lef_ail-table.dat');
    roll.Cl_lef_ail = tableCl_lef_ail;
    % ---------------------------------------------------------------------
end % End of "Roll Moment Coefficients Data Read" Function.