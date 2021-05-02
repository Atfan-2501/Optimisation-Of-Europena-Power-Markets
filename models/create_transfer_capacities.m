function transfer_capacities = create_transfer_capacities(input_path, market_region)
%CREATE_CAPACITIES
    input_capacities = readtable(input_path, "Delimiter", ";");
    transfer_capacities_1 = capacities.empty;
    transfer_capacities_2 = capacities.empty;
    for time_step = 1:size(input_capacities,1)
        transfer_capacities_1(time_step,1) = capacities(time_step,input_capacities.DE_LU_BE(time_step),input_capacities.BE_DE_LU(time_step),market_region);
        transfer_capacities_2(time_step,1) = capacities(time_step,input_capacities.BE_DE_LU(time_step),input_capacities.DE_LU_BE(time_step),market_region);
    end
    
    transfer_capacities = [transfer_capacities_1, transfer_capacities_2];
end