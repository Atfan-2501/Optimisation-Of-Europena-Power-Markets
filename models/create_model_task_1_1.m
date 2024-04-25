function prob = create_model_task_1_1(generation_units, load_series, renewables_series)
%CREATE_MODEL_TASK_1_1 Create model for task 1.1
%   Create optimization model for task 1.1 (Unit Commitment Problem with
%   Renewables as Linear Program) using MATLAB optimiproblem and
%   return problem
%   (c) IAEW, RWTH Aachen University, 2020

    % Help parameters
    maxTime = length(load_series);
    maxGen = length(generation_units);

    % Create problem
    prob = optimproblem('Description','Task 1.1','ObjectiveSense','minimize');

    % Create decision variables
    P = optimvar('p_gen', maxGen, maxTime,'Type','continuous','Lowerbound',0.);
     
    % generation bounds
	for i=1:maxGen
        for j=1:maxTime
            P.UpperBound(i,j) = generation_units(i).p_max;  %find a way to call p_max from the individual generation units
        end 
    end
    
    % Create objective
    obj_expr = optimexpr(1);
    for g = 1:maxGen
        for t = 1:maxTime
			obj_expr = obj_expr + P(g,t)*generation_units(g).cost; %find a way to call the cost
        end
    end
    prob.Objective = obj_expr;

    % Create constraints
    % load series manipulation
    for i = 1:maxTime
        load_series(i).p = load_series(i).p - renewables_series(i).p_total;
    end

    % load coverage
	P_t_total = sum(P); % create vector containing the sum of P_g in each row for different time points
    prob.Constraints.load_coverage = optimconstr(maxTime);

	for j = 1:maxTime
      prob.Constraints.load_coverage(j) = P_t_total(1,j) == load_series(j).p; 
    end

end
