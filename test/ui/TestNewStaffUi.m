classdef TestNewStaffUi < BankingUiTestHelper
    properties (Access = private)
        staffSystem
        staffUi   
    end
    methods (TestMethodSetup)
        function createTestNewStaff(t)
            [~, ~, t.staffSystem, t.processor] = getSample();
            [~, staff] = t.staffSystem.logIn("69850764", "12345678");
            t.staffUi = StaffUi(t.processor, staff);
            t.press(t.staffUi.NewStaffButton);
            t.app = t.darkSpace();
            t.processor.darkSpace = 0;
        end
    end

    methods (Test)
        function testNewStaffSuccessful(t)
            oldNum = t.staffSystem.getNum();
            t.type(t.app.NameEditField, "Peter")
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % A new user is created.
            t.verifyEqual(t.staffSystem.getNum(), oldNum+1);
            % A piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'PromptUi');
            % Switch to PromptUi;
            t.app = t.darkSpace();
            t.press(t.app.ContinueButton);
            t.verifyEqual(class(t.darkSpace()), 'StaffUi');
            % Log out first.
            t.press(t.darkSpace().LogOutButton);
            % Shutdown log in window
            t.deleteDarkSpace();
        end
        function testNewManagerSuccessful(t)
            oldNum = t.staffSystem.getNum();
            t.type(t.app.NameEditField, "Peter")
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.choose(t.app.ThisisamanagerthathasalofofrightsCheckBox);
            t.press(t.app.RegisterNowButton); 
            % A new user is created.
            t.verifyEqual(t.staffSystem.getNum(), oldNum+1);
            % A piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'PromptUi');
            % Switch to PromptUi;
            t.app = t.darkSpace();
            t.press(t.app.ContinueButton);
            t.verifyEqual(class(t.darkSpace()), 'StaffUi');
            % Log out first.
            t.press(t.darkSpace().LogOutButton);
            % Shutdown log in window
            t.deleteDarkSpace();
        end

        function testNewStaffInvalidPassword(t)
            oldNum = t.staffSystem.getNum();
            t.type(t.app.NameEditField, "Peter")
            t.typePassword(t.app.PasswordEditField, "12345", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % No Staff is created.
            t.verifyEqual(t.staffSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.PasswordTooShort));
            t.deleteApp();
        end

        function testNewStaffMismatchPassword(t)
            oldNum = t.staffSystem.getNum();
            t.type(t.app.NameEditField, "Peter")
            t.typePassword(t.app.PasswordEditField, "123456789", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "987654321", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % No Staff is created.
            t.verifyEqual(t.staffSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.PasswordDiffer));
            t.deleteApp();
        end
    end

    methods (TestMethodTeardown)
        function deleteTestNewStaff(t)
            t.press(t.staffUi.LogOutButton);
            % Log out and then log in window shows up.
            t.deleteDarkSpace();
        end
    end
end

