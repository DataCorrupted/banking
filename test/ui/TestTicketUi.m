classdef TestTicketUi < BankingUiTestHelper
    properties (Access = private)
        ticketSystem        
    end
    methods (TestMethodSetup)
        function createTeststaff(t)
            [~, ~, ~, t.processor] = getSample();
            t.ticketSystem = t.processor.ticketSystem;
            t.app = TicketUi(t.processor);
        end
    end

    methods (Test)
        function testTakeTicket(t)
            tail = t.ticketSystem.getTail();
            t.press(t.app.TakeaticketsitbackandwaitButton);
            t.verifyEqual(t.ticketSystem.getTail(), tail + 1);
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.TakeTicketSuccessful + "0"));
            t.press(t.app.TakeaticketsitbackandwaitButton);
            t.verifyEqual(t.ticketSystem.getTail(), tail + 2);
            t.verifyEqual(t.app.TextArea.Value{1}, convertStringsToChars(Common.TakeTicketSuccessful + "1"));
        end
    end

    methods (TestMethodTeardown)
        function deleteStaffUi(t)
            t.deleteApp();
        end
    end
end

