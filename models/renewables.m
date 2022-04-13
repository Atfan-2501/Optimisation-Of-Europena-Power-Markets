classdef renewables
    %RENEWABLES
    
    properties
        time_step
        p_total
        p_wind_onshore
        p_wind_offshore
        p_solar
        p_biomass
        p_hydro
        p_waste
        market_region
    end
    
    methods
        function obj = renewables(time_step_,p_wind_onshore_,p_wind_offshore_,p_solar_,p_biomass_,p_hydro_,p_waste_,market_region_)
            % renewables
            obj.time_step = time_step_;
            obj.p_total = p_wind_onshore_ + p_wind_offshore_ + p_solar_ + p_biomass_ + p_hydro_ + p_waste_;
            obj.p_wind_onshore = p_wind_onshore_;
            obj.p_wind_offshore = p_wind_offshore_;
            obj.p_solar = p_solar_;
            obj.p_biomass = p_biomass_;
            obj.p_hydro = p_hydro_;
            obj.p_waste = p_waste_;
            obj.market_region = market_region_;
        end
    end
end

