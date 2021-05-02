function transfer_costs = create_transfer_cost(input_path, market_region)
%CREATE_TRANSFER_COSTS
    input_transfer_costs = readtable(input_path, "Delimiter", ";");
    transfer_costs = transfercosts.empty;
    
    transfer_costs(1) = transfercosts(input_transfer_costs.DE_LU_BE(1),input_transfer_costs.BE_DE_LU(1),market_region);%costs for mr 1
    transfer_costs(2) = transfercosts(input_transfer_costs.BE_DE_LU(1),input_transfer_costs.DE_LU_BE(1),market_region);%costs for mr 2, for example import1=export2

end
