% Engine Specs Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole engine specs data read functions. Data are taken from Steven's
% "Aircraft Simulation and Control" textbook also data can be found in 
% Nguyen's "Simulator Study of Stall/Post Stall Characteristics of a 
% Fighter Airplane With Relaxed Longitudinal Static Stability" paper.
% Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       engSpecs=> Engine specifications
%           angMom => Angular momentum of engine (slug*ft/s^2)
%               h_x = > X-axis angular momentum of engine (slug*ft/s^2)
%               h_y = > Y-axis angular momentum of engine (slug*ft/s^2)
%               h_z = > Z-axis angular momentum of engine (slug*ft/s^2)
% -------------------------------------------------------------------------
% =========================================================================

function engSpecs = readEngineSpecsData()
    %% -------------------------|Data Read|--------------------------------
    tableEngSpecs = load('engine-specs-table.dat');
    engSpecs.angMom.h_x = tableEngSpecs(1,1);
    engSpecs.angMom.h_y = tableEngSpecs(1,2);
    engSpecs.angMom.h_z = tableEngSpecs(1,3);
    % ---------------------------------------------------------------------
end % End of "Engine Specification Data Read" Function.