classdef generation_unit
    %GENERATION_UNIT
    
    properties
        id
        name
        type
        p_min % MW
        p_max % MW
        min_up_time % h
        min_down_time % h
        cost % EUR/MWh        
        market_region
    end
    
    methods
        function obj = generation_unit(id_,name_,type_,p_min_,p_max_,min_up_time_,min_down_time_,cost_,market_region_)
            % generation_unit
            obj.id = id_;
            obj.name = name_;
            obj.type = type_;
            obj.p_min = p_min_;
            obj.p_max = p_max_;
            obj.min_up_time = min_up_time_;
            obj.min_down_time = min_down_time_;
            obj.cost = cost_;
            obj.market_region = market_region_;
        end
    end
end

