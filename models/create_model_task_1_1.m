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
    P = optimvar('p_gen',% ToDo
     
    % generation bounds
	% ToDo
    
    % Create objective
    obj_expr = optimexpr(1);
    for g = 1:maxGen
        for t = 1:maxTime
			% ToDo
        end
    end
    prob.Objective = obj_expr;

    % Create constraints

    % load coverage
	P_t_total = sum(P); % create vector containing the sum of P_g in each row for different time points
    prob.Constraints.load_coverage = optimconstr(maxTime);
	% ToDo

end
