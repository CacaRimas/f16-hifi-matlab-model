% Initialize F-16 Trim Code with using euler angles
%% -------------------------|Global Variables|-------------------------
    global flag
    % ---------------------------------------------------------------------
%% -------------------------|Starting Euler Trim|--------------------------
fprintf('<strong>>>> Starting Euler Trim Model... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
fprintf('What type of flight condition do you want to trim F-16\n');
fprintf('<strong> 1. </strong> Steady wings-level flight\n');
fprintf('<strong> 2. </strong> Steady turning flight\n');
fprintf('<strong> 3. </strong> Steady pull-Up flight\n');
fprintf('<strong> 4. </strong> Steady roll turn flight\n');
fprintf('<strong> 5. </strong> Climb at specific rate of climb flight\n');
flag.trimCon = input('Choice:   ');
checker.trimCon = 0;
if ~ismember(flag.trimCon, {1,2,3,4,5})
    switch flag.trimCon
        case 1 % Steady Flight
            inputs.phi = 0;
            inputs.phi_dot = 0;
            inputs.theta_dot = 0;
            inputs.psi_dot = 0;
            inputs.rateOfClimb = 0;
        case 2 % Coordinated Turn
            inputs.gamma = 0;
            inputs.phi_dot = 0;
            inputs.theta_dot = 0;
            inputs.psi_dot = input('Waht is your desired turning rate (deg/s):    ');
            inputs.psi_dot = deg2rad(inputs.psi_dot);
            flag.corTurn = input('Does the steady-turn flight is coordinated [Y/N]:     ','s');
            checker.corTurn = 0;
            if flag.corTurn == 'N'
                inputs.phi = input('What is your desired bank angle (deg):    ');
                inputs.gamma = input('What is your desired flight path angle (deg):    ');
                inputs.gamma = deg2rad(inputs.gamma);
            elseif flag.corTurn == 'Y'
                inputs.phi = 0;
                flag.climbTurn = input('Do you want to climb while turning ? [Y/N]:    ','s');
                checker.climbTurn = 0;
                if flag.climbTurn == 'Y'
                    inputs.rateOfClimb = input('What is your desired rate of climb (ft/s):    ');
                elseif flag.climbTurn == 'N'
                    inputs.rateOfClimb = 0;
                else
                    while ~checker.climbTurn
                        msg.climbTurn = ['Wrong Input is entered.' ...
                        'Please reanswer the question for your choice [Y/N]'];
                        warning(msgg.climbTurn);
                        flag.climbTurn = input('Do you want to climb while turning ? [Y/N]:    ','s'); 
                        if ~ismember(flag.climbTurn, {'Y','N'})
                            checker.climbTurn = 0;
                        else
                            checker.climbTurn = 1;
                        end
                    end % Msg Checker
                end % Flag of climb during coordinated Turn
            end % Flag condition of Coordinated Turn Question
        case 3
            inputs.phi = 0;
            inputs.rateOfClimb = 0;
            inputs.gamma = input('What is your desired flight path angle (deg):    ');
            inputs.gamma = deg2rad(inputs.gamma);
            inputs.phi_dot = 0;
            inputs.psi_dot = 0;
            inputs.theta_dot = input('Waht is your desired pull-up rate (deg/s):    ');
            inputs.theta_dot = deg2rad(inputs.theta_dot);
        case 4
            inputs.phi = 0;
            inputs.rateOfClimb = 0;
            inputs.gamma = input('What is your desired flight path angle (deg):    ');
            inputs.gamma = deg2rad(inputs.gamma);
            inputs.theta_dot = 0;
            inputs.psi_dot = 0;
            inputs.phi_dot = inputs('Waht is your desired roll rate (deg/s):    ');
            inputs.phi_dot = deg2rad(inputs.phi_dot);
        case 5
            inputs.rateOfClimb = input('What is your desired rate of climb (ft/s):    ');
    end
else
    while ~checker.trimCon
        msg.trimCon = ['Wrong Input is entered.' ...
            'Please reanswer the question for your choice [Y/N]'];
        warning(msgg.trimCon);
        flag.trimCon = input('What is your desired flight condition [1/2/3/4/5]:    ');
        if ~ismember(flag.trimCon, {1,2,3,4,5})
            checker.trimCon = 0;
        else
            checker.trimCon = 1;
        end
    end
end
% Input Parameter Preperation.
inputs.tas = input('What is your desired true airspeed for flight (ft/sec):    ');
inputs.z_e = input('What is your desired altitude for flight (ft):     ');
inputs.lat = input('What is your initial latitude position (deg):     ');
inputs.long = input('What is your initial longitude position (deg):     ');
inputs.psi = input('What is your desired initial heading (deg):     ');
fprintf('--------------------------------------------\n');
% Others (It is for Steady-Flight it will change later versions...)
inputs.alpha = 0;
inputs.beta = 0;
inputs.theta = 0;
inputs.psi = deg2rad(inputs.psi);
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