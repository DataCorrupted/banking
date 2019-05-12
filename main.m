close all

addpath('./entity');
addpath('./account');
addpath('./challenge');
addpath('./customer');
addpath('./staff');
addpath('./ui');

customerSystem = CustomerSystem(IndividualCustomer('1234', '1234', '1234', '1234'));
accountSystem = AccountSystem([]);

processor = Processor(accountSystem, customerSystem);

customerlogInUI = CustomerLogInUi(processor);