% F-16's Simulation Result Grapher
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 06.07.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Graph whole simulation result depends on user desire.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       simulationRes => Simulation Results.
%       flag => User Input.
%           grapRes => Which graphs user desire.
% -------------------------------------------------------------------------
% =========================================================================

function getSimResGraphs(simRes)
close;
%% -------------------------------|Outputs|--------------------------------
states = simRes.states;
sensors = simRes.sensorData;
conInp = simRes.pilotCmds;
engine = simRes.engine;
atmos = simRes.atmParam;
time = simRes.tout;
% -------------------------------------------------------------------------
%% ----------------------------|States Graphs|-----------------------------
% Speed Graphs
tas_kts = convvel(states(:,1), 'ft/s', 'kts');
ias_kts = convvel(sensors(:,12), 'ft/s', 'kts');
figure('Name','Speed Information in Knots');
subplot(2,1,1)
plot(time, tas_kts, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('V_{tas} (kts)');
title('True Airspeed Graph');
grid on
subplot(2,1,2)
plot(time, ias_kts, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('V_{ias} (kts)');
title('Indicated Airspeed Graph');
grid on
% Wind Angles
aoa_deg = convang(states(:,2), 'rad', 'deg');
aos_deg = convang(states(:,3), 'rad', 'deg');
figure('Name','Wind Angle Information in Degrees');
subplot(2,1,1)
plot(time, aoa_deg, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\alpha (deg)');
title('Angle of Attack Graph');
grid on
subplot(2,1,2)
plot(time, aos_deg, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\beta (deg)');
title('Angle of Sideslip Graph');
grid on
% Euler Angles
phi_deg = convang(states(:,4), 'rad', 'deg');
theta_deg = convang(states(:,5), 'rad', 'deg');
psi_deg = convang(states(:,6), 'rad', 'deg');
figure('Name','Euler Angle Information in Degrees');
subplot(3,1,1)
plot(time, phi_deg, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\phi (deg)');
title('Roll Angle Graph');
grid on
subplot(3,1,2)
plot(time, theta_deg, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\theta (deg)');
title('Pitch Angle Graph');
grid on
subplot(3,1,3)
plot(time, psi_deg, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\psi (deg)');
title('Yaw Angle Graph');
grid on
% Angular Rates
p_rad = states(:,7);
q_rad = states(:,8);
r_rad = states(:,9);
figure('Name','Body Axis Angular Rates Information in Radians');
subplot(3,1,1)
plot(time, p_rad, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('p (rad/s)');
title('Roll Rate Graph');
grid on
subplot(3,1,2)
plot(time, q_rad, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('q (rad/s)');
title('Pitch Rate Graph');
grid on
subplot(3,1,3)
plot(time, r_rad, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('r (rad/s)');
title('Yaw Rate Graph');
grid on
% Navigation Parameters
xE_ft = states(:,10);
yE_ft = states(:,11);
zE_ft = states(:,12);
figure('Name','Navigational Parameters Information in Feet');
subplot(3,1,1)
plot(time, xE_ft, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('x_{e} (ft)');
title('North Pos. Graph');
grid on
subplot(3,1,2)
plot(time, yE_ft, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('y_{e} (ft)');
title('East Pos. Graph');
grid on
subplot(3,1,3)
plot(time, zE_ft, 'k', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('z_{e} (ft)');
title('Altitude Pos. Graph');
grid on
% -------------------------------------------------------------------------
%% -------------------------|Control Input Graphs|-------------------------
% Control Inputs
dThrtl = conInp(:,1);
dEle = conInp(:,2);
dAil = conInp(:,3);
dRud = conInp(:,4);
dSb = conInp(:,5);
dLef = conInp(:,6);
figure('Name', 'Control Inputs (Deflections)');
subplot(2,3,1)
plot(time, dThrtl, 'r', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\delta_{Thrt} ()');
title('Throttle Position');
grid on
subplot(2,3,2)
plot(time, dEle, 'r', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\delta_{Ele} (deg)');
title('Elevator Deflection');
grid on
subplot(2,3,3)
plot(time, dAil, 'r', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\delta_{Ail} (deg)');
title('Aileron Deflection');
grid on
subplot(2,3,4)
plot(time, dRud, 'r', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\delta_{Rud} (deg)');
title('Rudder Deflection');
grid on
subplot(2,3,5)
plot(time, dSb, 'r', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\delta_{Sb} (deg)');
title('Speed Breaker Deflection');
grid on
subplot(2,3,6)
plot(time, dLef, 'r', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\delta_{Lef} (deg)');
title('Leading Edge Flap Deflection');
grid on
% -------------------------------------------------------------------------
%% ----------------------------|Sensor Graphs|-----------------------------
aN = sensors(:,4);
aY = sensors(:,5);
lat = sensors(:,10);
long = sensors(:,11);
figure('Name', 'Acceleration Parameters')
subplot(2,1,1)
plot(time, aN, 'b', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('a_{N} (g)');
title('Normal Acceleration Graph');
grid on
subplot(2,1,2)
plot(time, aY, 'b', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('a_{Y} (kts)');
title('Lateral Acceleration Graph');
grid on
figure('Name', 'Navigational Parameters');
subplot(2,1,1)
plot(time, lat, 'b', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\mu (deg)');
title('Latitude Graph');
grid on
subplot(2,1,2)
plot(time, long, 'b', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('l (deg)');
title('Longitude Graph');
grid on
% -------------------------------------------------------------------------
%% ----------------------------|Engine Graphs|-----------------------------
T = engine(:,2);
cmdPow = engine(:,1);
actPow = states(:,13);
figure('Name','Engine and Power Information');
subplot(3,1,1)
plot(time, T, 'c', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('T (lbf)');
title('Thrust Graph');
grid on
subplot(3,1,2)
plot(time, cmdPow, 'c', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('pow_{cmd} (hp)');
title('Commanded Power Graph');
grid on
subplot(3,1,3)
plot(time, actPow, 'c', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('pow_{act} (hp)');
title('Actual Power Graph');
grid on
% -------------------------------------------------------------------------
%% -------------------------|Environment Graphs|---------------------------
temp = atmos(:,1);
rho = atmos(:,2);
a = atmos(:,3);
mach = atmos(:,4);
qbar = atmos(:,5);
pSta = atmos(:,6);
figure('Name', 'Atmosphere Informations');
subplot(2,3,1)
plot(time, temp, 'g', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('T (K)');
title('Temperature');
grid on
subplot(2,3,2)
plot(time, rho, 'g', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('\rho (slug/ft^3)');
title('Density');
grid on
subplot(2,3,3)
plot(time, a, 'g', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('a (ft/s)');
title('Speed of Sound');
grid on
subplot(2,3,4)
plot(time, mach, 'g', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('mach ()');
title('Mach Number');
grid on
subplot(2,3,5)
plot(time, qbar, 'g', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('P_{dyn} (lb/ft^2)');
title('Dynamic Pressure');
grid on
subplot(2,3,6)
plot(time, pSta, 'g', 'LineWidth', 2);
xlabel('Time (sec)');
ylabel('P_{sta} (lb/ft^2)');
title('Static Pressure');
grid on
% -------------------------------------------------------------------------
end % End of "Simulation Graphs" Function.