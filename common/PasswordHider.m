classdef PasswordHider < handle
    % Turns input password into stars.
    properties
        password
        hider
    end
    
    methods (Access = public)
        
        function this = PasswordHider()
            this.password = "";
            this.hider = "";
        end
        
        function hider = updatePassword(this, newPassword)
            k = length(newPassword);
            % Delete happened, we do not allow user to delete 
            % since event will not tell us what was deleted
            if (k <= strlength(this.password))
                this.password = "";
                this.hider = "";
            else
                this.password = this.password + newPassword(k);
                this.hider = this.hider + "*";
            end
            hider = this.hider;
        end
            
        function password = getPassword(this)
            password = this.password;
            this.password = "";
            this.hider = "";
            password = hashPassword(password);
        end
    end
    
    methods (Static)
        % This is just a naive implementation of hash function.
        function hashedPassword = hashPassword(password)
            hashedPassword = "";
            len = strlength(password);
            password = char(password);
            for i= 1:len 
                oldChar = password(i);
                newChar = mod(round(sin(log(oldChar * 42 + 996)) * 12121), 94) + 32; 
                char(newChar)
                hashedPassword = hashedPassword + char(newChar);
            end
        end
    end
end

