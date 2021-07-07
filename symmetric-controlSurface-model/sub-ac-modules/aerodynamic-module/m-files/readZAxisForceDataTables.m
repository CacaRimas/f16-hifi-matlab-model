% Whole Z-Axis Force Coefficients Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole z-axis force coefficients data read function. Data are taken from
% Nguyen's NASA paper which is "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability". These paper can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       zaxis: Z-axis force coefficients.
%           Cz => Z-Axis main coefficient.
%           Cz_q => Z-Axis damping derivative coefficieint.
%           Cz_lef => Z-Axis coeffiicent effect on lef.
%           Cz_lef_q => Z-Axis damping coefficient effect on lef.
%           Cz_sb => Z-Axis coeffiicent effect on speed breaker.
% -------------------------------------------------------------------------
% =========================================================================

function zaxis = readZAxisForceDataTables()
    %% ------------------|X Body Axis Main Coefficient|--------------------
    tableCz = load('cz-table.dat');
    zaxis.Cz(:,:,1) = tableCz(1:20,:);
    zaxis.Cz(:,:,2) = tableCz(21:40,:);
    zaxis.Cz(:,:,3) = tableCz(41:60,:);
    zaxis.Cz(:,:,4) = tableCz(61:80,:);
    zaxis.Cz(:,:,5) = tableCz(81:100,:);
    % ---------------------------------------------------------------------
    %% -----------------|Z Body Axis Damping Coefficient|------------------
    tableCz_q = load('cz_q-table.dat');
    zaxis.Cz_q = tableCz_q;
    % ---------------------------------------------------------------------
    %% ---------|Z Body Axis Coefficient Effect of Speed Breaker|----------
    tableCz_sb = load('cz_sb-table.dat');
    zaxis.Cz_sb = tableCz_sb;
    % ---------------------------------------------------------------------    
    %% -------|Z-Axis Force Coefficient Effect of Leading Edge Flap|-------
    tableCz_lef = load('cz_lef-table.dat');
    zaxis.Cz_lef = tableCz_lef;
    % ---------------------------------------------------------------------
    %% ---|Z-Axis Force Damping Coefficient Effect of Leading Edge Flap|---
    tableCz_lef_q = load('cz_lef_q-table.dat');
    zaxis.Cz_lef_q = tableCz_lef_q;
    % ---------------------------------------------------------------------
end % End of "Z-Axis Force Coefficients Data Read" Function.