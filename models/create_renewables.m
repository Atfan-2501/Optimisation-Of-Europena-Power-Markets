function renewables_series = create_renewables(input_path, market_region)
%CREATE_LOAD
    input_renewables = readtable(input_path, "Delimiter", ";");
    renewables_series = renewables.empty;
    for time_step = 1:size(input_renewables,1)
        p_wind_onshore = input_renewables.WindOnshore(time_step);
        p_wind_offshore = input_renewables.WindOffshore(time_step);
        p_solar = input_renewables.Solar(time_step);
        p_biomass = input_renewables.Biomass(time_step);
        p_hydro = input_renewables.Hydro(time_step);
        p_waste = input_renewables.Waste(time_step);
        renewables_series(time_step,1) = renewables(time_step,p_wind_onshore,p_wind_offshore,p_solar,p_biomass,p_hydro,p_waste,market_region);
    end
end

