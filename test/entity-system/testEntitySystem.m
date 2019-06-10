function testEntitySystem()
    runtests('TestAccountSystem')
    pause(Common.PauseTime);
    runtests('TestCustomerSystem')
    pause(Common.PauseTime);
    runtests('TestStaffSystem')
    pause(Common.PauseTime);
end

