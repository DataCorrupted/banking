classdef Processor
    %PROCESSOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        accountSystem
        customerSystem
    end
    
    methods
        function this = Processor(accountSystem, customerSystem)
            this.accountSystem = accountSystem;
            this.customerSystem = customerSystem;
        end
        
        function [resStr, customer] = logInCustomer(this, uid, password)
           [resStr, customer] = this.customerSystem.logIn(uid, password);
        end

        function [resStr, customer] = logInAccount(this, aid, password)
           [resStr, customer] = this.accountSystem.logIn(aid, password);
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
                    retStr = ['Transferred ', num2str(amount), 
                                'CNY to account id: ', aid];
            end
        end
        
        function retStr = withdraw(this, account, amount)
            [~, status] = account.withdraw(amount);
            switch status
                case Status.Insufficient
                    retStr = Common.InsufficientFund;
                case Status.Successful
                    retStr = ['You just withdrew', num2str(amount), 
                                'CNY, ', this.query(account)];
            end
        end
        
        function retStr = query(~, account)
            retStr = ['you have ', num2str(account.query()),' CNY left in this account.'];
        end
    end
end

