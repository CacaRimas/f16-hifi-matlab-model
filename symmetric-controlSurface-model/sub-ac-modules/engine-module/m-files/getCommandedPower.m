% Commanded Power Calculation Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Commanded power calculation function to calculate commanded power with
% respect to commanded throttle which is pilot input. The equation can be 
% found in Steven's "Aircraft Control and Simulation" textbook.
% The textbook also, be found in "references" folder.
% -------------------------------------------------------------------------
% Parameters:   
%   Inputs:
%       controls => Control inputs for F-16
%           throttle => Normalized throttle position ()
%   Outputs:
%       cmdPower => Commanded power values (hp)
% -------------------------------------------------------------------------
% =========================================================================

function cmdPower = getCommandedPower(controls)
    %% --------------------------|Control Inputs|--------------------------
    throttle = controls.throttle;
    % ---------------------------------------------------------------------
    %% --------------------|Commanded Power Calculation|-------------------
    if throttle <= 0
        cmdPower = 0;
    elseif throttle <= 0.77
        cmdPower = 64.94*throttle;
    else
        cmdPower = 217.38*throttle-117.38;
    end % End of commanded power if condition with throttle command
    % ---------------------------------------------------------------------
end % End of "Commanded Power Calculation" Function.