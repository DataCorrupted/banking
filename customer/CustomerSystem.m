classdef CustomerSystem < EntitySystem

    properties (Constant)
        uIdLen = 18;
    end
    
    methods (Access = public)
        function this = CustomerSystem(customers)
            this@EntitySystem(customers);
        end
        function this = addCustomer(this, customer)
            this.addEntity(customer);
        end
        function [this, customer] = newCustomer(this, name, password, uid)
            customer = Customer(name, password, uid);
            this.addCustomer(customer);
        end
        function uIdLen = getUIdLen(this)
            uIdLen = this.uIdLen;
        end
        function customer = getCustomer(this, uid)
            customer = this.getEntity(uid);
        end
    end

end

