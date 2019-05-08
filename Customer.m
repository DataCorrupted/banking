classdef Customer
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        password
        accountNumber
    end
    
    methods
        % TODO: This constructor are useless for now as the attributes are 
        % public. We would make them private and add checkers to setters
        % in the future.
        function this = Customer(name, password, accountNumber)
            this.name = name;
            this.password = password;
            this.accountNumber = accountNumber;
        end
        
        % Three main function a customer cna do according to requirements.
        function returnStatus = query(this)
            returnStatus = 1;
        end
        function returnStatus = withdraw(this)
            returnStatus = 1;
        end
        function returnStatus = deposit(this)
            returnStatus = 1;
        end
    end
    
end

