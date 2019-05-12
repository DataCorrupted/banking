classdef AccountSystem
    %ACCOUNTSYSTEM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        accounts
        accountNum
    end
    
    methods (Access = public)
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

        function k = getAccountIdx(this, uid)
            for i = 1:this.customerNum
                if (this.accounts(i).getUid() == uid)            
                    k = i;
                    return
                end
            end
            k = 0;  % Failed. Such customer doesn't exist.
        end
        function isValid = isValidAccount(this, uid)
            isValid = (this.getAccountIdx(uid) ~= 0);
        end
        function customer = getAccount(this, uid)
            idx = this.getAccountIdx(uid);
            if (idx == 0)
                return
            end
            customer = this.accounts(idx);
        end
    end
end

