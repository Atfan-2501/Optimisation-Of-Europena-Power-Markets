classdef transfercosts
    %TRANSFERCOSTS
    
    properties
        c_import
        c_export
        market_region
    end
    
    methods
        function obj = transfercosts(market12_, market21_,market_region_)
            % transfercosts
            obj.c_import = market12_;
            obj.c_export = market21_;
            obj.market_region = market_region_;
        end
    end
end