% F-16's Linearization Data Type Converter
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 01.06.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% This function convert input commands into strcutre to use in flight
% dynamic function. After that, convert strcuture part into variables to
% use in linearization functions.
% -------------------------------------------------------------------------
% =========================================================================

function [states_dot, output_dot] = convertInOut(statesVar, controlsVar)
    %% ------------------|Convert Variables To Structures|-----------------
    % States
    states.tas = statesVar(1); states.alpha = statesVar(2);
    states.beta = statesVar(3); states.phi = statesVar(4);
    states.theta = statesVar(5); states.psi = statesVar(6);
    states.p = statesVar(7); states.q = statesVar(8);
    states.r = statesVar(9); states.x_e = statesVar(10);
    states.y_e = statesVar(11); states.z_e = statesVar(12);
    states.lat = statesVar(13); states.long = statesVar(14);
    states.power = statesVar(15); states.u = statesVar(16);
    states.v = statesVar(17); states.w = statesVar(18);
    states.q0 = statesVar(19); states.q1 = statesVar(20);
    states.q2 = statesVar(21); states.q3 = statesVar(22);
    states.aN = statesVar(23); states.aY = statesVar(24);
    % Controls
    controls.throttle = controlsVar(1); controls.elevator = controlsVar(2);
    controls.aileron = (3); controls.rudder = controlsVar(4);
    controls.sb = controlsVar(5); controls.lef = controlsVar(6);
    % ---------------------------------------------------------------------
    %% ------------------------|Run Flight Dynamic|------------------------
    [outDers, outStates] = getFlightDynamic_Eulers(states, controls);
    % ---------------------------------------------------------------------
    %% ------------------|Convert Structures To Variables|-----------------
    % Derivatives
    states_dot(1:3) = cell2mat(struct2cell(outDers.windParams));
    states_dot(4:6) = cell2mat(struct2cell(outDers.eulerAngles));
    states_dot(7:9) = cell2mat(struct2cell(outDers.angRates));
    states_dot(10:12) = cell2mat(struct2cell(outDers.nav));
    states_dot(13) = cell2mat(struct2cell(outDers.power));
    % States
    output_dot = cell2mat(struct2cell(outStates));
    % ---------------------------------------------------------------------
end % End of "Converter and Runner for Linearization" Function.