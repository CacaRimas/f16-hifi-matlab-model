% Initialize F-16 Simulation for Trim Model.
%% ------------------------|Starting Trimmed Sim.|-------------------------
fprintf('<strong>>>> Starting F-16 Trim Simulation... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
open('f16_hifi_euler_vTrim.slx');
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
    set_param('f16_hifi_euler_vTrim/F-16 HiFi Model/FlightGear Animation', ...
        'Commented', 'on');
elseif flag.fg_anim == 'Y'
    set_param('f16_hifi_euler_vTrim/F-16 HiFi Model/FlightGear Animation', ...
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
% Change Location.
cd symmetric-controlSurface-model/main-modules/model-files/
% Running Simulation.
f16_HiFi_vTrim_Result = sim('f16_hifi_euler_vTrim');
save_system('f16_hifi_euler_vTrim.slx');
close_system('f16_hifi_euler_vTrim.slx');
% Back to Original Location.
cd ../../..
fprintf('--------------------------------------------\n');
% Graphher
flag.grapher = input('Do you want to see simulation results as a graph [Y/N]:   ','s');
checker.grapher = 0;
if flag.grapher == 'Y'
    getSimResGraphs(f16_HiFi_vTrim_Result)
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