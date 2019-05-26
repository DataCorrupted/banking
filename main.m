close all;
clear all;

addpath('./challenge');
addpath('./common');
addpath('./entity');
addpath('./entity-system')
addpath('./sample');
addpath('./ui/mlapp');
addpath('./test')

SampleAccount; 
accountSystem = sampleAccountSystem;

SampleCustomer;
customerSystem = sampleCustomerSystem;

SampleStaff;
staffSystem = sampleStaffSystem;

fprintf("Using test data to initiate database...\n");
processor = Processor(accountSystem, customerSystem, staffSystem);

fprintf("Initiating customer log in GUI...\n");
customerLogInUI = CustomerLogInUi(processor);
fprintf("Initiating ATM GUI...\n");
accountLogInUI = AccountLogInUi(processor, "0", 1);
fprintf("Initiating staff log in GUI...\n");
staffLogInUI = StaffLogInUi(processor);

