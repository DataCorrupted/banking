classdef TestAccountLogInUi < BankingUiTestHelper
    methods (TestMethodSetup)
        function createTestAccountLogInUi(t)
            [~, ~, ~, t.processor] = getSample();
            t.app = AccountLogInUi(t.processor, 0, 1);
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
            t.type(t.app.AccountIdEditField, "1234567890123456");
            t.typePassword(t.app.PasswordEditField, "1", t.app.passwordHider);
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.LogInWrongPassword));
            t.deleteApp();
        end
        function testLogInSuccessful(t)
            t.type(t.app.AccountIdEditField, "1234567890123456");
            t.typePassword(t.app.PasswordEditField, "123456", t.app.passwordHider);
            
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.darkSpace()), 'AccountUi');
            t.deleteDarkSpace();
        end
    end
end

