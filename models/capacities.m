classdef capacities
    %Capacities    
    properties
        time_step
        p_import_max
        p_export_max
        market_region
    end
    
    methods
        function obj = capacities(time_step_,market12_, market21_,market_region_)
            %Capacities
            obj.time_step = time_step_;
            obj.p_import_max = market12_;
            obj.p_export_max = market21_;
            obj.market_region = market_region_;
            return
        end
    end
end