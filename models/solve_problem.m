function solve_problem(problem)
%SOLVE_PROBLEM

    % Solve problem
    options = optimoptions('intlinprog');
    solve(problem, 'options', options);

end

