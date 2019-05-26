classdef TestStaffSystem < matlab.unittest.TestCase
    properties
        staffSystem
        newStf
    end
    methods (TestMethodSetup)
        function createTestStaffSystem(t)
            t.staffSystem = StaffSystem([]);
        end
    end
    
    methods (Test)
        function testNewStaff(t)
            t.verifyEqual(t.staffSystem.getNum(), 0);
            [~, stf] = t.staffSystem.newStaff("Peter", "12425", 1);
            t.verifyEqual(stf.passwordMatch("12425"), true);
            t.verifyEqual(stf.passwordMatch("123456"), false);
            t.verifyEqual(t.staffSystem.getNum(), 1);
        end
    end
end

