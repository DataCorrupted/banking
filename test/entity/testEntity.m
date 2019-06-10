function testEntity()
    runtests('TestAccount')
    pause(Common.PauseTime);
    runtests('TestCustomer')
    pause(Common.PauseTime);
    runtests('TestStaff')
    pause(Common.PauseTime);
end

