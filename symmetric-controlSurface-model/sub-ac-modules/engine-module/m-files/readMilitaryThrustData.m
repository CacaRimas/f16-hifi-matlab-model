% Military Thrust Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole military thrust data read functions. Data are taken from Steven's
% "Aircraft Simulation and Control" textbook also data can be found in 
% Nguyen's "Simulator Study of Stall/Post Stall Characteristics of a 
% Fighter Airplane With Relaxed Longitudinal Static Stability" paper.
% Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       military => military Thrust Data.
%           T => Thrust Table.
% -------------------------------------------------------------------------
% =========================================================================

function military = readMilitaryThrustData()
    %% -------------------------|Data Read|--------------------------------
    tableMilitary = load('military-thrust-table.dat');
    military.T = tableMilitary;
    % ---------------------------------------------------------------------
end % End of "Military Thrust Data Read" Function.