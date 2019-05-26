classdef TestPasswordHider < matlab.unittest.TestCase
    properties 
        passwordHider
    end

    methods (TestMethodSetup)
        function createPasswordHider(t)
            t.passwordHider = PasswordHider();
        end
    end

    methods (Test)
        function testHashPassword(t)
            password = t.passwordHider.hashPassword("1234567");
            t.verifyEqual(password, "(iJ)eAz");
        end
    end
end