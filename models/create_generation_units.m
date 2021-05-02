function generation_units = create_generation_units(input_path, market_region)
%CREATE_GENERATION_UNITS
    input_generation_units = readtable(input_path);
    generation_units = generation_unit.empty;
    gen_unit = 1;
    for i = 1:size(input_generation_units,1)
        generation_units(gen_unit,1) = generation_unit(input_generation_units.id(gen_unit),input_generation_units.name(gen_unit),input_generation_units.type(gen_unit),input_generation_units.p_min(gen_unit),input_generation_units.p_max(gen_unit),input_generation_units.min_up_time(gen_unit),input_generation_units.min_down_time(gen_unit),input_generation_units.cost(gen_unit),market_region);
        gen_unit = gen_unit + 1;
    end
end

