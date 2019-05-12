cus1 = IndividualCustomer('Peter Rong', '1234567896453', '77085239', '321202199610300036');
cus2 = IndividualCustomer('Shaozhong Rong', 'shaozhong.R', '69850764', '321202199610300035');
cus3 = BusinessCustomer('Sanai EE Llt.', 'secretPassword', '32323232', '321251202056');

cus1_ = Customer('Peter Rong', '1234567896453', '77085239');
cus2_ = Customer('Shaozhong Rong', 'shaozhong.R', '69850764');
cus3_ = Customer('Sanai EE Llt.', 'secretPassword', '32323232');

testCustomerSystem = CustomerSystem([cus1_; cus2_; cus3_]);

cus1.addAccount('4581233143086599');
cus2.addAccount('1234123412341234');
cus2.addAccount('1203984712093849');
cus3.addAccount('8394049293049482');
cus3.addAccount('0053592669824525');