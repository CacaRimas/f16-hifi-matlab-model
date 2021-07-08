% Main Initialize Script to Run F-16 Mathematical Model.
clc; clear; close all
% =========================================================================
%% ---------------------------|Introduction Part|--------------------------
fprintf('<strong>============================================</strong>\n');
fprintf('<strong>|         High Fidelity F-16 Model         |</strong>\n');
fprintf('<strong>============================================</strong>\n');
fprintf('<strong>>>> Starting Project... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
% -------------------------------------------------------------------------
%% -------------------------|F-16 Sub-System Data|-------------------------
fprintf('<strong>>>> Loading F-16 Aero Data... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('<strong>####...</strong> Aerodynamic Data Loaded.\n');
data.aero = load('highFidelityF16AeroData.mat');
data.aero = data.aero.aero; % Aerodynamic Data Correction.
fprintf('--------------------------------------------\n');
fprintf('<strong>>>> Loading F-16 Engine Data... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('<strong>####...</strong> Engine Data Loaded.\n');
data.engine = load('highFidelityF16EngineData.mat');
data.engine = data.engine.engine; % Engine Data Correction
fprintf('--------------------------------------------\n');
fprintf('<strong>>>> Loading F-16 A/C Spec Data... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('<strong>####...</strong> Aircraft Specification Data Loaded.\n');
data.acSpec = load('highFidelityF16ACSpecData.mat');
data.acSpec = data.acSpec.acSpec; % A/C Spec Data Correction.
fprintf('--------------------------------------------\n');
% -------------------------------------------------------------------------
%% -------------------------------|Trim Part|------------------------------
fprintf('<strong>>>> Starting A/C Trim Code... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
%%%%% TRIM TIPI SORULACAK %%%%%
initializeEuler;
% -------------------------------------------------------------------------
%% ---------------------------|Simulation Part|----------------------------
fprintf('<strong>>>> Starting F-16 Simulation... </strong>\n');
fprintf('<strong>#...</strong>\n'); pause(1);
fprintf('<strong>##...</strong>\n'); pause(1);
fprintf('<strong>###...</strong>\n'); pause(1);
fprintf('--------------------------------------------\n');
fprintf('What type of your F16 Model do you want to use ?\n');
fprintf('1. Trim Model\n');
fprintf('2. SAS Model\n');
fprintf('More will be added later on project...\n');
flag.simModel = input('Choice:   ');
fprintf('--------------------------------------------\n');
checker.simModel = 0;
if flag.simModel == 1
    initializeF16TrimSim;
elseif flag.simModel == 2
    initializeF16SASSim;
else
    while ~checker.simModel
    msgg.sim_warnMSG = ['Wrong Input is entered.' ...
        'Please reanswer the question for your choice [1,2,3,...]'];
    warning(msgg.simModel);
    flag.simModel = input('Which model do you want to simulate [1/2]:    ');
    fprintf('--------------------------------------------\n');s
        if ~ismember(flag.simModel, {1,2})
            checker.simModel = 0;
        else
            checker.simModel = 1;
        end
    end
end
% -------------------------------------------------------------------------