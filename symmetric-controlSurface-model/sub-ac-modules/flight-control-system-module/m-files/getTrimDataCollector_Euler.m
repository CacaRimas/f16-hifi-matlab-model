% Trim Data Collector
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 02.06.2021
% for question: cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Execute Trim Data at specific range of velecity and altitude range.
% -------------------------------------------------------------------------
% =========================================================================
function getTrimDataCollector_Euler(range)
%% -----------------|Creating and Saving Trim Data|------------------------
    saveLocation = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/trim-data/'];
    saveDir = fullfile(cd, saveLocation);
    for z_e = range.z_e.min:range.z_e.step:range.z_e.max
        for tas = range.tas.min:range.tas.step:range.tas.max
            inputs.tas = tas;
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
            inputs.z_e = z_e;
            inputs.lat = 40.231667;
            inputs.long = 32.683889;
            inputs.thrtl = 0.5;
            inputs.ele = 0;
            inputs.ail = 0;
            inputs.rud = 0;
            inputs.sb = 0;
            inputs.lef = 0;
            outputs = getTrimValues_Euler(inputs);
            fileName = ['trimData_',num2str(z_e),'_',num2str(tas)];
            save(fullfile(saveDir, fileName), 'outputs');
            cd(saveDir)
            addFile(matlab.project.currentProject, [fileName,'.mat']);
            cd ../../../../..
        end
    end
% -------------------------------------------------------------------------
end % End of "Trim Data Collector" Function.