% Derivative of Power Calculation Function
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 04.05.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Derivative of power calculation with using power commands. The equation
% of power calculation is in Steven's "Aircraft Control and Simulation"
% The textbook can be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       states => Whole aircraft state variables.
%           power => Power values (hp)
%       cmdPower => Commanded Power value coming from throttle input.
%   Outputs:
%       ders => Derivative of state parameters.
%           power => Derivatiove of power value (hp/s) 
% -------------------------------------------------------------------------
% =========================================================================

function engine = getDerivativeOfPower(states, cmdPower)
    %% -------------------------|State Variables|--------------------------
    power = states.power;
    % ---------------------------------------------------------------------
    %% -----------------|Derivative of Power Calculation|------------------
    if cmdPower >= 50
        if power >= 50
            T = 5;
            actPower = cmdPower; % Actual Power
        else
            actPower = 60; % Actual Power
            if actPower-power <= 25
                T = 1;
            elseif actPower-power >= 50
                T = 0.1;
            else
                T = 1.9-0.036*(actPower-power);
            end % End of "Delta Power if Condition".
        end % End of Power Derivative Calculation if condition.
    else 
        if power >= 50
            T = 5;
            actPower = 40;
        else
            actPower = cmdPower;
            if actPower-power <= 25
                T = 1;
            elseif actPower-power >= 50
                T = 0.1;
            else
                T = 1.9-0.036*(actPower-power);
            end % End of "Delta Power if Condition".
        end % End of Power Derivative Calculation if condition.
    end % End of Commanded Power If Condition.
    engine.power = T*(actPower-power);
    % ---------------------------------------------------------------------
end % End of "Derivative of Power Calculation" Function.