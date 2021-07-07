% Aerodynamic Tables Reference Signal Obtain Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 29.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Reference signals for different aerodynamic tables, these references
% signals are found both Steven's "Aircraft Simulation and Control"
% textbook and Nguyen's "Simulator Study of Stall/Post Stall
% Characteristics of a Fighter Airplane With Relaxed Longitudinal Static
% Stability" paper. Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       refSignals => Reference signals for aerodynamic tables.
%           alphaLong => Long version of Angle of Attack (deg)
%           alphaShort => Short version of Angle of Attack (deg)
%           beta => Angle of Sideslip (deg)
%           eleLong => Long version of elevator deflection (deg)
%           eleShort => Short version of elevator deflection (deg)
% -------------------------------------------------------------------------
% =========================================================================

function refSignals = getAeroTableReferenceSignal()
    %% ---------------------|Reference Signals|----------------------------
    % Angle of Attack
    refSignals.alphaLong = [-20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30,... 
        35, 40, 45, 50, 55, 60, 70, 80, 90];
    refSignals.alphaShort = [-20, -15, -10, -5, 0, 5, 10, 15, 20, 25,...
        30, 35, 40, 45];
    % Angle of Sideslip
    refSignals.beta = [-30, -25, -20, -15, -10, -8, -6, -4, -2, 0, 2, 4,...
        6, 8, 10, 15, 20, 25, 30];
    % Elevator Deflection
    refSignals.eleLongest = [-25, -10, 0, 10, 15, 20, 25];
    refSignals.eleLong = [-25, -10, 0, 10, 25];
    refSignals.eleShort = [-25, 0, 25];
    % ---------------------------------------------------------------------
end % End of "Reference Signal Obtain" Function.