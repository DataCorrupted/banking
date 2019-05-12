classdef CustomerSystem
    %CUSTOMERSYSTEM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        customers
        customerNum
    end
    
    methods (Access = public)
        function this = CustomerSystem(customers)
            %CUSTOMERSYSTEM Construct an instance of this class
            %   Detailed explanation goes here
            this.customers = customers;
            [this.customerNum, ~] = size(customers);
        end
        
        function this = addCustomer(this, customer)
            this.customers = [this.customers; customer];
            this.customerNum = this.customerNum + 1;
        end
        function [this, status] = deleteCustomer(this, uid)
            i = this.getCustomerIdx(uid);
            if (i == 0)
                status = Status.InvalidCustomer;
                return;
            end
            if (i == 1)
                this.customers = this.customers(2:this.customerNum);
            else
            if (i == this.customerNum)
                this.customers = this.customers(1:this.customerNum - 1);
            else
                this.customers = [this.customers(1:i-1); 
                             this.customers(i+1:this.customerNum)];
            end
            end
            status = Status.Successful;
            this.customerNum = this.customerNum - 1;
        end

        function k = getCustomerIdx(this, uid)
            for i = 1:this.customerNum
                if (this.customers(i).getUid() == uid)            
                    k = i;
                    return
                end
            end
            k = 0;  % Failed. Such customer doesn't exist.
        end
        function isValid = isValidCustomer(this, uid)
            isValid = (this.getCustomerIdx(uid) ~= 0);
        end
        function customer = getCustomer(this, uid)
            idx = this.getCustomerIdx(uid);
            if (idx == 0)
                return
            end
            customer = this.customers(idx);
        end
    end
end

