classdef TestCustomerUi < BankingUiTestHelper
    properties (Access = private)
        customerSystem     
    end
    methods (TestMethodSetup)
        function createTestCustomer(t)
            [~, t.customerSystem, ~, t.processor] = getSample();
            [~, customer] = t.customerSystem.logIn("321202003630100000", "12345678");
            t.app = CustomerUi(t.processor, customer);
        end
    end

    methods (Test)
        function testNewAccount(t)
            t.press(t.app.NewAccountButton);
            t.verifyEqual(class(t.darkSpace()), 'NewAccountUi');
            t.press(t.darkSpace().IwillregisterlaterButton);
        end

        function testManageAccount(t)
            t.choose(t.app.AccountDropDown, 1)
            t.press(t.app.ManageButton);
            t.verifyEqual(class(t.darkSpace()), 'AccountLogInUi');
            t.deleteDarkSpace();
        end
    end

    methods (TestMethodTeardown)
        function deleteCustomerUi(t)
            t.press(t.app.LogOutButton);
            % Log out and then log in window shows up.
            t.deleteDarkSpace();
        end
    end
end

