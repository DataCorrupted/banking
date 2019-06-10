function testUi()
    runtests('TestAccountUiFromATM')
    pause(Common.PauseTime);
    runtests('TestCustomerLogInUi')
    pause(Common.PauseTime);
    runtests('TestNewAccountUiFromCustomer')
    pause(Common.PauseTime);
    runtests('TestNewCustomerUi')
    pause(Common.PauseTime);
    runtests('TestStaffLogInUi')
    pause(Common.PauseTime);
    runtests('TestTicketUi')
    pause(Common.PauseTime);
    runtests('TestAccountLogInUi')
    pause(Common.PauseTime);
    runtests('TestAccountUiFromCustomerUi')
    pause(Common.PauseTime);
    runtests('TestCustomerUi')
    pause(Common.PauseTime);
    runtests('TestNewAccountUiFromStaff')
    pause(Common.PauseTime);
    runtests('TestNewStaffUi')
    pause(Common.PauseTime);
    runtests('TestStaffUi')
    pause(Common.PauseTime);
end

