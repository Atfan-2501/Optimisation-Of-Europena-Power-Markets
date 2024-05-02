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
    P = optimvar('p_gen',maxGen, maxTime, maxMR, 'Type','continuous', 'LowerBound',0.);% ToDo
    
    P_Import = optimvar('p_import', maxTime, maxMR, 'Type','continuous', 'LowerBound',0.);% ToDo
    P_Export = optimvar('p_export', maxTime, maxMR, 'Type','continuous', 'LowerBound',0.);% ToDo
    
    % generation bounds
	% ToDo
    for mr=1:maxMR
        for g=1:maxGen
            for t=1:maxTime
                P.UpperBound(g, t, mr) = generation_units(g, mr).p_max;
            end 
        end
    end
    
    % transfer bounds
	% ToDo
    for mr=1:maxMR
       for t=1:maxTime
            P_Import.UpperBound(t, mr) = input_transfer_capacities(t,mr).p_import_max;
            P_Export.UpperBound(t, mr) = input_transfer_capacities(t,mr).p_export_max;
       end
    end
     
    % Create objective
    obj_expr = optimexpr(1);
    
    for mr = 1:maxMR
       for t = 1:maxTime
            for g = 1:maxGen
                obj_expr = obj_expr + (P(g,t,mr)*generation_units(g,mr).cost); % ToDo
            end
            obj_expr = obj_expr + (P_Export(t, mr)*input_transfer_cost(1, mr).c_export) + (P_Import(t, mr)*input_transfer_cost(1, mr).c_import); %  ToDo
       end
    end

    prob.Objective = obj_expr;
    
    % Create constraints
    
    % load series manipulation
    for mr=1:maxMR
        for t = 1:maxTime
            load_series(t,mr).p = load_series(t,mr).p - renewables_series(t,mr).p_total;
        end
    end 

    % load coverage
	% ToDo
    P_t_total = sum(P,1); % create vector containing the sum of P_g in each row for different time points
    prob.Constraints.load_coverage = optimconstr([maxTime, maxMR]);

    for mr=1:maxMR
	    for t=1:maxTime
            prob.Constraints.load_coverage(t, mr) = P_t_total(1,t,mr) + P_Import(t, mr) - P_Export(t, mr)== load_series(t, mr).p; 
        end
    end
     
    % import/export balancing
	% ToDo

    prob.Constraints.importBalancing = optimconstr([maxTime, maxMR]);

    for mr = 1:maxMR
        for t = 1:maxTime
            prob.Constraints.importBalancing(t, mr) = P_t_total(1,t,mr) == load_series(t, mr).p + P_Export(t, mr) - P_Import(t, mr);
        end
    end
    
end
