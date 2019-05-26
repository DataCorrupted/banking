classdef TestCustomerSystem < matlab.unittest.TestCase
    properties
        customerSystem
        newCus
    end
    methods (TestMethodSetup)
        function createTestCustomerSystem(t)
            t.customerSystem = CustomerSystem([]);

            cus1 = Customer("Peter Rong", "12345678", "321202003630100000");
            cus2 = Customer("Shaozhong Rong", "shaozhong.R", "122121198708030012");
            cus3 = Customer("Sanai EE Llt.", "secretPassword", "121233200401211121");
            t.newCus = Customer("Nobody", "Nobody", "321202190208270022");

            t.customerSystem.addCustomer(cus1);
            t.customerSystem.addCustomer(cus2);
            t.customerSystem.addCustomer(cus3);
        end
    end
    
    methods (Test)
        function testAddCustomer(t)
            t.verifyEqual(t.customerSystem.getNum(), 3);
            t.customerSystem.addCustomer(t.newCus);
            t.verifyEqual(t.customerSystem.getNum(), 4);
        end

        function testUIdLen(t)
            t.verifyEqual(t.customerSystem.getUIdLen(), 18);
        end

        function testGetCustomer(t)
            t.customerSystem.addCustomer(t.newCus);
            t.verifyEqual(t.customerSystem.getCustomer("321202190208270022"), t.newCus);
        end
    end
end

