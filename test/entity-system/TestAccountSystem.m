classdef TestAccountSystem < matlab.unittest.TestCase
    properties
        accountSystem
        newAcc
        customer
    end
    methods (TestMethodSetup)
        function createTestAccountSystem(t)
            t.accountSystem = AccountSystem([]);
            
            t.accountSystem.addAccount(Account("1234567890123456", "123456"));
            t.accountSystem.addAccount(Account("1234123412341234", "654123"));
            t.accountSystem.addAccount(Account("8394049293049482", "789654"));
            t.accountSystem.addAccount(Account("0053592669824525", "562851"));
            t.newAcc = Account("1203984712093849", "324503");
            t.customer = Customer("Peter Rong", "12345678", "321202003630100000");
        end
    end
    
    methods (Test)
        function testAddAccount(t)
            t.verifyEqual(t.accountSystem.getNum(), 4);
            t.accountSystem.addAccount(t.newAcc);
            t.verifyEqual(t.accountSystem.getNum(), 5);
        end
        function testGetAccount(t)
            t.accountSystem.addAccount(t.newAcc);
            t.verifyEqual(t.accountSystem.getAccount("1203984712093849"), t.newAcc);
        end

        function testIsExisting(t)
            t.verifyEqual(t.accountSystem.isExisting("1234567890123456"), true);
            t.verifyEqual(t.accountSystem.isExisting("1203984712093849"), false);
        end

        function testNewAccount(t)
            [~, account] = t.accountSystem.newAccount(t.customer, "123456");
            t.verifyEqual(account.passwordMatch("123456"), true);
            t.verifyEqual(t.customer.getAccountNum, 1);
            t.verifyEqual(t.accountSystem.getNum(), 5);
        end
    end
end

