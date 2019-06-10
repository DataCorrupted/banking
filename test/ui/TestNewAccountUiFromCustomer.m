classdef TestNewAccountUiFromCustomer < BankingUiTestHelper
    properties (Access = private)
        accountSystem
        customerUi   
    end
    methods (TestMethodSetup)
        function createTestNewAccount(t)
            [t.accountSystem, customerSystem, ~, t.processor] = getSample();
            [~, customer] = customerSystem.logIn("321202003630100000", "12345678");
            t.customerUi = CustomerUi(t.processor, customer);
            t.press(t.customerUi.NewAccountButton);
            t.app = t.darkSpace();
            t.processor.darkSpace = 0;
        end
    end

    methods (Test)
        function testNewAccountSuccessful(t)
            oldNum = t.accountSystem.getNum();
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % A new account is created.
            t.verifyEqual(t.accountSystem.getNum(), oldNum+1);
            % A piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'PromptUi');
            % Switch to PromptUi;
            t.app = t.darkSpace();
            t.press(t.app.ContinueButton);
            t.verifyEqual(class(t.darkSpace()), 'AccountUi');
            t.deleteDarkSpace();
        end

        function testNewAccountInvalidPassword(t)
            oldNum = t.accountSystem.getNum();
            t.typePassword(t.app.PasswordEditField, "12345", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % No Account is created.
            t.verifyEqual(t.accountSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.PasswordTooShort));
            t.deleteApp();
        end

        function testNewAccountMismatchPassword(t)
            oldNum = t.accountSystem.getNum();
            t.typePassword(t.app.PasswordEditField, "123456789", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "987654321", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % No Account is created.
            t.verifyEqual(t.accountSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.PasswordDiffer));
            t.deleteApp();
        end
    end

    methods (TestMethodTeardown)
        function deleteTestNewAccount(t)
            t.customerUi.delete;
        end
    end
end

