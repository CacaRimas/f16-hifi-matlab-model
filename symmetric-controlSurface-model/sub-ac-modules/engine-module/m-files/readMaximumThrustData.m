% Maximum Thrust Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole maximum thrust data read functions. Data are taken from Steven's
% "Aircraft Simulation and Control" textbook also data can be found in 
% Nguyen's "Simulator Study of Stall/Post Stall Characteristics of a 
% Fighter Airplane With Relaxed Longitudinal Static Stability" paper.
% Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       maximum => maximum Thrust Data.
%           T => Thrust Table.
% -------------------------------------------------------------------------
% =========================================================================

function maximum = readMaximumThrustData()
    %% -------------------------|Data Read|--------------------------------
    tableMaximum = load('maximum-thrust-table.dat');
    maximum.T = tableMaximum;
    % ---------------------------------------------------------------------
end % End of "Maximum Thrust Data Read" Function.