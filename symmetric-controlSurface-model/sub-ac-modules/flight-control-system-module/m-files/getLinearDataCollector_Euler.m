% Scheduling Function for Linearization
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 03.12.2020
% for question: cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Parameters
%    Inputs: range => Pre-Range data for altitude and velocity.
% -------------------------------------------------------------------------
% =========================================================================

function getLinearDataCollector_Euler(range)
    %% --------------------------|Linearization|---------------------------
    saveLocation = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/linear-data/'];
    loadLocation = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/trim-data/'];
    loadDir = fullfile(cd, loadLocation);
    saveDir = fullfile(cd, saveLocation);
    % Starting analysis envolope
    for z_e = range.z_e.min:range.z_e.step:range.z_e.max
        for tas = range.tas.min:range.tas.step:range.tas.max
            % Loading Data
            loadFileName = ['trimData_', num2str(z_e), '_', num2str(tas)];
            outputs = load(fullfile(loadDir, loadFileName));
            outputs = outputs.outputs; % For correction.
            % Longitudinal Linearizaton
            [A.long, B.long] = beLongLinear_Euler(outputs);
            % Lateral Linearizaton
            [A.lat, B.lat] = beLatLinear_Euler(outputs);
            % Saving Linear Data
            saveFileName = ['linearData',num2str(z_e),'_' , num2str(tas)];
            save(fullfile(saveDir, saveFileName), 'A', 'B');
            cd(saveDir)
            addFile(matlab.project.currentProject, [saveFileName,'.mat']);
            cd ../../../../..
        end % end of inside for loop
    end % end of outside for loop
    % ---------------------------------------------------------------------
end % End of "Scheduling for Linear Data Function".