% Thrust Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Total thrust value calculation with using power information. Equations
% are taken from Steven's "Aircraft Control and Simulation" textbook.
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states: Aircraft state information.
%           power => Power (hp)
%       thrust: Engine thrust information.
%           idle = Engine at Idle Thrust Condition.
%           military = Engine at Military Thrust Condition.
%           maximum = Engine at Maximum Thrust Condition.
%   Outputs:
%       thrust: Calculated thrust value.
% -------------------------------------------------------------------------
% =========================================================================

function T = getThrustValue(thrust, states)
    %% ------------------------|Thrust Conditions|-------------------------
    idle = thrust.idle;
    mil = thrust.military;
    max = thrust.maximum;
    % ---------------------------------------------------------------------
    %% -------------------------|States Variables|-------------------------    
    power = states.power;
    % ---------------------------------------------------------------------
    %% -----------------------|Thrust Calculation|-------------------------
    if power < 50
        T = idle+(mil-idle)*power*0.02;
    else
        T = mil+(max-mil)*(power-50)*0.02;
    end % End of "Power If Condition" for Thrust Calculation.
    % ---------------------------------------------------------------------
end % End of " Thrust Calculation" Function.