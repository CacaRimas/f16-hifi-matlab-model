% F-16's Trim Values Function.
% =========================================================================
% -------------------------------------------------------------------------
% Cagatay SAHIN
% 21.04.2021
% cagataysahin44@gmail.com
% -------------------------------------------------------------------------
% Trim values function to calculate equlibrium point of F-16 with respect
% to specific flight envolope which is altitude and speed.
% The trim function equation and conditions can be found in Steven's
% "Aircraft Control and Simulation" textbook. The textbook also, be found
% in "references" folder.
% -------------------------------------------------------------------------
% Parameters:
%   Inputs:
%       inputs => Initial condition of A/C's trim function.
%           tas => True airspeed (ft/s)
%           alpha => Angle of attack (deg)
%           beta => Angle of sideslip (deg)
%           z_e => Altitude (ft)
%           ele => Elevator deflection (deg)
%           ail => Aileron deflection (deg)
%           rud => Rudder deflection (deg)
%           thrtl => Throttle position ()
%   Outputs:
%       outputs => Output of A/C's trim function.
%           trim => Trim information of F-16 such as states and controls
%           cost => Final cost value of trim optimization.
% -------------------------------------------------------------------------
% Notes:
%   For this version of trim condition just steady level wing flight
% is investigated.
% =========================================================================

function outputs = getTrimValues_Euler(inputs)
%% -------------------------|Global Variables|-------------------------
    global initials
    % ---------------------------------------------------------------------
    %% ------------------------|Initial Conditions|------------------------
    % State Variable Information
    initials.tas = inputs.tas;
    initials.alpha = inputs.alpha;
    initials.beta = inputs.beta;
    initials.phi = inputs.phi;
    initials.theta = inputs.theta;
    initials.psi = inputs.psi;
    initials.p = inputs.p;
    initials.q = inputs.q;
    initials.r = inputs.r;
    initials.x_e = inputs.x_e;
    initials.y_e = inputs.y_e;
    initials.z_e = inputs.z_e;
    % Control Input Information
    initials.thrtl = inputs.thrtl;
    initials.ele = inputs.ele;
    initials.ail = inputs.ail;
    initials.rud = inputs.rud;
    initials.sb = inputs.sb;
    initials.lef = inputs.lef;
    % Other Variables Information
    initials.theta_dot = 0;
    initials.phi_dot = 0;
    initials.psi_dot = 0;
    % Latitude and Longitude Calculation
    lla = ned2lla([initials.x_e, initials.y_e, initials.z_e], ...
        [inputs.lat, inputs.long, 0], 'flat');
    initials.lat = lla(1);
    initials.long = lla(2);
    % ---------------------------------------------------------------------  
    %% ------------------------|Optimization Part|-------------------------
    iter = 1;
    cost = 1;
    counter = 0;
    prevCost = 0;
    initialsVar = [inputs.thrtl; inputs.ele; inputs.alpha; ... 
        inputs.ail; inputs.rud; inputs.beta];
    while iter == 1 && counter <= 5
        OPTIONS = optimset('TolFun', 1e-10, 'TolX', 1e-10, ... 
            'MaxFunEvals', 5e+04, 'MaxIter', 1e+04);
        [inputs, ~, ~, ~] = fminsearch('getCostValues_Euler', ... 
            initialsVar, OPTIONS);
        [cost, states, controls] = getCostValues_Euler(inputs);
        counter = counter+1;
        if counter == 5 || prevCost == cost
            iter = 0;
        end % End of "Trim Iteration" If Condition.
        prevCost = cost;
        initialsVar = inputs;
    end % End of "Trim While Loop" While Condition.     
    % ---------------------------------------------------------------------
    %% -------------------|Final (Optimized) Parameters|-------------------
    outputs.trim.states = states;
    outputs.trim.controls = controls;
    outputs.cost = cost;
    % ---------------------------------------------------------------------
    %% -----------------------|Final Representation|-----------------------
    disp(['<strong>Cost = </strong>' ...
        num2str(outputs.cost)])
    disp(['<strong>Iteration Number = </strong>' ...
        num2str(counter)])
    disp(['<strong>Throttle = </strong>' ...
        num2str(outputs.trim.controls.throttle) ' '])
    disp(['<strong>Elevator Deflection = </strong>' ...
        num2str(outputs.trim.controls.elevator) ' deg'])
    disp(['<strong>Aileron Deflection = </strong>' ...
        num2str(outputs.trim.controls.aileron) ' deg'])
    disp(['<strong>Rudder Deflection = </strong>' ...
        num2str(outputs.trim.controls.rudder) ' deg'])
    disp(['<strong>Leadig Edge Flap Deflection = </strong>' ...
        num2str(outputs.trim.controls.lef) ' deg'])
    disp(['<strong>Speed Breaker Deflection = </strong>' ...
        num2str(outputs.trim.controls.sb) ' deg']);
    disp(['<strong>Angle of Attack = </strong>' ...
        num2str(rad2deg(outputs.trim.states.alpha)) ' deg'])
    disp(['<strong>Angle of Sideslip = </strong>' ...
        num2str(rad2deg(outputs.trim.states.beta)) ' deg'])
    disp(['<strong>True Airspeed = </strong>' ...
        num2str(outputs.trim.states.tas) 'ft/s']) 
end % End of "F-16's Trim Values" Function.