classdef TestStaff < matlab.unittest.TestCase
    properties
        stf0
        stf1
    end
    methods (TestMethodSetup)
        function createTestStaff(t)
            t.stf0 = Staff("Jhon Doe", "4156asd", "12323432", 0);
            t.stf1 = Staff("admin", "12345678", "69850764", 1);
        end
    end
    
    methods (Test)
        function testIsManager(t)
            t.verifyEqual(t.stf0.isManager(), 0);
            t.verifyEqual(t.stf1.isManager(), 1);
        end
    end
end

