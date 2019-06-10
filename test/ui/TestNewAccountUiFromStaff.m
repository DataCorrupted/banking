classdef TestNewAccountUiFromStaff < BankingUiTestHelper
    properties (Access = private)
        accountSystem
        staffUi   
    end
    methods (TestMethodSetup)
        function createTestNewAccount(t)
            [t.accountSystem, ~, staffSystem, t.processor] = getSample();
            [~, staff] = staffSystem.logIn("12323432", "4156asd");
            t.staffUi = StaffUi(t.processor, staff);
            t.press(t.staffUi.NewAccountButton);
            t.app = t.darkSpace();
            t.processor.darkSpace = 0;
        end
    end

    methods (Test)
        function testNewAccountSuccessful(t)
            oldNum = t.accountSystem.getNum();
            t.type(t.app.YourUidEditField, "321202003630100000");
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % A new user is created.
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
            t.type(t.app.YourUidEditField, "321202003630100000");
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
            t.type(t.app.YourUidEditField, "321202003630100000");
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

        function testNewAccountCustomerDoesNotExist(t)
            oldNum = t.accountSystem.getNum();
            t.type(t.app.YourUidEditField, "321202003630101234");
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % No Account is created.
            t.verifyEqual(t.accountSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.UIdInValid));
            t.deleteApp();
        end
    end

    methods (TestMethodTeardown)
        function deleteTestNewAccount(t)
            t.press(t.staffUi.LogOutButton);
            % Log out and then log in window shows up.
            t.deleteDarkSpace();
        end
    end
end

