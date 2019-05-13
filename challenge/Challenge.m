classdef Challenge
    %CHALLENGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        name
        secret
    end
    
    methods (Abstract)
        challenge(this)
    end
    
    methods (Access = protected)
        function this = Authorize(name)
            this.name = name;
        end
    end
end

