close all


addpath('./account');
addpath('./challenge');
addpath('./common');
addpath('./customer');
addpath('./entity');
addpath('./staff');
addpath('./test');
addpath('./ui');

TestAccount; 
accountSystem = testAccountSystem;

TestCustomer;
customerSystem = testCustomerSystem;

processor = Processor(accountSystem, customerSystem);

customerLogInUI = CustomerLogInUi(processor);
accountLogInUI = AccountLogInUi(processor, '0', 1);