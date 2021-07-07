% Whole Data Collector for Main Scheduling Data
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 03.06.2021
% for question: cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Preparing Scheduling Data
% -------------------------------------------------------------------------
% =========================================================================

function getWholeScheduleDataCollector_Euler(range)
    %% ---------------------|Pre Sizing for Scheduling|--------------------
    z_e = range.z_e.min:range.z_e.step:range.z_e.max;
    tas = range.tas.min:range.tas.step:range.tas.max;
    % Memmory Allocations
    scheduleData.euler.trim = zeros(length(z_e), length(tas), 30);
    scheduleData.euler.gain.sas.long = zeros(length(z_e), length(tas), 4);
    scheduleData.euler.gain.sas.lat = zeros(length(z_e), length(tas), 2,4);
    % ---------------------------------------------------------------------
    %% --------------------------|Data Collection|-------------------------
    saveLocation = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/scheduling-data'];
    loadLocation.trim = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/trim-data/'];
    loadLocation.sasGain = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/sasGain-data/'];
    for iter = 1:length(z_e)
        for jiter = 1:length(tas)
        % Trim Data Scheduling
            loadDir.trim = fullfile(cd, loadLocation.trim);
            loadFileName.trim = ['trimData_', num2str(z_e(iter)), '_', ...
                    num2str(tas(jiter))];
            outputs = load(fullfile(loadDir.trim, loadFileName.trim));
            outputs = outputs.outputs;
            trimEulerStates = cell2mat(struct2cell(outputs.trim.states));
            trimEulerControls = cell2mat(struct2cell(outputs.trim.controls));
            trimEuler = [trimEulerStates; trimEulerControls];
            scheduleData.euler.trim(iter, jiter, :) = trimEuler;
        % SAS Gain Data Scheduling
            loadDir.gain.sas = fullfile(cd, loadLocation.sasGain);
            loadFileName.gain.sas = ['sasGainsData',num2str(z_e(iter)), ...
                '_', num2str(tas(jiter))];
            K = load(fullfile(loadDir.gain.sas, loadFileName.gain.sas));
            K = K.K;
            scheduleData.euler.gain.sas.long(iter, jiter, :) = K.long;
            scheduleData.euler.gain.sas.lat(iter, jiter, :, :) = K.lat;
        end
    end
    % ---------------------------------------------------------------------
    %% ------------------------|Saving Data Files|-------------------------
    % Saving Data
    saveDir = fullfile(cd, saveLocation);
    saveFileName.euler = 'schedulingData';
    save(fullfile(saveDir, saveFileName.euler), 'scheduleData');
    % Adding Project
    cd(saveDir)
    addFile(matlab.project.currentProject, [saveFileName.euler,'.mat']);
    cd ../../../../..
% -------------------------------------------------------------------------
end % End of "Scheduling Data Collector" Function.