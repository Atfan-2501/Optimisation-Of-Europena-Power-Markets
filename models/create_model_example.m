function prob = create_model_example()
%CREATE_MODEL_EXAMPLE Create model for example
%   Create optimization model for example
%   using MATLAB optimiproblem and return problem
%   (c) IAEW, RWTH Aachen University, 2020

    % Help parameters
    numVar1 = 2;
    numVar2 = 3;

    % Create problem
    prob = optimproblem('Description','Example','ObjectiveSense','maximize');

    % Create decision variables
    X = optimvar('example_variables',numVar1,numVar2,'Type','continuous','Lowerbound',0.);
     
    % Upper bounds
    for i=1:numVar1
        for j=1:numVar2
            X.UpperBound(i,j) = i+j;
        end 
    end
    
    % Create objective
    obj_expr = optimexpr(1);
    for i = 1:numVar1
        for j = 1:numVar2
            obj_expr = obj_expr + (i+j) * X;
        end
    end
    prob.Objective = obj_expr;

    % Create constraints

    % example constraints
    prob.Constraints.example_constraint = optimconstr(numVar2);
    for j = 1:numVar2
        prob.Constraints.example_constraint(j) = X(1,j) + X(2,j) == 5; 
    end

end

