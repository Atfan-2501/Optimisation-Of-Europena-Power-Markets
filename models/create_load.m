function load_series = create_load(input_path, market_region)
%CREATE_LOAD
    input_load = readtable(input_path, "Delimiter", ";");
    load_series = loads.empty;
    for time_step = 1:size(input_load,1)
        load_series(time_step,1) = loads(time_step,input_load.DALoadForecast(time_step),market_region);
    end
end
