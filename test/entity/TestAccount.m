classdef TestAccount < matlab.unittest.TestCase
    properties
        acc1
        acc2
        acc3
    end
    methods (TestMethodSetup)
        function createTestAccount(t)
            t.acc1 = Account("1234567890123456", "123456");
            t.acc2 = Account("1234123412341234", "654123");
            t.acc3 = Account("8394049293049482", "789654");

            t.acc1.deposit(100);
            t.acc2.deposit(200);
            t.acc3.deposit(300);
        end
    end
    
    methods (Test)
        function testDeposit(t)
            t.verifyEqual(t.acc1.query(), 100);
            t.verifyEqual(t.acc2.query(), 200);
            t.verifyEqual(t.acc3.query(), 300);
        end

        function testWithdraw(t)
            t.acc3.withdraw(100);
            t.verifyEqual(t.acc3.query(), 200);
        end

        function testWithwradError(t)
            [~, result] = t.acc3.withdraw(10000);
            t.verifyEqual(t.acc3.query(), 300);
            t.verifyEqual(result, Status.Insufficient);

            [~, result] = t.acc3.withdraw(-1);
            t.verifyEqual(t.acc3.query(), 300);
            t.verifyEqual(result, Status.InvalidAmount);
           
        end

        function testTransferTo(t)
            t.acc2.transferTo(t.acc1, 50);
            t.verifyEqual(t.acc1.query(), 150);
            t.verifyEqual(t.acc2.query(), 150);

            [~, result] = t.acc1.transferTo(t.acc3, 10000);
            t.verifyEqual(t.acc1.query(), 150);
            t.verifyEqual(result, Status.Insufficient);
        end
    end
end

