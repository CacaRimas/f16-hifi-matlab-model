% Whole Aircraft Specifications Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole aircraft specifications data read function. Data are taken from
% Steven's "Aircraft Control and Simulation" textbook. The textbook also,
% found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Outputs:
%       acSpec: Aircraft Specification Parameters.
%           Cm => Pitch Moment main coefficient.
%           Cm_q => Pitch Moment damping derivative coefficieint.
%           Cm_lef => Pitch Moment coeffiicent effect on lef.
%           Cm_lef_q => Pitch Moment damping coefficient effect on lef.
%           Cm_sb => Pitch Moment coeffiicent effect on speed breaker.
%           Cm_eta => Pitch Moment coefficient effect on Normalized Ele.
%           Cm_diff => Pitch Momment coefficient effect on differentials.
%           Cm_ds => Pitch Moment coefficient effect on surface deflection.
% -------------------------------------------------------------------------
% =========================================================================

function acSpec = readACSpecDataTables()
    %% -----------------|Aircraft Specification Data Read|-----------------
    dataACSpec = load('aircraft-specs-table.dat');
    % ---------------------------------------------------------------------
    %% ---------------|Manipulation Readed Data Parameters|----------------
    % Wing Parameters
    acSpec.wing.S = dataACSpec(1, 1); % Reference wing area (ft^2)
    acSpec.wing.b = dataACSpec(1, 2); % Wing span (b)
    acSpec.wing.cbar = dataACSpec(1, 3); % Wing mean aerodynamic chord (ft)
    % Fusalage Parameters
    acSpec.fusalage.x_cg = dataACSpec(1, 4); % Center of gravity (ft)
    acSpec.fusalage.x_cg_ref = dataACSpec(1, 5); % Nominal C. G. (ft)
    % Inertia Parameters
    acSpec.inertia.I_xx = dataACSpec(2, 1); % X-Axis MoI (slug*ft)
    acSpec.inertia.I_yy = dataACSpec(2, 2); % Y-Axis MoI (slug*ft)
    acSpec.inertia.I_zz = dataACSpec(2, 3); % Z-Axis MoI (slug*ft)
    acSpec.inertia.I_xz = dataACSpec(2, 4); % X-Z Plane MoI (slug*ft^2)
    % General Parameters
    acSpec.general.empWeight = dataACSpec(3, 1); % Empty Weight (slug)
    % ---------------------------------------------------------------------
end % End of "Pitch Moment Coefficients Data Read" Function.