classdef Account
    %ACCOUNT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        challengeList
        accountNo
        
        remains
    end
    
    methods (Access = public)
        
        function this = Account(accountNo, challengeList)
            this.accountNo = accountNo;
            % By default we allow transfer password.
            this.challengeList = challengeList;
            
            this.remains = 0;
        end

        function [this, status] = transferTo(this, destAccount, amount)
            if (amount < 0)
                status = Status.InvalidAmount;  return;
            end
            if (this.remains < amount)
                status = Status.Insuffice;      return;
            end
            
            this.remains = this.remains - amount;
            destAccount.remains = destAccount.deposit(amount);
        end
        
        function remains = query(this)
            remains = this.remains;
        end
        
        function [this, status] = deposit(this, amount)
            if (amount < 0)
                status = Status.InvalidAmount;  return;
            end
            this.remains = this.remains + amount;
            status = Status.Successful;
        end
        
        function [this, status] = withdraw(this, amount)
            if (amount > this.remains)
                status = Status.Insuffice;  return;
            end
            this.remains = this.remains - amount;
        end
    end
end

