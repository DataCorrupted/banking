classdef TestAccountUiFromCustomerUi < BankingUiTestHelper
    properties (Access = private)
        srcAccount
        dstAccount
        accountSystem     
    end
    methods (TestMethodSetup)
        function createTestAccountUi(t)
            [t.accountSystem, ~, ~, t.processor] = getSample();
            [~, t.srcAccount] = t.accountSystem.logIn("1234567890123456", "123456");
            [~, t.dstAccount] = t.accountSystem.logIn("8394049293049482", "789654");
            t.app = AccountUi(t.processor, t.srcAccount, 0);
        end 
    end

    % Test Transfer
    methods (Test)
        function testTransferSuccessful(t)
            srcOldAmount = t.srcAccount.query();
            dstOldAmount = t.dstAccount.query();
            t.type(t.app.TransfertoEditField, "8394049293049482");
            t.type(t.app.AmountEditField, 100);
            t.press(t.app.transferButton);
            t.verifyEqual(t.srcAccount.query(), srcOldAmount - 100);
            t.verifyEqual(t.dstAccount.query(), dstOldAmount + 100);
            t.verifyEqual(t.app.AmountEditField.Value, 0);
            % Double press will have not effect.
            t.press(t.app.transferButton);
            t.verifyEqual(t.srcAccount.query(), srcOldAmount - 100);
            t.verifyEqual(t.dstAccount.query(), dstOldAmount + 100);
        end
        function testTransferInvalidAmount(t)
            srcOldAmount = t.srcAccount.query();
            dstOldAmount = t.dstAccount.query();
            t.type(t.app.TransfertoEditField, "8394049293049482");
            t.type(t.app.AmountEditField, -123);
            t.press(t.app.transferButton);
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.InvalidAmount));
            t.verifyEqual(t.srcAccount.query(), srcOldAmount);
            t.verifyEqual(t.dstAccount.query(), dstOldAmount);
        end
        function testTransferIllegalSelfTransfer(t)
            srcOldAmount = t.srcAccount.query();
            t.type(t.app.TransfertoEditField, "1234567890123456");
            t.type(t.app.AmountEditField, 123);
            t.press(t.app.transferButton);
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.IllegalSelfTransfer));
            t.verifyEqual(t.srcAccount.query(), srcOldAmount);
        end
        function testTransferInvalidAccount(t)
            srcOldAmount = t.srcAccount.query();
            t.type(t.app.TransfertoEditField, "12435");
            t.type(t.app.AmountEditField, 123);
            t.press(t.app.transferButton);
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.InvalidAccount));
            t.verifyEqual(t.srcAccount.query(), srcOldAmount);
        end
        function testTransferInsufficientFund(t)
            srcOldAmount = t.srcAccount.query();
            dstOldAmount = t.dstAccount.query();
            t.type(t.app.TransfertoEditField, "8394049293049482");
            t.type(t.app.AmountEditField, 10000000);
            t.press(t.app.transferButton);
            t.verifyEqual(t.srcAccount.query(), srcOldAmount);
            t.verifyEqual(t.dstAccount.query(), dstOldAmount);
        end
    end

    methods (TestMethodTeardown)
        function deleteAccountUi(t)
            t.press(t.app.LogOutButton);
        end
    end
end

