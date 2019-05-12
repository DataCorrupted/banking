classdef PasswordChallenge < Challenge
    %PASSWORDCHALLENGE Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function this = PasswordChallenge(name)
            this@Challenge(name);
        end
        
        function passed = challenge(this)
            % From GUI take user password
            password = 123456;
            
            % Get user password from GUI
            input = 123456;
            
            passed = (password == input);            
        end
    end
end

