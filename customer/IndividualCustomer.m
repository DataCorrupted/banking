classdef IndividualCustomer < Customer
    %INDIVIDUALCUSTOMER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        ssn
    end
    
    methods (Access = public)
        function this = IndividualCustomer(uid, password, name, ssn)
            this@Customer(uid, name, password);
            this.ssn = ssn;
        end
    end
    
end

