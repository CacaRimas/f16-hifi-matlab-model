% Thrust Tables Reference Signal Obtain Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Reference signals for different thrust tables, these references signals
% are found both Steven's "Aircraft Simulation and Control" textbook and
% Nguyen's "Simulator Study of Stall/Post Stall Characteristics of a 
% Fighter Airplane With Relaxed Longitudinal Static Stability" paper.
% Both sources can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       refSignals => Reference signals for thrust tables.
%           mach => Mach references for thrust tables ()
%           z_e => Altitude (down) references for thrust tables (ft)
% -------------------------------------------------------------------------
% =========================================================================

function refSignals = readThrustTableReferenceSignal()
    %% ---------------------|Reference Signals|----------------------------
    % Altitude
    refSignals.z_e = [0, 10000, 20000, 30000, 40000, 50000];
    % Mach
    refSignals.mach = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
    % ---------------------------------------------------------------------
end % End of "Reference Signal Obtain" Function.