% Idle Thrust Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole idle thrust data read functions. Data are taken from Steven's
% "Aircraft Simulation and Control" textbook also data can be found in 
% Nguyen's "Simulator Study of Stall/Post Stall Characteristics of a 
% Fighter Airplane With Relaxed Longitudinal Static Stability" paper.
% Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       idle => Idle Thrust Data.
%           T => Thrust Table.
% -------------------------------------------------------------------------
% =========================================================================

function idle = readIdleThrustData()
    %% -------------------------|Data Read|--------------------------------
    tableIdle = load('idle-thrust-table.dat');
    idle.T = tableIdle;
    % ---------------------------------------------------------------------
end % End of "Idle Thrust Data Read" Function.