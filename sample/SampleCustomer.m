cus1 = Customer("Peter Rong", "12345678", "321202003630100000");
cus2 = Customer("Shaozhong Rong", "shaozhong.R", "122121198708030012");
cus3 = Customer("Sanai EE Llt.", "secretPassword", "121233200401211121");
cus4 = Customer("Nobody", "Nobody", "321202190208270022");

sampleCustomerSystem = CustomerSystem([cus1; cus2; cus3; cus4]);

cus1.addAccount("1234567890123456");
cus2.addAccount("1234123412341234");
cus2.addAccount("1203984712093849");
cus3.addAccount("8394049293049482");
cus3.addAccount("0053592669824525");

result = [cus1.getAccountNum(); cus2.getAccountNum(); cus3.getAccountNum(); cus4.getAccountNum()];
if (result == [1; 2; 2; 0])
    fprintf('Customer samples created!\n');
else
    fprintf('Customer samples test failed!\n');
end