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

            t.verifyEqual(t.customerSystem.getNum(), oldNum+1);
            t.verifyEqual(class(t.darkSpace()), 'PromptUi');

            % Switch to PromptUi;
            t.app = t.darkSpace();
            t.press(t.app.ContinueButton);
            t.verifyEqual(class(t.darkSpace()), 'CustomerUi');

            t.deleteDarkSpace();
        end
    end
end

