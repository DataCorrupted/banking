classdef Common
    
    properties (Constant)
        LogInIdInvalid          = "Id does not exist";
        LogInWrongPassword      = "Wrong password";
        LogInSuccessful         = "Successful";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        InsufficientFund        = "Insufficient fund";
        InvalidAccount          = "Invalid account";
        InvalidAmount           = "The amount is not valid";
        IllegalSelfTransfer     = "Cannot transfer to the same account";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        PasswordValid           = "1";
        PasswordTooShort        = "This password is too short";
        PasswordEmpty           = "You have to give me a non-empty password";
        PasswordDiffer          = "Password mismatch, please retry.";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        NameEmpty               = "Please give me a valid legal name.";
        TermsDisagree           = "Please agree to whatever legal terms we have for you.";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        UIdValid                = "1";
        UIdWrongLength          = "This ID does not have 18 digits";
        UIdRegistered           = "This ID has been registered as a customer."
        UIdEmpty                = "ID field empty";
        UIdInValid              = "ID Doesn't exist";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        ATMLogInUiHead          = "Rong's Banking ATM System";
        AccountLogInUiHead      = "Rong's Banking Account System";
        CustomerLogInUiHead     = "Rong's Banking Customer System";
        StaffLogInUiHead        = "Rong's Banking Staff System";
        PromptUiHead            = "Rong's Banking Message";
        TicketUiHead            = "Rong's Banking Ticket System";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        NewAccountUiHead        = ["Fill in the following and you are good to go!"; 
                                    "Create an account at Rong's Banking, today!"];
        NewCustomerUiHead       = ["Register as a valued customer at Rong's Bank, today!";
                                    "Fill in the following and you are good to go!"];
        NewStaffUiHead          = "Register a new staff in Rong's Banking";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        TakeTicketSuccessful    = "You ave successfully taken a ticket."
        TakeATicket             = "Press to take a ticket. "
        TicketDepleted          = "No more tickets left."
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
   end
end

