classdef TestTicketSystem < matlab.unittest.TestCase
    properties 
        ticketSystem
    end

    methods (TestMethodSetup)
        function createTestTicketSystem(t)
            t.ticketSystem = TicketSystem();
        end
    end

    methods (Test)
        function testTakeTicket(t)
            t.ticketSystem.takeTicket();
            t.ticketSystem.takeTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 0);
            t.verifyEqual(t.ticketSystem.getTail(), 2);
        end

        function testCallTicket(t)
            t.ticketSystem.takeTicket();
            t.ticketSystem.takeTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 0);
            t.ticketSystem.callTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 0);
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 1);
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            t.ticketSystem.callTicket();
            [~, status] = t.ticketSystem.callTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 3);
            t.verifyEqual(status, Status.TicketDepleted);
        end

        function testUseTicket(t)
            t.ticketSystem.takeTicket();
            t.ticketSystem.takeTicket();
            t.ticketSystem.takeTicket();
            
            t.ticketSystem.useTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 1);
            t.ticketSystem.useTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 2);
            t.ticketSystem.useTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 3);
            t.ticketSystem.useTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 3);
            t.ticketSystem.useTicket();
            t.ticketSystem.useTicket();
            t.ticketSystem.useTicket();
            t.verifyEqual(t.ticketSystem.getHead(), 3);
        end
    end
end