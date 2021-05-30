function prob = create_model_task_2_1(generation_units, load_series, input_transfer_cost, input_transfer_capacities, renewables_series)
%CREATE_MODEL_TASK_2_1 Create model for task 2.1
%   Create optimization model for task 2.1 (Unit Commitment Problem with 
%   Constraints as Mixed Integer Linear Program) using MATLAB optimiproblem
%   and return problem
%   (c) IAEW, RWTH Aachen University, 2020

    % Help parameters
    maxTime = length(load_series); % number of time steps
    maxGen = length(generation_units); % number of generation units
    maxMR = 2; % number of market regions

    % Create problem
    prob = optimproblem('Description','Task 2.1','ObjectiveSense','minimize');

    % Create decision variables
    P = optimvar('p_gen',% ToDo
    P_binary = optimvar('p_gen_binary',% ToDo
    
    P_Import = optimvar('p_import',% ToDo
    P_Export = optimvar('p_export',% ToDo

    % generation bounds as constraints due to coupling (see below)
    
    % transfer bounds
    % ToDo

    % Create objective
    obj_expr = optimexpr(1);

    % ToDo

    prob.Objective = obj_expr; 

    % Create constraints
    
    % load coverage
    % ToDo
    
    % import/export balancing
    % ToDo
    
    % generation bounds and coupling
    prob.Constraints.P_lowerbound = optimconstr(maxGen,maxTime,maxMR);
    prob.Constraints.P_upperbound = optimconstr(maxGen,maxTime,maxMR);
    % ToDo
         
    % operational constraints
    prob.Constraints.min_up_time_1 = optimconstr(maxGen,maxTime,maxMR); % minimum up time 1: subsequent periods up during all possible sets of consecutive periods
    prob.Constraints.min_up_time_2 = optimconstr(maxGen,maxTime,maxMR); % minimum up time 2: keep unit up for final periods if it is started up
    
    prob.Constraints.min_down_time_1 = optimconstr(maxGen,maxTime,maxMR); % minimum down time 1: subsequent periods down during all possible sets of consecutive periods
    prob.Constraints.min_down_time_2 = optimconstr(maxGen,maxTime,maxMR); % minimum down time 2: keep unit down for final periods if it is started down
    
    for g = 1:maxGen
        for mr = 1:maxMR
            % Minimum Up Times
            % ToDo
            
            % Minimum Down Times
            % ToDo
        end
    end
    
end