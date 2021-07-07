% Initialize F-16 Trim Code with using euler angles
%% -------------------------|Starting Euler Trim|--------------------------
fprintf('<strong>>>> Starting Euler Trim Model... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
% Input Parameter Preperation.
inputs.tas = input('What is your desired true airspeed for flight (ft/sec):    ');
inputs.z_e = input('What is your desired altitude for flight (ft):     ');
inputs.lat = input('What is your initial latitude position (deg):     ');
inputs.long = input('What is your initial longitude position (deg):     ');
fprintf('--------------------------------------------\n');
% Others (It is for Steady-Flight it will change later versions...)
inputs.alpha = 0;
inputs.beta = 0;
inputs.phi = 0;
inputs.theta = 0;
inputs.psi = 0;
inputs.p = 0;
inputs.q = 0;
inputs.r = 0;
inputs.x_e = 0;
inputs.y_e = 0;
inputs.thrtl = 0.5;
inputs.ele = 0;
inputs.ail = 0;
inputs.rud = 0;
inputs.sb = 0;
inputs.lef = 0;
% *************************************************************************
% Starting Trim Code
outputs = getTrimValues_Euler(inputs);
fprintf('--------------------------------------------\n');
% -------------------------------------------------------------------------