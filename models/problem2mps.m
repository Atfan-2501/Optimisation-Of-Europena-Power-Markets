function problem2mps(problem)
%PROBLEM2MPS
%   Converts MATLAB optim problem to gurobi model and writes mps file
problem_struct = prob2struct(problem);
[f,intcon,A,b,Aeq,beq,lb,ub,x0,options] = probstruct2args(problem_struct);
    
% Build Gurobi model
model.obj = f;
model.A = [sparse(A); sparse(Aeq)]; % A must be sparse
n = size(model.A, 2);
model.vtype = repmat('C', n, 1);
model.vtype(intcon) = 'I';
model.sense = [repmat('<',size(A,1),1); repmat('=',size(Aeq,1),1)];
model.rhs = full([b(:); beq(:)]); % rhs must be dense
if ~isempty(x0)
    model.start = x0;
end
if ~isempty(lb)
    model.lb = lb;
else
    model.lb = -inf(n,1); % default lb for MATLAB is -inf
end
if ~isempty(ub)
    model.ub = ub;
end

% Variablennamen ausgeben
% idx = varindex(problem);
% temp=1;
% fields=fieldnames(idx);
% for categoryidx=1:length(fields)
%     categoryname=fields{categoryidx};
%     %fprintf('%s\n',categoryname);
%     for i=1:length(idx.(categoryname))
%         %fprintf('%d\n',idx.(categoryname)(i));
%         model.varnames{temp}=sprintf('%s_%d',categoryname,idx.(categoryname)(i));
%         temp=temp+1;
%     end
% end
%Constraintnames ausgeben
% temp=1;
% fields=fieldnames(problem.Constraints);
% for categoryidx=1:length(fields)
%     categoryname=fields{categoryidx};
%     %fprintf('%s\n',categoryname);
%     if size(size(problem.Constraints.(categoryname))) ~= 3
%         for i=1:length(problem.Constraints.(categoryname))
%             %fprintf('%d\n',(i));
% %             model.constrnames{temp}=sprintf('%s_%d',categoryname,(i));
%             temp=temp+1;
%         end
%     end
% end

gurobi_write(model, strcat(problem.Description,'.lp'));
gurobi_write(model, strcat(problem.Description,'.mps'));

end

% Local Functions =========================================================

function [f,intcon,A,b,Aeq,beq,lb,ub,x0,options] = probstruct2args(s)
%PROBSTRUCT2ARGS Get problem structure fields ([] is returned when missing)

f = getstructfield(s,'f');
intcon = getstructfield(s,'intcon');
A = getstructfield(s,'Aineq');
b = getstructfield(s,'bineq');
Aeq = getstructfield(s,'Aeq');
beq = getstructfield(s,'beq');
lb = getstructfield(s,'lb');
ub = getstructfield(s,'ub');
x0 = getstructfield(s,'x0');
options = getstructfield(s,'options');
end

function f = getstructfield(s,field)
%GETSTRUCTFIELD Get structure field ([] is returned when missing)

if isfield(s,field)
    f = getfield(s,field);
else
    f = [];
end
end
