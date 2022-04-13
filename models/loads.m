classdef loads
    %LOADS
    
    properties
        time_step
        p
        market_region
    end
    
    methods
        function obj = loads(time_step_,p_,market_region_)
            % loads
            obj.time_step = time_step_;
            obj.p = p_;
            obj.market_region = market_region_;
        end
    end
end

