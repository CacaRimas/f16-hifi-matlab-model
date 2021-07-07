% Whole X-Axis Force Coefficients Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole x-axis force coefficients data read function. Data are taken from
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       xaxis: X-axis force coefficients.
%           Cx => X-Axis main coefficient.
%           Cx_q => X-Axis damping derivative coefficieint.
%           Cx_lef => X-Axis coeffiicent effect on lef.
%           Cx_lef_q => X-Axis damping coefficient effect on lef.
%           Cx_sb => X-Axis coeffiicent effect on speed breaker.
% -------------------------------------------------------------------------
% =========================================================================

function xaxis = readXAxisForceDataTables()
    %% ------------------|X Body Axis Main Coefficient|--------------------
    tableCx = load('cx-table.dat');
    xaxis.Cx(:,:,1) = tableCx(1:20,:);
    xaxis.Cx(:,:,2) = tableCx(21:40,:);
    xaxis.Cx(:,:,3) = tableCx(41:60,:);
    xaxis.Cx(:,:,4) = tableCx(61:80,:);
    xaxis.Cx(:,:,5) = tableCx(81:100,:);
    % ---------------------------------------------------------------------
    %% -----------------|X Body Axis Damping Coefficient|------------------
    tableCx_q = load('cx_q-table.dat');
    xaxis.Cx_q = tableCx_q;
    % ---------------------------------------------------------------------
    %% ---------|X Body Axis Coefficient Effect of Speed Breaker|----------
    tableCx_sb = load('cx_sb-table.dat');
    xaxis.Cx_sb = tableCx_sb;
    % ---------------------------------------------------------------------    
    %% -------|X-Axis Force Coefficient Effect of Leading Edge Flap|-------
    tableCx_lef = load('cx_lef-table.dat');
    xaxis.Cx_lef = tableCx_lef;
    % ---------------------------------------------------------------------
    %% ---|X-Axis Force Damping Coefficient Effect of Leading Edge Flap|---
    tableCx_lef_q = load('cx_lef_q-table.dat');
    xaxis.Cx_lef_q = tableCx_lef_q;
    % ---------------------------------------------------------------------
end % End of "X-Axis Force Coefficients Data Read" Function.