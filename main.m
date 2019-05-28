close all;
clear all;

addPath();

fprintf("Using test data to initiate database...\n");
[~, ~, ~, processor] = getSample();

fprintf("Initiating customer log in GUI...\n");
customerLogInUI = CustomerLogInUi(processor);

fprintf("Initiating ATM GUI...\n");
accountLogInUI = AccountLogInUi(processor, "0", 1);

fprintf("Initiating staff log in GUI...\n");
staffLogInUI = StaffLogInUi(processor);

