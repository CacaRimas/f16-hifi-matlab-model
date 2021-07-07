% Whole F-16 Data Read Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 22.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Whole f-16 data are read in this function. The data are created in sub
% functions, these functions can be found in sub-systems module folders.
% -------------------------------------------------------------------------
% =========================================================================

function readWholeAircraftData()
    %% ---------------------------|Engine Data|----------------------------
    % Data Read
    engine.thrust.table.refSignals = readThrustTableReferenceSignal();
    engine.thrust.table.idle = readIdleThrustData();
    engine.thrust.table.military = readMilitaryThrustData();
    engine.thrust.table.maximum = readMaximumThrustData();
    engine.specs = readEngineSpecsData();
    % Save Data File as a .mat file
    cd sub-ac-modules/engine-module/data-files/
    save highFidelityF16EngineData engine
    % Adding Project File
    addFile(matlab.project.currentProject, ...
     'highFidelityF16EngineData.mat');
    cd ../../..
    % ---------------------------------------------------------------------
    %% -------------------------|Aerodynamic Data|-------------------------
    % Data Read
    aero.coeffs.table.refSignals = getAeroTableReferenceSignal();
    aero.coeffs.table.xaxis = readXAxisForceDataTables();
    aero.coeffs.table.yaxis = readYAxisForceDataTables();
    aero.coeffs.table.zaxis = readZAxisForceDataTables();
    aero.coeffs.table.roll = readRollMomentDataTables();
    aero.coeffs.table.pitch = readPitchMomentDataTables();
    aero.coeffs.table.yaw = readYawMomentDataTables();    
    % Save Data File as a .mat file
    cd sub-ac-modules/aerodynamic-module/data-files/
    save highFidelityF16AeroData aero
    % Adding Project File
    addFile(matlab.project.currentProject, ...
     'highFidelityF16AeroData.mat');
    cd ../../..
    % ---------------------------------------------------------------------
    %% --------------------|Aircraft Specification Data|-------------------
    % Data Read
    acSpec = readACSpecDataTables();    
    % Save Data File as a .mat file
    cd sub-ac-modules/aircraft-specification-module/data-files/
    save highFidelityF16ACSpecData acSpec
    % Adding Project File
    addFile(matlab.project.currentProject, ...
     'highFidelityF16ACSpecData.mat');
    cd ../../..    
    % ---------------------------------------------------------------------
end % End of "Whole F-16 Data Read" Function.