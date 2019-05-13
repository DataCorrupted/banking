classdef Customer < Entity
    %Customer Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        name
        accounts
    end
    
    methods (Access = public)
        function this = Customer(name, password, uid)
            this@Entity(uid, password);
            this.name = name;
            this.accounts = [];
        end      
    end
    
    methods (Access = public)
        function uid = getUid(this)
            uid = this.getId();
        end
        function this = addAccount(this, account)
            this.accounts = [this.accounts; account];
        end

        function name = getName(this)
            name = this.name;
        end
        function accounts = getAccounts(this)
            accounts = this.accounts;
        end
        function accountNum = getAccountNum(this)
            [accountNum, ~] = size(this.accounts);
        end
    end
    
end

