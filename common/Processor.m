classdef Processor
    %PROCESSOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        accountSystem
        customerSystem
        staffSystem
    end
    
    methods
        function this = Processor(accountSystem, customerSystem, staffSystem)
            this.accountSystem = accountSystem;
            this.customerSystem = customerSystem;
            this.staffSystem = staffSystem;
        end
        
        function [retStr, customer] = logInCustomer(this, uid, password)
           [retStr, customer] = this.customerSystem.logIn(uid, password);
        end

        function [retStr, account] = logInAccount(this, aid, password)
           [retStr, account] = this.accountSystem.logIn(aid, password);
        end
        
        function [retStr, staff] = logInStaff(this, sid, password)
            [retStr, staff] = this.staffSystem.logIn(sid, password);
        end
        
        % We are assuming that the account always exist;
        function aid = getAccount(this, aid)
            aid = this.accountSystem.getAccount(aid); 
        end
        
        function retStr = transfer(this, srcAccount, aid, amount)
            if (~this.accountSystem.isValid(aid))
                retStr = Common.InvalidAccount;
                return
            end
            dstAccount = this.accountSystem.getAccount(aid);
            [~, status] = srcAccount.transferTo(dstAccount, amount);
            switch status
                case Status.Insufficient
                    retStr = Common.InsufficientFund;
                case Status.InvalidAmount
                    retStr = Common.InvalidAmount;
                case Status.Successful
                    retStr = "Transferred " + num2str(amount) +"CNY to account id: " + aid + ", " + this.query(srcAccount);
            end
        end
        
        function retStr = withdraw(this, account, amount)
            [~, status] = account.withdraw(amount);
            switch status
                case Status.Insufficient
                    retStr = Common.InsufficientFund;
                case Status.Successful
                    retStr = "You just withdrew"+ num2str(amount)+ "CNY, " + this.query(account);
            end
        end
        
        function retStr = query(~, account)
            retStr = "you have " + num2str(account.query()) +" CNY left in this account.";
        end
        
        function retStr = isValidPassword(password)
            retStr = Common.PasswordValid;
            if (strlength(password) < 8)
                retStr = Common.PasswordTooShot;
            end
        end
        
        function [retStr, customer] = registerNewCustomer(name, password)
            [~, customer] = processor.customerSystem.newCustomer(name, password);
            retStr = "You have successfully registered with uid:" + customer.getId();
        end
        
        function [isValid, retStr] = isValidUid(this, uid)
            if this.customerSystem.isValid(uid)
                retStr = Common.UidValid;
                isValid = 1;
            else
                retStr = Common.UidInvalid;
                isValid = 0;
            end
        end
        
        function [retStr, account] = registerNewAccount(customer, password)
            [~, account] = this.accountSystem.newAccount(customer, password);
            retStr = "You have successfully created an account with aid:" + account.getId();
        end
    end
end

