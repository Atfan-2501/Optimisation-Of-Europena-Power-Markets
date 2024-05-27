%% Main script for Unit Commitment Problem Modeling

% Comment: Before running this main script, the folders "models" and
% "input_data" have to be added to the matlab path, see: 
% https://de.mathworks.com/help/matlab/matlab_env/add-remove-or-reorder-folders-on-the-search-path.html

addpath("C:/gurobi1102/win64/matlab")
addpath("C:/gurobi1102/win64/examples/matlab")

% Read input data
loads_BE = create_load("input_data/Input_Load_BE.csv", "BE");
loads_DE_LU = create_load("input_data/Input_Load_DE-LU.csv", "DE-LU");
generation_units_BE = create_generation_units("input_data/Input_Generation_BE.csv", "BE");
generation_units_DE_LU = create_generation_units("input_data/Input_Generation_DE-LU.csv", "DE-LU");
renewables_BE = create_renewables("input_data/Input_Renewables_BE.csv", "BE");
renewables_DE_LU = create_renewables("input_data/Input_Renewables_DE-LU.csv", "DE-LU");
transfer_cost = create_transfer_cost("input_data/Input_Transfer_Cost_DE-LU_BE.csv", "DE-LU_BE");
transfer_capacities = create_transfer_capacities("input_data/Input_Transfer_Capacities_DE-LU_BE.csv", "DE-LU_BE");

% Example: This is an example model to show some Matlab optimization
% basics, optimal objective value should be 57
%problem = create_model_example();

% Task 1.1: Unit Commitment Problem with Renewables as Linear Program
% problem = create_model_task_1_1(generation_units_DE_LU, loads_DE_LU, renewables_DE_LU); % comment/uncomment according to your needs

% Task 1.2: Unit Commitment Problem with Market Coupling
% generation_units = [generation_units_DE_LU, generation_units_BE];
% loads = [loads_DE_LU, loads_BE];
% renewables = [renewables_DE_LU, renewables_BE];
% problem = create_model_task_1_2(generation_units, loads, transfer_cost, transfer_capacities, renewables); % comment/uncomment according to your needs

% Task 2.1: Unit Commitment Problem with Constraints as Mixed Integer Linear Program
% generation_units = [generation_units_DE_LU, generation_units_BE];
% loads = [loads_DE_LU, loads_BE];
% renewables = [renewables_DE_LU, renewables_BE];
% problem = create_model_task_2_1(generation_units, loads, transfer_cost, transfer_capacities, renewables); % comment/uncomment according to your needs

% Task 2.2: Unit Commitment Problem with positive Control Reserve
generation_units = [generation_units_DE_LU, generation_units_BE];
loads = [loads_DE_LU, loads_BE];
renewables = [renewables_DE_LU, renewables_BE];
problem = create_model_task_2_2(generation_units, loads, transfer_cost, transfer_capacities, renewables); % comment/uncomment according to your needs

% Write MPS and solve problem
problem2mps(problem);
solve_problem(problem);
