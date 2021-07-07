% SAS Gain Data with LQR
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 02.06.2021
% for question: cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% To find specific gains for linearized model.
% -------------------------------------------------------------------------
% =========================================================================

function getSASGainsDataCollector_Euler(range)
    %% -------------|Creating and Saving SAS Gains Data|-------------------
    saveLocation = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/sasGain-data/'];
    loadLocation = ['symmetric-controlSurface-model/sub-ac-modules',...
        '/flight-control-system-module/data-files/linear-data/'];
    loadDir = fullfile(cd, loadLocation);
    saveDir = fullfile(cd, saveLocation);
    for z_e = range.z_e.min:range.z_e.step:range.z_e.max
        for tas = range.tas.min:range.tas.step:range.tas.max
            loadFileName = ['linearData', num2str(z_e), '_',num2str(tas)];
            linearData = load(fullfile(loadDir, loadFileName));
            A = linearData.A;
            B = linearData.B;
            % Data Inputs
            Q = 0.1*eye(4);
            % Longitudinal
            C.long = [0 1 0 0; 0 0 0 1];
            D.long = [0; 0];
            R.long = (70^-2)*eye(1);
            sys.long = ss(A.long, B.long, C.long, D.long);
            K.long = lqr(sys.long, Q, R.long);
            % Lateral
            C.lat = [0 0 1 0; 0 0 0 1];
            D.lat = [0 0; 0 0];
            R.lat = (70^-2)*eye(2);
            sys.lat = ss(A.lat, B.lat, C.lat, D.lat);
            K.lat = lqr(sys.lat, Q, R.lat);
            % Saving LQR Data both folder and project
            saveFileName = ['sasGainsData',num2str(z_e),'_', num2str(tas)];
            save(fullfile(saveDir, saveFileName), 'K');
            cd(saveDir)
            addFile(matlab.project.currentProject, [saveFileName,'.mat']);
            cd ../../../../..
        end
    end
end % End of "SAS Gain" Function.