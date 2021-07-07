% Derivative of Angular Rates Parameters Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of force parameters calculation with using body axis
% speeds, aerodynamic forces, euler angles, gravity, thrust and body axis
% angular rates. The flight path equations are found in
% Steven's "Aircraft Control and Simulation" (Table 2.5-10)
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           p => Body roll rate (rad/s)
%           q => Body pitch rate (rad/s)
%           r => Body yaw rate (rad/s)
%       moments => Aerodynamic forces.
%           L => X-Axis aerodynamic forces (lbf)
%           M => Y-Axis aerodynamic forces (lbf)
%           N => Z-Axis aerodynamic forces (lbf)
%       data => Aircraft Specifications.
%           I_ii => Aircraft moment of inertias (slug*ft^2)
%   Outputs:
%       ders => Derivative of state parameters.
%           p_dot => Derivative of roll rate (rad/s^2)
%           q_dot => Derivative of pitch rate (rad/s^2)
%           r_dot => Derivative of yaw rate (rad/s^2)
% -------------------------------------------------------------------------
% =========================================================================

function angRates = getCAMEmoments(states,moments, data)
    %% -------------------------|State Variables|--------------------------
    p = states.p;
    q = states.q;
    r = states.r;
    % ---------------------------------------------------------------------
    %% -----------------------|Aerodynamic Moments|------------------------
    L = moments.L;
    M = moments.M;
    N = moments.N;
    % ---------------------------------------------------------------------
    %% ----------------------|Aircraft Specifications|---------------------
    I_xx = data.acSpec.inertia.I_xx;
    I_yy = data.acSpec.inertia.I_yy;
    I_zz = data.acSpec.inertia.I_zz;
    I_xz = data.acSpec.inertia.I_xz;
    h_x = data.engine.specs.angMom.h_x;
    % ---------------------------------------------------------------------
    %% _--------------------------|Some Shortcut|---------------------------
    x_pq = I_xz*(I_xx-I_yy+I_zz);
    x_qr = I_zz*(I_zz-I_yy)+I_xz^2;
    z_pq = (I_xx-I_yy)*I_xx+I_xz^2;
    y_pr = I_zz-I_xx;
    gam = I_xx*I_zz-I_xz^2;
    % ---------------------------------------------------------------------
    %% ------------|Derivative of Body Angular Rates Equations|------------
    angRates.p = (x_pq*p*q-x_qr*q*r+I_zz*L+I_xz*(N+q*h_x))/gam;
    angRates.q = (y_pr*p*r-I_xz*(p^2-r^2)+M-r*h_x)/I_yy;
    angRates.r = (z_pq*p*q-x_pq*q*r+I_xz*L+I_xx*(N+q*h_x))/gam;
    % ---------------------------------------------------------------------
    end % End of "Derivative of Angular Rates Equation Variables" Function.