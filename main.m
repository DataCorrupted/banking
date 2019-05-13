close all;
clear all;

addpath('./account');
addpath('./challenge');
addpath('./common');
addpath('./customer');
addpath('./entity');
addpath('./staff');
addpath('./test');
addpath('./ui/mlapp');

TestAccount; 
accountSystem = testAccountSystem;

TestCustomer;
customerSystem = testCustomerSystem;

TestStaff;
staffSystem = testStaffSystem;

fprintf("Using test data to initiate database...\n");
processor = Processor(accountSystem, customerSystem, staffSystem);

fprintf("Initiating customer log in GUI...\n");
customerLogInUI = CustomerLogInUi(processor);
fprintf("Initiating ATM GUI...\n");
accountLogInUI = AccountLogInUi(processor, "0", 1);
fprintf("Initiating staff log in GUI...\n");
staffLogInUI = StaffLogInUi(processor);

