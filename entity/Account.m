classdef Account < Entity  
    properties (Access = private)
        remains
    end
    
    methods (Access = public)
        
        function this = Account(aid, password)
            this@Entity(aid, password)
            this.remains = 0;
        end

        function [this, status] = transferTo(this, destAccount, amount)
            if (amount < 0)
                status = Status.InvalidAmount;  return;
            end
            if (this.remains < amount)
                status = Status.Insufficient;      return;
            end
            status = Status.Successful;
            this.remains = this.remains - amount;
            destAccount.deposit(amount);
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
                status = Status.Insufficient;   return;
            end
            if (amount < 0)
                status = Status.InvalidAmount;  return;
            end
            status = Status.Successful;
            this.remains = this.remains - amount;
        end
    end
end

