classdef TestStaffUi < BankingUiTestHelper
    properties (Access = private)
        staffSystem     
    end
    methods (TestMethodSetup)
        function createTeststaff(t)
            [~, t.staffSystem, ~, t.processor] = getSample();
            [~, staff] = t.staffSystem.logIn("69850764", "12345678");
            t.app = StaffUi(t.processor, staff);
        end
    end

    methods (Test)
        function testNewAccount(t)
            t.press(t.app.NewAccountButton);
            t.verifyEqual(class(t.darkSpace()), 'NewAccountUi');
            t.deleteDarkSpace();
        end
        function testNewCustomer(t)
            t.press(t.app.NewCustomerButton);
            t.verifyEqual(class(t.darkSpace()), 'NewCustomerUi');
            t.deleteDarkSpace();
        end
    end

    methods (TestMethodTeardown)
        function deleteStaffUi(t)
            t.press(t.app.LogOutButton);
            % Log out and then log in window shows up.
            t.deleteDarkSpace();
        end
    end
end

