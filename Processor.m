classdef Processor
    %PROCESSOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        accountSystem
        customerSystem
    end
    
    methods
        function this = Processor(accountSystem, customerSystem)
            this.accountSystem = accountSystem;
            this.customerSystem = customerSystem;
        end
        
    end
end

