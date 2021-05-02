function problem2mps(problem)
%PROBLEM2MPS
%   Converts MATLAB optim problem to gurobi model and writes mps file

problem_struct = prob2struct(problem);
% Variablennamen ausgeben
idx = varindex(problem);
temp=1;
fields=fieldnames(idx);
for categoryidx=1:length(fields)
    categoryname=fields{categoryidx};
    %fprintf('%s\n',categoryname);
    for i=1:length(idx.(categoryname))
        %fprintf('%d\n',idx.(categoryname)(i));
        model.varnames{temp}=sprintf('%s_%d',categoryname,idx.(categoryname)(i));
        temp=temp+1;
    end
end
    
% Build Gurobi model
%model.constrnames=problem.constraintNames;
model.obj = problem_struct.f;
model.A = problem_struct.Aeq; % A must be sparse
%Variablentyp ausgeben
if ~isempty(problem_struct.intcon)
    n = size(model.A, 2);   
    model.vtype = repmat('C', n, 1);
    model.vtype((problem_struct.intcon))='B';
end
model.sense = repmat('=',size(problem_struct.Aeq,1),1);
model.rhs = full(problem_struct.beq(:)); % rhs must be dense
%Constraintnames ausgeben
temp=1;
fields=fieldnames(problem.Constraints);
for categoryidx=1:length(fields)
    categoryname=fields{categoryidx};
    %fprintf('%s\n',categoryname);
    for i=1:length(problem.Constraints.(categoryname))
        %fprintf('%d\n',(i));
        model.constnames{temp}=sprintf('%s_%d',categoryname,(i));
        temp=temp+1;
    end
end
if ~isempty(problem_struct.lb)
    model.lb = problem_struct.lb;
else
    model.lb = -inf(size(model.A,2),1); % default lb for MATLAB is -inf
end
if ~isempty(problem_struct.ub)
    model.ub = problem_struct.ub;
end

gurobi_write(model, 'model.lp');
gurobi_write(model, 'model.mps');

end

