classdef CustomerSystem < EntitySystem

    methods (Access = public)
        function this = CustomerSystem(customers)
            this@EntitySystem(customers);
        end
        function this = addCustomer(this, customer)
            this.addEntity(customer);
        end
    end

end

