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
    P = optimvar('p_gen',maxMR, maxGen, maxTime, 'Type','continuous', 'LowerBound',0.);% ToDo
    
    P_Import = optimvar('p_import', maxMR, maxGen, maxTime, 'Type','continuous', 'LowerBound',0.);% ToDo
    P_Export = optimvar('p_export', maxMR, maxGen, maxTime, 'Type','continuous', 'LowerBound',0.);% ToDo
    
    % generation bounds
	% ToDo
    for mr=1:maxMR
        for g=1:maxGen
            for t=1:maxTime
                P.UpperBound(mr,g,t) = generation_units(g,mr).p_max;
            end 
        end
    end
    
    % transfer bounds
	% ToDo
    for mr=1:maxMR
        for g=1:maxGen
            for t=1:maxTime
                P_Import.UpperBound(mr,g,t) = input_transfer_capacities(g,mr).p_import_max;
                P_Export.UpperBound(mr,g,t) = input_transfer_capacities(g,mr).p_export_max;
            end
        end
    end
     
    % Create objective
    obj_expr = optimexpr(1);
    
    for mr = 1:maxMR
       for t = 1:maxTime
            for g = 1:maxGen
                obj_expr = obj_expr + P(mr,g,t)*generation_units(g,mr).cost; % ToDo
            end
                obj_expr = obj_expr - P_Export*input_transfer_cost(mr).c_export - P_Import*input_transfer_cost(mr).c_import; %  ToDo
        end
    end

    prob.Objective = obj_expr(mr); 
    
    % Create constraints
    
    % load series manipulation
    for mr=1:maxMR
        for t = 1:maxTime
        load_series(t,mr).p = load_series(t,mr).p - renewables_series(t,mr).p_total;
        end
    end 

    % load coverage
	% ToDo
    P_t_total = sum(P); % create vector containing the sum of P_g in each row for different time points
    prob.Constraints.load_coverage = optimconstr(maxTime);

	for j = 1:maxTime
      prob.Constraints.load_coverage(j) = P_t_total(1,j) == load_series(j).p; 
    end
    
    % import/export balancing
	% ToDo
    
end
