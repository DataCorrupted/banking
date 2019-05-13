%cus1 = IndividualCustomer('Peter Rong', '1234567896453', '77085239', '321202199610300036');
%cus2 = IndividualCustomer('Shaozhong Rong', 'shaozhong.R', '69850764', '321202199610300035');
%cus3 = BusinessCustomer('Sanai EE Llt.', 'secretPassword', '32323232', '321251202056');

cus1 = Customer("Peter Rong", "1234567896453", "77085239");
cus2 = Customer("Shaozhong Rong", "shaozhong.R", "69850764");
cus3 = Customer("Sanai EE Llt.", "secretPassword", "32323232");
cus4 = Customer("Nobody", "Nobody", "12345678");

testCustomerSystem = CustomerSystem([cus1; cus2; cus3; cus4]);

cus1.addAccount("4581233143086599");
cus2.addAccount("1234123412341234");
cus2.addAccount("1203984712093849");
cus3.addAccount("8394049293049482");
cus3.addAccount("0053592669824525");