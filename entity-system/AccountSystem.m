classdef AccountSystem < EntitySystem

    properties (Constant)
        aIdLen = 16;
    end
    methods (Access = public)
        function this = AccountSystem(accounts)
            this@EntitySystem(accounts);
        end
        
        function this = addAccount(this, account)
            this.addEntity(account);
        end
        function account = getAccount(this, aid)
            account = this.getEntity(aid);
        end
        function [this, account] = newAccount(this, customer, password)
            account = Account(this.newId(this.aIdLen), password);
            this.addAccount(account);
            customer.addAccount(account.getId());
        end
        function isExisting = isExisting(this, aid)
            isExisting = this.isTaken(aid);
        end
    end

end

