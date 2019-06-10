classdef TestNewCustomerUi < BankingUiTestHelper
    properties (Access = private)
        customerSystem        
    end
    methods (TestMethodSetup)
        function createTestNewCustomer(t)
            [~, t.customerSystem, ~, t.processor] = getSample();
            t.app = NewCustomerUi(t.processor);
        end
    end

    methods (Test)
        function testNewCustomerSuccessful(t)
            oldNum = t.customerSystem.getNum();
            t.type(t.app.IDEditField, "321202199999990023");
            t.type(t.app.NameEditField, "Peter");
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.choose(t.app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox);
            t.press(t.app.RegisterNowButton); 
            % A new user is created.
            t.verifyEqual(t.customerSystem.getNum(), oldNum+1);
            % A piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'PromptUi');
            % Switch to PromptUi;
            t.app = t.darkSpace();
            t.press(t.app.ContinueButton);
            t.verifyEqual(class(t.darkSpace()), 'CustomerUi');
            t.deleteDarkSpace();
        end

        function testNewCustomerInvalidPassword(t)
            oldNum = t.customerSystem.getNum();
            t.type(t.app.IDEditField, "321202199999990023");
            t.type(t.app.NameEditField, "Peter");
            t.typePassword(t.app.PasswordEditField, "12345", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345", t.app.passwordHider1);
            t.choose(t.app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox);
            t.press(t.app.RegisterNowButton); 
            % No Customer is created.
            t.verifyEqual(t.customerSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.PasswordTooShort));
            t.deleteApp();
        end
        function testNewCustomerMismatchPassword(t)
            oldNum = t.customerSystem.getNum();
            t.type(t.app.IDEditField, "321202199999990023");
            t.type(t.app.NameEditField, "Peter");
            t.typePassword(t.app.PasswordEditField, "123456789", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "987654321", t.app.passwordHider1);
            t.choose(t.app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox);
            t.press(t.app.RegisterNowButton); 
            % No Customer is created.
            t.verifyEqual(t.customerSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.PasswordDiffer));
            t.deleteApp();
        end
        function testNewCustomerWrongId(t)
            oldNum = t.customerSystem.getNum();
            t.type(t.app.IDEditField, "12345665432");
            t.type(t.app.NameEditField, "Peter");
            t.typePassword(t.app.PasswordEditField, "123456789", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "123456789", t.app.passwordHider1);
            t.choose(t.app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox);
            t.press(t.app.RegisterNowButton); 
            % No Customer is created.
            t.verifyEqual(t.customerSystem.getNum(), oldNum);
            % No piece of information is poped up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.UIdWrongLength));
            t.deleteApp();
        end
        function testNewCustomerDisagreeToTerms(t)
            oldNum = t.customerSystem.getNum();
            t.type(t.app.IDEditField, "321202199999990023");
            t.type(t.app.NameEditField, "Peter");
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.press(t.app.RegisterNowButton); 
            % No Customer is created
            t.verifyEqual(t.customerSystem.getNum(), oldNum);
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.TermsDisagree));
            t.deleteApp();
        end

        function testNewCustomerIdExists(t)
            oldNum = t.customerSystem.getNum();
            t.type(t.app.IDEditField, "321202003630100000");
            t.type(t.app.NameEditField, "Peter");
            t.typePassword(t.app.PasswordEditField, "12345678", t.app.passwordHider0);
            t.typePassword(t.app.RepeatPasswordEditField, "12345678", t.app.passwordHider1);
            t.choose(t.app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox);
            t.press(t.app.RegisterNowButton); 
            % No Customer is created
            t.verifyEqual(t.customerSystem.getNum(), oldNum);
            % Nothing pops up.
            t.verifyEqual(class(t.darkSpace()), 'double');
            t.verifyEqual(t.app.Hints.Value{1}, convertStringsToChars(Common.UIdRegistered));
            t.deleteApp();
        end
    end
end

