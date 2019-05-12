classdef AccountSystem < EntitySystem

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
    end

end

