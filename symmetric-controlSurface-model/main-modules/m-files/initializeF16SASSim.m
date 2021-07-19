% Initialize F-16 Simulation for SAS Model.
%% --------------------------|Starting SAS Sim.|---------------------------
fprintf('<strong>>>> Starting F-16 SAS Simulation... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
fprintf('<strong>>>> Loading F-16 Gain Schedule Data... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('<strong>####...</strong> Gain Schedule Data Loaded.\n');
scheduleData = load('schedulingData.mat');
scheduleData = scheduleData.scheduleData;
range.tas.min = 300; range.tas.step = 50; range.tas.max = 900;
range.z_e.min = 3000; range.z_e.step = 500; range.z_e.max = 25000;
fprintf('--------------------------------------------\n');
% Change Location.
cd symmetric-controlSurface-model/main-modules/model-files/
open('f16_hifi_euler_vSAS.slx');
% Input Parameter Preperation.
simTime = input('What is your simulation time in (sec):    ');
stepTime = input('What is your step time in (sec):    ');
% Flight Gear Part.
msgg.fg_warnMSG = ['Please activate animation model if you use in Windows OS, ' ...
    'due to lack of linux OS FG files, animation model can not work ' ...
    'properly in linux OS.'];
warning(msgg.fg_warnMSG);
flag.fg_anim = input('Do you want to animate the simulation in flight gear [Y/N]:    ','s');
checker.fg_anim = 0;
if flag.fg_anim == 'N'
    set_param('f16_hifi_euler_vSAS/F-16 HiFi Model/FlightGear Animation', ...
        'Commented', 'on');
elseif flag.fg_anim == 'Y'
    set_param('f16_hifi_euler_vSAS/F-16 HiFi Model/FlightGear Animation', ...
        'Commented', 'off');
    system('runfg.bat&');
    pause(60);
else
    while ~checker.fg_anim
        msgg.fg_warnMSG_2 = ['Wrong Input is entered.' ...
            'Please reanswer the question for Yes [Y] and for No [N]'];
        warning(msgg.fg_warnMSG_2);
        flag.fg_anim = input('Do you want to animate the simulation in flight gear [Y/N]:    ','s');
        if ~ismember(flag.fg_anim, {'Y','N'})
            checker.fg_anim = 0;
        else
            checker.fg_anim = 1;
        end
    end
end
% Joystick Part
flag.joy = input('Do you want to control your aircraft with joystick [Y/N]:     ','s');
checker.joy = 0;
if flag.joy == 'N'
    flag.joyIn = 0;
elseif flag.joy == 'Y'
    flag.joyIn = 0;
else
    while ~checker.joy
        msgg.joy = ['Wrong Input is entered.' ...
            'Please reanswer the question for Yes [Y] and for No [N]'];
        warning(msgg.joy);
        flag.joy = input('Do you want to control your aircraft with joystick [Y/N]:     ','s');
        if ~ismember(flag.joy, {'Y','N'})
            checker.joy = 0;
        else
            checker.joy = 1;
        end
    end
end
% Running Simulation.
f16_HiFi_vSAS_Result = sim('f16_hifi_euler_vTrim');
save_system('f16_hifi_euler_vSAS.slx');
close_system('f16_hifi_euler_vSAS.slx');
% Back to Original Location.
cd ../../..
fprintf('--------------------------------------------\n');
% Graphher
flag.grapher = input('Do you want to see simulation results as a graph [Y/N]:   ','s');
checker.grapher = 0;
if flag.grapher == 'Y'
    getSimResGraphs(f16_HiFi_vSAS_Result)
elseif flag.grapher == 'N'
else
    while ~checker.grapher
    msgg.grapher = ['Wrong Input is entered.' ...
        'Please reanswer the question for Yes [Y] and for No [N]'];
    warning(msgg.grapher);
    flag.grapher = input('Do you want to see simulation results as a graph [Y/N]:    ','s');
        if ~ismember(flag.grapher, {'Y','N'})
            checker.grapher = 0;
        else
            checker.grapher = 1;
        end
    end
end
fprintf('--------------------------------------------\n');