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
%           x_e => North position (deg)
%           y_e => East position (deg)
%           z_e => Down position (deg)
%           lat => Latitude (deg)
%           long => Longitude (deg)
%   Outputs:
%       graParams => Gravity parameters.
%           g_x => Gravity on x-axis (ft/s^2)
%           g_y => Gravity on y-axis (ft/s^2)
%           g_z => Gravity on z-axis (ft/s^2)
% -------------------------------------------------------------------------
% =========================================================================

function graParams = getGravityParams(states)
    %% -------------------------|State Variables|--------------------------
    x_e = convlength(states.x_e, 'ft', 'm'); % North position (m)
    y_e = convlength(states.y_e, 'ft', 'm'); % East position (m)
    z_e = convlength(states.z_e, 'ft', 'm'); % Down position (m)
    lat = deg2rad(states.lat);  % Latitude (rad)
    long = deg2rad(states.long);  % Longitude (rad)
    % ---------------------------------------------------------------------
    %% -----------------|Constants and Basic Calculations|-----------------
    clat = cos(lat); slat = sin(lat); % Shortcuts for trigonometry
    clon = cos(long); slon = sin(long); % Shortcuts for trigonometry
    h_0 = 0; % Initial estimation of altitude (m)
    a = 6378137.0; % Semi-major axis (m)
    b = 6356752.0; % Semi-minor axis (m)
    e = (sqrt(a^2-b^2))/a; % Eccentricity ()
    w_e = [0; 0; 7.29115e-05]; % Earth's angular rate (rad/s)
    GM = 3986004.418e8; % Gravitional constant (m^3/s^2)
    Re = 6378137; % Radius of earth (m)
    J2 = 1.082626684e-3; % J2 constant
    N = Re/sqrt(1-(e^2)*(slat^2)); % Prime radius of curvature (m)
    n = ((e^2)*N)/(N+h_0); % Trigonometric releation
    r = (N+h_0)*sqrt(1-(n*(2-n)*(slat^2))); % Geocentric radius (m)
    
    % ---------------------------------------------------------------------
    %% ---------------------|Position of in ECEF frame|--------------------
    pos_ecef = [(N+h_0)*clat*clon;
                (N+h_0)*clat*slon;
                (N*(1-e^2)+h_0)*slat];
    % ---------------------------------------------------------------------
    %% ---------------------|Direction Cosine Matrix|----------------------
    DCM_ned2Ecef = [-slat*clon, -slat*slon,  clat;
                    -slon      ,  clon      ,  0    ;
                    -clat*clon, -clat*slon, -slat];
    % ---------------------------------------------------------------------
    %% -------------------|Position of A/C in ECEF frame|------------------
    posAC_ecef = DCM_ned2Ecef\[x_e; y_e; z_e];
    posAC_ecef = posAC_ecef+pos_ecef;
    % ---------------------------------------------------------------------
    %% --------------|Gravitation Calculation in ECEF frame|---------------
    grav_ecef = [(1+(3*J2*0.5*(Re/r)^2)*(1-5*(posAC_ecef(3)/r)^2))*...
     (posAC_ecef(1)/r);
                 (1+(3*J2*0.5*(Re/r)^2)*(1-5*(posAC_ecef(3)/r)^2))*...
     (posAC_ecef(2)/r);
                 (1+(3*J2*0.5*(Re/r)^2)*(1-5*(posAC_ecef(3)/r)^2))*...
     (posAC_ecef(3)/r)];
    grav_ecef = (-GM/(r^2))*grav_ecef;
    % ---------------------------------------------------------------------
    %% --------------|Centifugal Acceleration in ECEF frame|---------------
    accel_ecef = cross(-w_e, cross(w_e, posAC_ecef));
    % ---------------------------------------------------------------------
    %% -------------------|Gravity Result in NED frame|--------------------
    grav_ned = DCM_ned2Ecef*grav_ecef;
    accel_ned = DCM_ned2Ecef*accel_ecef;
    gravity = grav_ned+accel_ned;
    graParams.g_x = convlength(gravity(1, 1), 'm', 'ft');
    graParams.g_y = convlength(gravity(2, 1), 'm', 'ft');
    graParams.g_z = convlength(gravity(3, 1), 'm', 'ft');
    % ---------------------------------------------------------------------
end % End of "Gravity Parameters Calculation" Function.