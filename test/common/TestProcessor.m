classdef TestProcessor < matlab.unittest.TestCase
    properties 
        processor
        accountSystem
        customerSystem
        staffSystem
    end
    
    methods (TestMethodSetup)
        function CreateTestProcessor(t)
            acc1 = Account("1234567890123456", "123456");
            acc2 = Account("1234123412341234", "654123");
            acc3 = Account("8394049293049482", "789654");
            acc4 = Account("0053592669824525", "562851");
            acc5 = Account("1203984712093849", "324503");
            acc1.deposit(1200);
            acc2.deposit(1000);
            acc3.deposit(700);
            acc4.deposit(10000);
            t.accountSystem = AccountSystem([acc1; acc2; acc3; acc4; acc5]);

            cus1 = Customer("Peter Rong", "12345678", "321202003630100000");
            cus2 = Customer("Shaozhong Rong", "shaozhong.R", "122121198708030012");
            cus3 = Customer("Sanai EE Llt.", "secretPassword", "121233200401211121");
            cus4 = Customer("Nobody", "Nobody", "321202190208270022");
            cus1.addAccount("1234567890123456");
            cus2.addAccount("1234123412341234");
            cus2.addAccount("1203984712093849");
            cus3.addAccount("8394049293049482");
            cus3.addAccount("0053592669824525");
            t.customerSystem = CustomerSystem([cus1; cus2; cus3; cus4]);

            stf1 = Staff("Jhon Doe", "4156asd", "12323432", 0);
            stf2 = Staff("admin", "12345678", "69850764", 1);
            stf3 = Staff("Dummy Person", "asdlf", "24324545", 0);
            t.staffSystem = StaffSystem([stf1; stf2; stf3]);

            t.processor = Processor(t.accountSystem, t.customerSystem, t.staffSystem);
        end
    end

    methods (Test)

        function testLogInAccount(t)
            [retStr, account] = t.processor.logInAccount("8394049293049482", "789654");
            t.verifyEqual(retStr, Common.LogInSuccessful);
            t.verifyEqual(account.query(), 700);

            [retStr, ~] = t.processor.logInAccount("8394049293049482", "123345");
            t.verifyEqual(retStr, Common.LogInWrongPassword);

            [retStr, ~] = t.processor.logInAccount("LogInWrongPassword", "789654");
            t.verifyEqual(retStr, Common.LogInIdInvalid);
        end
        function testLogInCustomer(t)
            [retStr, customer] = t.processor.logInCustomer("121233200401211121", "secretPassword");
            t.verifyEqual(retStr, Common.LogInSuccessful);
            t.verifyEqual(customer.getName(), "Sanai EE Llt.");
        end
        function testLogInStaff(t)
            [retStr, staff] = t.processor.logInStaff("69850764", "12345678");
            t.verifyEqual(retStr, Common.LogInSuccessful);
            t.verifyEqual(staff.isManager(), 1);
        end

        function testGetAccount(t)
            account = t.processor.getAccount("0053592669824525");
            t.verifyEqual(account.passwordMatch("324503"), false);
            t.verifyEqual(account.passwordMatch("562851"), true);              
            t.verifyEqual(account.query(), 10000);
        end

        function testTransfer(t)
            src = t.processor.getAccount("1234567890123456");
            dst = t.processor.getAccount("1203984712093849")

            retStr = t.processor.transfer(src, "1234567890123456", 100);
            t.verifyEqual(retStr, Common.IllegalSelfTransfer);
            t.verifyEqual(src.query(), 1200);

            retStr = t.processor.transfer(src, "1236576874532342", 100);
            t.verifyEqual(retStr, Common.InvalidAccount);
            t.verifyEqual(src.query(), 1200);

            retStr = t.processor.transfer(src, dst.getId(), 100000);
            t.verifyEqual(retStr, Common.InsufficientFund);
            t.verifyEqual(src.query(), 1200);

            retStr = t.processor.transfer(src, dst.getId(), -1);
            t.verifyEqual(retStr, Common.InvalidAmount);
            t.verifyEqual(src.query(), 1200);

            t.processor.transfer(src, dst.getId(), 200);
            t.verifyEqual(src.query(), 1000);
            t.verifyEqual(dst.query(), 200);

            t.processor.transfer(src, dst.getId(), 100);
            t.verifyEqual(src.query(), 900);
            t.verifyEqual(dst.query(), 300);
        end

        function testWithdraw(t)
            account = t.processor.getAccount("0053592669824525");
            
            retStr = t.processor.withdraw(account, 2147483648);
            t.verifyEqual(retStr, Common.InsufficientFund);
            t.verifyEqual(account.query(), 10000);

            retStr = t.processor.withdraw(account, -1);
            t.verifyEqual(retStr, Common.InvalidAmount);
            t.verifyEqual(account.query(), 10000);

            t.processor.withdraw(account, 1);
            t.verifyEqual(account.query(), 9999);
            t.processor.withdraw(account, 99);
            t.verifyEqual(account.query(), 9900);
        end

        function testIsValidPassword(t)
            retStr = t.processor.isValidPassword("11", "11");
            t.verifyEqual(retStr, Common.PasswordTooShort);

            retStr = t.processor.isValidPassword("11111111", "11111111");
            t.verifyEqual(retStr, Common.PasswordValid);

            retStr = t.processor.isValidPassword("", "");
            t.verifyEqual(retStr, Common.PasswordEmpty);

            retStr = t.processor.isValidPassword("123451`245", "098jhvj");
            t.verifyEqual(retStr, Common.PasswordDiffer);
        end

        function testRegisterNewCustomer(t)
            t.verifyEqual(t.customerSystem.getNum(), 4);
            [~, customer] = t.processor.registerNewCustomer("Name", "123454", "12435");
            t.verifyEqual(t.customerSystem.getNum(), 5);
            t.verifyEqual(customer.getName(), "Name");
        end
        function testRegisterNewAccount(t)
            t.verifyEqual(t.accountSystem.getNum(), 5);
            [~, account] = t.processor.registerNewAccount("321202190208270022", "146585");
            t.verifyEqual(t.accountSystem.getNum(), 6);
            t.verifyEqual(account.passwordMatch("146585"), true);
            [retStr, ~] = t.processor.registerNewAccount("safdsad", "asdfa");
            t.verifyEqual(retStr, Common.UIdInValid);
        end
        function testRegisterNewStaff(t)
            t.verifyEqual(t.staffSystem.getNum(), 3);
            [~, staff] = t.processor.registerNewStaff("asdf", "sadfasd", 1);
            t.verifyEqual(t.staffSystem.getNum(), 4);
            t.verifyEqual(staff.isManager(), 1);
        end
        function testIsExistingUId(t)
            [retStr, isExisting] = t.processor.isExistingUId("321202190208270022");
            t.verifyEqual(isExisting, 1);
            t.verifyEqual(retStr, Common.UIdValid);

            [retStr, isExisting] = t.processor.isExistingUId("321202190208270024");
            t.verifyEqual(isExisting, 0);
            t.verifyEqual(retStr, Common.UIdInValid);
        end
        function testIsValidUId(t)
            [isValid, retStr] = t.processor.isValidUId("");
            t.verifyEqual(isValid, 0);
            t.verifyEqual(retStr, Common.UIdEmpty);
            [isValid, retStr] = t.processor.isValidUId("124376865432");
            t.verifyEqual(isValid, 0);
            t.verifyEqual(retStr, Common.UIdWrongLength);
            [isValid, retStr] = t.processor.isValidUId("321202190208270022");
            t.verifyEqual(isValid, 0);
            t.verifyEqual(retStr, Common.UIdRegistered);
            [isValid, retStr] = t.processor.isValidUId("321202190208270024");
            t.verifyEqual(isValid, 1);
            t.verifyEqual(retStr, Common.UIdValid);
        end
    end
end