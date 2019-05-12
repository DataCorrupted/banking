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
        
        function [resStr, customer] = logIn(this, uid, password)
           [resStr, customer] = this.customerSystem.logIn(uid, password);
        end
        
        % We are assuming that the account always exist;
        function aid = getAccount(this, aid)
            aid = this.accountSystem.getAccount(aid); 
        end
    end
end

