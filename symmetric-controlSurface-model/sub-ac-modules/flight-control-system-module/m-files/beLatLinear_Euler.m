% Linearization of Trim Data for Longitudinal
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 01.06.2021
% for question: cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% This function linearize aircraft with using flight dynamic function and
% small perturbation method. Longitudinal is taken in this function.
% -------------------------------------------------------------------------
% Parameters
%   Inputs: 
%       Trimmed data
%   Outputs:
%       A, B Matrices
% -------------------------------------------------------------------------
%==========================================================================

function [A, B] = beLatLinear_Euler(outputs)
    %% --------------------------|Finding Outputs|-------------------------
    states = outputs.trim.states;
    controls = outputs.trim.controls;
    % Running First Flight Dynamic
    statesVar = cell2mat(struct2cell(states));
    controlsVar = cell2mat(struct2cell(controls));
    [~ , outputs] = convertInOut(statesVar, controlsVar);
    % Creating Sizings
    yDim = size(outputs, 1);
    indX = [3 4 7 9];
    indU = [3 4];
    indXDim = size(indX, 2);
    indUDim = size(indU,2);
    % Memmory Allocation
    A = zeros(indXDim, indXDim);
    B = zeros(indXDim, indUDim);
    C = zeros(yDim, indXDim);
    D = zeros(yDim, indUDim);
    zChange1 = zeros(indXDim, 1);
    zChange2 = zeros(indXDim, 1);
    zChange3 = zeros(indXDim, 1);
    zChange4 = zeros(indXDim, 1);
    % ---------------------------------------------------------------------
    for i = 1:indXDim
        xChange = statesVar;
        xChange(indX(i)) = xChange(indX(i))+0.001;
        [states1, outputs1] = convertInOut(xChange,controlsVar);
        for j = 1:indXDim
            zChange1(j) = states1(indX(j));
        end
        xChange = statesVar;
        xChange(indX(i)) = xChange(indX(i))+0.002;
        [states2, outputs2] = convertInOut(xChange,controlsVar);
        for j = 1:indXDim
            zChange2(j) = states2(indX(j));
        end   
        xChange = statesVar;
        xChange(indX(i)) = xChange(indX(i))-0.001;
        [states3, outputs3] = convertInOut(xChange,controlsVar); 
        for j = 1:indXDim
            zChange3(j) = states3(indX(j));
        end   
        xChange = statesVar;
        xChange(indX(i)) = xChange(indX(i))-0.002;
        [states4, outputs4] = convertInOut(xChange,controlsVar);
        for j = 1:indXDim
            zChange4(j) = states4(indX(j));
        end   
        A(:,i) = (8*(zChange1-zChange3)-(zChange2 - zChange4))/(12*0.001);
        C(:,i) = (8*(outputs1-outputs3)-(outputs2 - outputs4))/(12*0.001);
    end
        zChange1  = zeros(indXDim,1);
        zChange2  = zeros(indXDim,1);
        zChange3 = zeros(indXDim,1);
        zChange4 = zeros(indXDim,1);
    for i = 1:indUDim
        uChange = controlsVar;
        uChange(indU(i)) = uChange(indU(i))+0.001;
        [states1, outputs1] = convertInOut(statesVar, uChange);
        for j = 1:indXDim
            zChange1(j) = states1(indX(j));
        end   
        uChange = controlsVar;
        uChange(indU(i)) = uChange(indU(i))+0.002;
        [states2, outputs2] = convertInOut(statesVar, uChange);
        for j = 1:indXDim
            zChange2(j) = states2(indX(j));
        end     
        uChange = controlsVar;
        uChange(indU(i)) = uChange(indU(i))-0.001;
        [states3, outputs3] = convertInOut(statesVar, uChange);
        for j = 1:indXDim
            zChange3(j) = states3(indX(j));
        end   
        uChange = controlsVar;
        uChange(indU(i)) = uChange(indU(i))-0.002;
        [states4, outputs4] = convertInOut(statesVar, uChange);
        for j = 1:indXDim
            zChange4(j) = states4(indX(j));
        end   
        B(:,i) = (8*(zChange1-zChange3)-(zChange2-zChange4))/(12*0.001);
        D(:,i) = (8*(outputs1-outputs3)-(outputs2-outputs4))/(12*0.001);  
    end
end % End of "Longitudinal Linearization Function".