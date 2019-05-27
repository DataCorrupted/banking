classdef Processor
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
        function account = getAccount(this, aid)
            account = this.accountSystem.getAccount(aid); 
        end
        
        function retStr = transfer(this, srcAccount, aid, amount)
            if (srcAccount.getId() == aid)
                retStr = Common.IllegalSelfTransfer;
                return
            end
            if (~this.accountSystem.isExisting(aid))
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
                case Status.InvalidAmount
                    retStr = Common.InvalidAmount;
            end
        end
        
        function retStr = query(~, account)
            retStr = "you have " + num2str(account.query()) +" CNY left in this account.";
        end
        
        function retStr = isValidPassword(~, password0, password1)
            retStr = Common.PasswordValid;
            if (password0 == "" && password1 == "")
                retStr = Common.PasswordEmpty;
                return;
            end
            if ~strcmp(password0, password1)
                retStr = Common.PasswordDiffer;
                return
            end
            if (strlength(password0) < 8)
                retStr = Common.PasswordTooShort;
                return
            end
        end
        
        function [retStr, customer] = registerNewCustomer(this, name, password, uid)
            [~, customer] = this.customerSystem.newCustomer(name, password, uid);
            retStr = "You have successfully registered with uid:" + customer.getId();
        end
        
        function [isValid, retStr] = isValidUId(this, uid)
            isValid = 0;
            if (strlength(uid) == 0)
                retStr = Common.UIdEmpty;
                return
            end
            if (strlength(uid) ~= this.customerSystem.getUIdLen())
                retStr = Common.UIdWrongLength;
                return;
            end
            if ~ this.customerSystem.isTaken(uid)
                retStr = Common.UIdValid;
                isValid = 1;
            else
                retStr = Common.UIdRegistered;
            end
        end
        function [retStr, isExisting] = isExistingUId(this, uid)
            isExisting = 0;
            if this.customerSystem.isTaken(uid)
                retStr = Common.UIdValid;
                isExisting = 1;
            else
                retStr = Common.UIdInValid;
            end            
        end
        
        function [retStr, account] = registerNewAccount(this, uid, password)
            [~, isExisting] = this.isExistingUId(uid);
            if ~ isExisting
                retStr = Common.UIdInValid;
                account = [];
                return;
            end
            customer = this.customerSystem.getCustomer(uid);
            [~, account] = this.accountSystem.newAccount(customer, password);
            retStr = "You have successfully created an account with aid:" + account.getId();
        end
        
        function [retStr, staff] = registerNewStaff(this, name, password, isManager)
            [~, staff] = this.staffSystem.newStaff(name, password, isManager);
            retStr = "You have successfully registered with sid:" + staff.getId();       
        end
    end
end

