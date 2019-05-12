classdef BusinessCustomer < Customer
    %BUSINESSCUSTOMER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        taxNo
    end
    
    methods (Access = public)
        
        function this = BusinessCustomer(name, password, uid, taxNo)
            this@Customer(uid, password, name);
            this.taxNo = taxNo;
        end
        
    end
    
end

