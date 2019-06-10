classdef TestStaffLogInUi < BankingUiTestHelper
    methods (TestMethodSetup)
        function createTestStaffLogInUi(t)
            [~, ~, ~, t.processor] = getSample();
            t.app = StaffLogInUi(t.processor);
        end
    end

    methods (Test)
        function testLogInEmpty(t)
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.LogInIdInvalid));
            t.deleteApp();
        end
        function testLogInFail(t)
            t.type(t.app.StaffIdEditField, "12323432");
            t.typePassword(t.app.PasswordEditField, "1", t.app.passwordHider);
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.LogInWrongPassword));
            t.deleteApp();
        end
        function testLogInSuccessful(t)
            t.type(t.app.StaffIdEditField, "12323432");
            t.typePassword(t.app.PasswordEditField, "4156asd", t.app.passwordHider);
            
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.darkSpace()), 'StaffUi');
            t.deleteDarkSpace();
        end
    end
end

