function testCommon()
    runtests('TestPasswordHider')
    pause(Common.PauseTime);
    runtests('TestProcessor')
    pause(Common.PauseTime);
end

