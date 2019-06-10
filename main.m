close all;
clear all;

addPath();

fprintf("Using sample data to initiate database...\n");
[~, ~, ~, processor] = getSample();

fprintf("Initiating customer log in GUI...\n");
customerLogInUI = CustomerLogInUi(processor);

fprintf("Initiating ATM GUI...\n");
accountLogInUI = AccountLogInUi(processor, "0", 1);

fprintf("Initiating staff log in GUI...\n");
staffLogInUI = StaffLogInUi(processor);

fprintf("Initiating ticket system GUI...\n");
ticketSystemUi = TicketUi(processor);