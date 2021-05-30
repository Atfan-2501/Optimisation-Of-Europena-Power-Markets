function prob = create_model_task_2_2(generation_units, load_series, input_transfer_cost, input_transfer_capacities, renewables_series)
%CREATE_MODEL_TASK_2_2 Create model for task 2.2
%   Create optimization model for task 2.2 (Unit Commitment Problem with 
%   Positive Control Reserve) using MATLAB optimiproblem and return problem
%   (c) IAEW, RWTH Aachen University, 2020

    % Help parameters
    maxTime = length(load_series); % number of time steps
    maxGen = length(generation_units); % number of generation units
    maxMR = 2; % number of market regions
    P_ControlReserve_total = 832; % total control reserve within each time step in coupled market region [MW]

    % Create problem
    prob = optimproblem('Description','Task 2.2','ObjectiveSense','minimize');

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
    % ToDo
    
    % operational constraints
    % ToDo
    
    % control reserve
    prob.Constraints.controlreserve = optimconstr(maxTime); % control reserve
    % ToDo
    
end