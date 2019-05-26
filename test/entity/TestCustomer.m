classdef TestCustomer < matlab.unittest.TestCase
    properties
        cus
    end
    methods (TestMethodSetup)
        function createTestCustomer(t)
            t.cus = Customer("Shaozhong Rong", "shaozhong.R", "122121198708030012");
        end
    end
    
    methods (Test)
        function testAddAccount(t)
            t.cus.addAccount(Account("1234567890123456", "123456"));
            t.cus.addAccount(Account("1234123412341234", "654123"));

            t.verifyEqual(t.cus.getAccountNum(), 2);
        end
    end
end

