acc1 = Account("1234567890123456", "123456");
acc2 = Account("1234123412341234", "654123");
acc3 = Account("8394049293049482", "789654");
acc4 = Account("0053592669824525", "562851");
acc5 = Account("1203984712093849", "324503");

sampleAccountSystem = AccountSystem([acc1; acc2; acc3; acc4; acc5]);

% Remains:
% 
% acc1: 1800
% acc2: 1700
% acc3: 8700
% acc4: 700
% acc5: 0
acc1.deposit(1200);
acc2.deposit(1000);
acc1.transferTo(acc4, 400);
acc2.transferTo(acc4, 300);
acc3.deposit(700);
acc5.withdraw(100);
acc3.deposit(10000);
acc3.transferTo(acc1, 1000);
acc3.transferTo(acc2, 1000);

result = [acc1.query(); acc2.query(); acc3.query(); acc4.query(); acc5.query()];
if (result == [1800; 1700; 8700; 700; 0])
    fprintf('Account samples created!\n');
else
    fprintf('Account samples test failed!\n');
end