classdef BankingUiTestHelper < matlab.uitest.TestCase
    properties (Access = protected)
        processor
        app
    end
    methods (Access = protected)
        % This is a hacked type in function to help me input passwords.
        function typePassword(this, comp, password, passwordHider)
            password = convertStringsToChars(password);
            strlen = strlength(password);

            for i= 1:strlen
                % Input a new char
                comp.Value = password(1:i);
                
                % Manual call back
                hider = passwordHider.updatePassword(comp.Value);
                this.app.PasswordEditField.Value = hider;

                % Stop and wait for next char
                pause(0.2);
            end
        end
        function deleteDarkSpace(this)
            this.processor.darkSpace.delete;
        end
        function deleteApp(this)
            this.app.delete;
        end
    end
end