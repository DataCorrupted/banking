classdef (Abstract) Customer < handle
    %Customer Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        uid
        name
        password
        accounts
    end
    
    methods (Access = protected)
        function this = Customer(uid, password, name)
            this.uid = uid;
            this.name = name;
            this.password = password;
            this.accounts = [];
        end      
    end
    
    methods (Access = public)
        function uid = getUid(this)
            uid = this.uid;
        end
        function this = addAccount(this, account)
            this.accounts = [this.accounts; account];
        end
        function isMatch = passwordMatch(this, password)
            isMatch = strcmp(this.password, password);
        end
        function name = getName(this)
            name = this.name;
        end
        function accounts = getAccounts(this)
            accounts = this.accounts;
        end
        function accountNum = getAccountNum(this)
            accountNum = this.accountNum;
        end
    end
    
end

