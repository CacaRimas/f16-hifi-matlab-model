% Atmosphere Model Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 20.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Atmosphere model function to calculate atmospheric parameters such as
% temperature, mach, pressure etc.
% General Equations can be found in Steven's "Aircraft Control and 
% Simulation" textbook. Textbook also, be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Aircraft's state information as a main structure.
%           tas => True airspeed (ft/s)
%           z_e => Altitude (ft)
%   Outputs:
%       atmParams => Atmospheric Parameters as a main structure.
%           mach => Mach number ()
%           rho => Density (slug/ft^3)
%           a => Speed of sound (ft/s)
%           temp => Temperature (K)
%           qbar => Dynamic pressure (lb/ft^2)
%           psta => Static pressure (lb/ft^2)
% -------------------------------------------------------------------------
% =========================================================================

function atmParams = getAtmosphereParams(states)
    %% ------------------------|State Information|-------------------------
    tas = states.tas; % True Airspeed (ft)
    z_e = states.z_e; % Altitude (Down) (ft)
    % ---------------------------------------------------------------------
    %% ----------------------|Atmospheric Parameters|----------------------
    % Temperature Calculation
    tfac = 1 - 0.703e-5*z_e; % Temperature factor
    tempR = 519*tfac; % Temperature (Rankine)
    if z_e >= 35000
        tempR = 390;
    end
    tempK = tempR * 5/9; % Temperature (Kelvin)
    % Density Calculation
    rho_0 = 2.377e-3; % Sea Level Density (slug/ft^3)
    rho = rho_0*(tfac^(4.14)); % Density (slug/ft^3)
    % Speed of Sound and Mach Calculation
    k = 1.4;
    a = sqrt(k*1716.3*tempR); % Speed of Sound (ft/s)
    mach = tas/a; % Mach number ()
    % Pressure Calculation
    qbar = 0.5*rho*tas^2; % Dynamic pressure (lb/ft^2)
    psta = 1715*rho*tempR; % Static prssure (lb/ft^2)
    % ---------------------------------------------------------------------
    %% -----------------------------|Outputs|------------------------------
    atmParams.temp = tempK;
    atmParams.rho = rho;
    atmParams.a = a;
    atmParams.mach = mach;
    atmParams.qbar = qbar;
    atmParams.psta = psta;
    % ---------------------------------------------------------------------
end % End of "Atmosphere Model" Function.