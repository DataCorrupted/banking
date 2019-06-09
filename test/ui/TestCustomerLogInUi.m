classdef TestCustomerLogInUi < BankingUiTestHelper
    methods (TestMethodSetup)
        function createTestCustomerLogInUi(t)
            [~, ~, ~, t.processor] = getSample();
            t.app = CustomerLogInUi(t.processor);
        end
    end

    methods (Test)
        function testLogInEmpty(t)
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.processor.darkSpace), 'double');
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.LogInIdInvalid));
            t.deleteApp();
        end
        function testLogInFail(t)
            t.type(t.app.UserIdEditField, "321202003630100000");
            t.type(t.app.PasswordEditField, "1");
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.processor.darkSpace), 'double');
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.LogInWrongPassword));
            t.deleteApp();
        end
        function testLogInSuccessful(t)
            t.type(t.app.UserIdEditField, "321202003630100000");
            t.typePassword(t.app.PasswordEditField, "12345678");
            t.press(t.app.LogInButton);
            t.verifyEqual(class(t.processor.darkSpace), 'CustomerUi');
            t.deleteDarkSpace();
        end
        function testRegisterPushed(t)
            t.press(t.app.NotavaluedcustomerRegisterNowButton);
            t.verifyEqual(class(t.processor.darkSpace), 'NewCustomerUi');
            t.deleteDarkSpace();
            t.deleteApp();
        end
    end
end

