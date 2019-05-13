classdef CustomerSystem < EntitySystem

    properties (Constant)
        uIdLen = 15;
    end
    
    methods (Access = public)
        function this = CustomerSystem(customers)
            this@EntitySystem(customers);
        end
        function this = addCustomer(this, customer)
            this.addEntity(customer);
        end
        function [this, customer] = newCustoemr(this, name, password)
            customer = Customer(name, password, this.newId(this.uIdLen));
            this.addCustomer(customer);
        end
    end

end

