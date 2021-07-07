% Whole Y-Axis Force Coefficients Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 28.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole y-axis force coefficients data read function. Data are taken from
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       xaxis: Y-axis force coefficients.
%           Cy => Y-Axis main coefficient.
%           Cy_p => Y-Axis damping derivative coefficieint on roll rate.
%           Cy_r => Y-Axis damping derivative coefficieint on yaw rate.
%           Cy_lef => Y-Axis coeffiicent effect on lef.
%           Cy_lef_p => Y-Axis damping coefficient effect on lef on roll.
%           Cy_lef_r => Y-Axis damping coefficient effect on lef on yaw.
%           Cy_lef_ail => Y-Axis damping coefficient effect on lef on ail.
%           Cy_ail => Y-Axis force coefficient effect on ailern deflection.
%           Cy_rud => Y-Axis force coefficient effect on rudder deflection.
% -------------------------------------------------------------------------
% =========================================================================

function yaxis = readYAxisForceDataTables()
    %% ------------------|Y Body Axis Main Coefficient|--------------------
    tableCy = load('cy-table.dat');
    yaxis.Cy = tableCy;
    % ---------------------------------------------------------------------
    %% -----------------|Y Body Axis Damping Coefficient|------------------
    tableCy_p = load('cy_p-table.dat');
    yaxis.Cy_p = tableCy_p;
    tableCy_r = load('cy_r-table.dat');
    yaxis.Cy_r = tableCy_r;
    % ---------------------------------------------------------------------
    %% ------|Y Body Axis Coefficient Effect of Control Deflections|-------
    tableCy_ail = load('cy_ail-table.dat');
    yaxis.Cy_ail = tableCy_ail;
    tableCy_rud = load('cy_rud-table.dat');
    yaxis.Cy_rud = tableCy_rud;
    % ---------------------------------------------------------------------    
    %% -------|Y-Axis Force Coefficient Effect of Leading Edge Flap|-------
    tableCy_lef = load('cy_lef-table.dat');
    yaxis.Cy_lef = tableCy_lef;
    % ---------------------------------------------------------------------
    %% ---|Y-Axis Force Damping Coefficient Effect of Leading Edge Flap|---
    tableCy_lef_p = load('cy_lef_p-table.dat');
    yaxis.Cy_lef_p = tableCy_lef_p;
    tableCy_lef_r = load('cy_lef_r-table.dat');
    yaxis.Cy_lef_r = tableCy_lef_r;
    % ---------------------------------------------------------------------
    %% -|Y-Axis Force Effect of Leading Edge Flap and Aileron Deflection|--
    tableCy_lef_ail = load('cy_lef_ail-table.dat');
    yaxis.Cy_lef_ail = tableCy_lef_ail;
    % ---------------------------------------------------------------------
end % End of "Y-Axis Force Coefficients Data Read" Function.