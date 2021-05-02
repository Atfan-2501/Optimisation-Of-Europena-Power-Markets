function prob = create_model_task_1_2(generation_units, load_series, input_transfer_cost, input_transfer_capacities, renewables_series)
%CREATE_MODEL_TASK_1_2 Create model for task 1.2
%   Create optimization model for task 1.2 (Unit Commitment Problem with
%   Market Coupling) using MATLAB optimiproblem and return problem
%   (c) IAEW, RWTH Aachen University, 2020

    % Help parameters
    maxTime = length(load_series); % number of time steps
    maxGen = length(generation_units); % number of generation units
    maxMR = 2; % number of market regions
    
    % Create problem
    prob = optimproblem('Description','Task 1.2','ObjectiveSense','minimize');

    % Create decision variables
    P = optimvar('p_gen',% ToDo
    
    P_Import = optimvar('p_import',% ToDo
    P_Export = optimvar('p_export',% ToDo
    
    % generation bounds
	% ToDo
    
    % transfer bounds
	% ToDo
     
    % Create objective
    obj_expr = optimexpr(1);
    
    for mr = 1:maxMR
       for t = 1:maxTime
            for g = 1:maxGen
                % ToDo
            end
            % ToDo
        end
    end

    prob.Objective = obj_expr; 
    
    % Create constraints
    
    % load coverage
	% ToDo
    
    % import/export balancing
	% ToDo
    
end
