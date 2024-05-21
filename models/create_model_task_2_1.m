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
    P = optimvar('p_gen', maxGen, maxTime, maxMR, 'Type','continuous', 'LowerBound',0.);
    P_binary = optimvar('p_gen_binary', maxGen, maxTime, maxMR, 'Type', 'integer','LowerBound',0,'UpperBound',1);
    
    P_Import = optimvar('p_import', maxTime, maxMR, 'Type','continuous', 'LowerBound',0.);
    P_Export = optimvar('p_export', maxTime, maxMR, 'Type','continuous', 'LowerBound',0.);


    % generation bounds as constraints due to coupling (see below)

    % transfer bounds
    % copied from task 1.2

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
                obj_expr = obj_expr + P(g,t,mr) * generation_units(g,mr).cost; % ToDo
            end
            obj_expr = obj_expr + P_Export(t, mr) * input_transfer_cost(1, mr).c_export + P_Import(t, mr) * input_transfer_cost(1, mr).c_import; %  ToDo
       end
    end


    prob.Objective = obj_expr; 

    % Create constraints
    % load series manipulation should be required according to task, but is not asked here explicitly. I am putting it here anyway, if there is anything wrong with the result we can remove it.
    
    for mr=1:maxMR
        for t = 1:maxTime
            load_series(t,mr).p = load_series(t,mr).p - renewables_series(t,mr).p_total;
        end
    end 


    % load coverage
    % TODO: _t_total needs to be updated to include P_binary.
    P_t_total = sum(P,1); % create vector containing the sum of P_g in each row for different time points

    prob.Constraints.load_coverage = optimconstr([maxTime, maxMR]);

    for mr=1:maxMR
	    for t=1:maxTime
            prob.Constraints.load_coverage(t, mr) = P_t_total(1,t,mr) + P_Import(t, mr) - P_Export(t, mr) == load_series(t, mr).p; 
        end
    end
    
    % import/export balancing
    % copied from task 1.2, update for better version presented in lecture
    prob.Constraints.importBalancing = optimconstr([maxTime, maxMR]);

    for t = 1:maxTime
        prob.Constraints.importBalancing(t, 1) = sum(P_Export(t, :)) == sum(P_Import(t, :));
    end

    
    % generation bounds and coupling
    prob.Constraints.P_lowerbound = optimconstr(maxGen,maxTime,maxMR);
    prob.Constraints.P_upperbound = optimconstr(maxGen,maxTime,maxMR);
    
    for mr = 1:maxMR
       for t = 1:maxTime
            for g = 1:maxGen
                prob.Constraints.P_lowerbound(g,t,mr) = P(g,t,mr) >= P_binary(g,t,mr) * generation_units(g,mr).p_min;
                prob.Constraints.P_upperbound(g,t,mr) = P(g,t,mr) <= P_binary(g,t,mr) * generation_units(g,mr).p_max;
            end
       end
    end
         
    % operational constraints
    prob.Constraints.min_up_time_1 = optimconstr(maxGen,maxTime,maxMR); % minimum up time 1: subsequent periods up during all possible sets of consecutive periods
    prob.Constraints.min_up_time_2 = optimconstr(maxGen,maxTime,maxMR); % minimum up time 2: keep unit up for final periods if it is started up
    
    prob.Constraints.min_down_time_1 = optimconstr(maxGen,maxTime,maxMR); % minimum down time 1: subsequent periods down during all possible sets of consecutive periods
    prob.Constraints.min_down_time_2 = optimconstr(maxGen,maxTime,maxMR); % minimum down time 2: keep unit down for final periods if it is started down
    
    for g = 1:maxGen
        for mr = 1:maxMR
            % Minimum Up Times
            for t = 1:(maxTime - generation_units(g,mr).min_up_time + 1)
                if t==1
                    prob.Constraints.min_up_time_1(g, t, mr) = sum(P_binary(g, t:t+generation_units(g,mr).min_up_time-1, mr)) >= generation_units(g,mr).min_up_time * P_binary(g, t, mr);
                else
                    prob.Constraints.min_up_time_1(g, t, mr) = sum(P_binary(g, t:t+generation_units(g,mr).min_up_time-1, mr)) >= generation_units(g,mr).min_up_time * (P_binary(g,t,mr)-P_binary(g,t-1,mr));
                end
            end
            
            % Final Constraint: Ensure unit stays on until the end if turned on
            for t = (maxTime - generation_units(g,mr).min_up_time + 2):maxTime
                prob.Constraints.min_up_time_2(g, t, mr) = sum(P_binary(g, t:maxTime, mr)) >= (maxTime - t + 1) * (P_binary(g,t,mr)-P_binary(g,t-1,mr));
            end
        end
    end

for g = 1:maxGen
    for mr = 1:maxMR
        % Minimum Down Times
        for t = 1:(maxTime - generation_units(g,mr).min_down_time + 1)
            if t==1
                prob.Constraints.min_down_time_1(g, t, mr) = sum(1 - P_binary(g, t:t+generation_units(g,mr).min_down_time-1, mr)) >= generation_units(g,mr).min_down_time * (1 - P_binary(g, t, mr));
            else
                prob.Constraints.min_down_time_1(g, t, mr) = sum(1 - P_binary(g, t:t+generation_units(g,mr).min_down_time-1, mr)) >= generation_units(g,mr).min_down_time * (P_binary(g,t-1,mr) - P_binary(g, t, mr));
            end
        end
        % Final Constraint: Ensure unit stays off until the end if turned off
        for t = (maxTime - generation_units(g,mr).min_down_time + 2):maxTime
            prob.Constraints.min_down_time_2(g, t, mr) = sum(1 - P_binary(g, t:maxTime, mr)) >= (maxTime - t + 1) * (P_binary(g,t-1,mr) - P_binary(g, t, mr));
        end
    end
end
end