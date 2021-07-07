% Whole Yaw Moment Coefficients Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole yaw moment coefficients data read function. Data are taken from
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       yaw: yaw moment coefficients.
%           Cn => Yaw Moment main coefficient.
%           Cn_p => Yaw Moment damping derivative coefficieint on yaw.
%           Cn_r => Yaw Moment damping derivative coefficieint on yaw.
%           Cn_lef => Yaw Moment coeffiicent effect on lef.
%           Cn_lef_p => Yaw Moment damping coefficient effect on lef/yaw.
%           Cn_lef_r => Yaw Moment damping coefficient effect on lef/yaw.
%           Cn_ail => yaw Moment coeffiicent effect on control deflects.
%           Cn_rud => Yaw Moment coeffiicent effect on control deflects.
%           Cn_lef_ail => Yaw Moment coeffiicent effect on lef/aileron.
%           Cn_beta => Yaw Moment coeffiicent effect on AoS.
%           Cn_da_diff => Yaw Moment effect on aileron deflection with
%           differatinals.
% -------------------------------------------------------------------------
% =========================================================================

function yaw = readYawMomentDataTables()
    %% ------------------|Yaw Moment Main Coefficient|---------------------
    tableCn = load('cn-table.dat');
    yaw.Cn(:,:,1) = tableCn(1:20,:);
    yaw.Cn(:,:,2) = tableCn(21:40,:);
    yaw.Cn(:,:,3) = tableCn(41:60,:);
    % ---------------------------------------------------------------------
    %% -----------------|Yaw Moment Damping Coefficients|------------------
    tableCn_p = load('cn_p-table.dat');
    yaw.Cn_p = tableCn_p;
    tableCn_r = load('cn_r-table.dat');
    yaw.Cn_r = tableCn_r;
    % ---------------------------------------------------------------------
    %% ------|Yaw Moment Coefficient Effect of Control Deflections|--------
    tableCn_ail = load('cn_ail-table.dat');
    yaw.Cn_ail = tableCn_ail;
    tableCn_rud = load('cn_rud-table.dat');
    yaw.Cn_rud = tableCn_rud;
    % ---------------------------------------------------------------------    
    %% --------|Yaw Moment Coefficient Effect of Leading Edge Flap|--------
    tableCn_lef = load('cn_lef-table.dat');
    yaw.Cn_lef = tableCn_lef;
    % ---------------------------------------------------------------------
    %% ----|Yaw Moment Damping Coefficient Effect of Leading Edge Flap|----
    tableCn_lef_p = load('cn_lef_p-table.dat');
    yaw.Cn_lef_p = tableCn_lef_p;
    tableCn_lef_r = load('cn_lef_r-table.dat');
    yaw.Cn_lef_r = tableCn_lef_r;
    % ---------------------------------------------------------------------    
    %% -------|Yaw Moment Coefficient Effect on Angle of Sideslip|---------
    tableCn_beta = load('cn_beta-table.dat');
    yaw.Cn_beta = tableCn_beta;
    % ---------------------------------------------------------------------
    %% ----------|Yaw Moment Coefficient Effect of Differences|------------
    tableCn_lef_ail = load('cn_lef_ail-table.dat');
    yaw.Cn_lef_ail = tableCn_lef_ail;
    % ---------------------------------------------------------------------
    %% ----|Yaw Moment Coefficient Effect of Aileron and Differentials|----
    tableCn_da_diff = load('cn_da_diff-table.dat');
    yaw.Cn_da_diff = tableCn_da_diff;
    % ---------------------------------------------------------------------
end % End of "yaw Moment Coefficients Data Read" Function.