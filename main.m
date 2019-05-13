close all;
clear all;

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

TestStaff;
staffSystem = testStaffSystem;

processor = Processor(accountSystem, customerSystem, staffSystem);

%customerLogInUI = CustomerLogInUi(processor);
%accountLogInUI = AccountLogInUi(processor, "0", 1);
staffLogInUI = StaffLogInUi(processor);