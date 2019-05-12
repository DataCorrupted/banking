classdef AccountSystem
    %ACCOUNTSYSTEM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        accounts
        accountNum
    end
    
    methods (Access = public)
        function this = AccountSystem(accounts)
            this.accounts = accounts;
            [this.accountNum, ~] = size(accounts);
        end
        function this = addAccount(this, customer)
            this.accounts = [this.accounts; customer];
            this.customerNum = this.customerNum + 1;
        end
        function [this, status] = deleteAccount(this, uid)
            i = this.getCustomerIdx(uid);
            if (i == 0)
                status = Status.InvalidAccount;
                return;
            end
            if (i == 1)
                this.accounts = this.accounts(2:this.customerNum);
            else
            if (i == this.customerNum)
                this.accounts = this.accounts(1:this.customerNum - 1);
            else
                this.accounts = [this.accounts(1:i-1); 
                             this.accounts(i+1:this.customerNum)];
            end
            end
            status = Status.Successful;
            this.customerNum = this.customerNum - 1;
        end

        function k = getAccountIdx(this, account)
            for i = 1:this.customerNum
                if (strcmp(this.accounts(i).getAid(), account))
                    k = i;
                    return
                end
            end
            k = 0;  % Failed. Such account doesn't exist.
        end
        function isValid = isValidAccount(this, aid)
            isValid = (this.getAccountIdx(aid) ~= 0);
        end
        function customer = getAccount(this, aid)
            idx = this.getAccountIdx(aid);
            if (idx == 0)
                return
            end
            customer = this.accounts(idx);
        end
    end
end

