classdef DummyChallenge < Challenge
    %DUMMYCHALLENGE Summary of this class goes here
    %   Detailed explanation goes here
    methods
        function this = DummyChallenge(name)
            this@Challenge(name);
        end
        
        function passed = challenge(this)
            passed = true;
        end
    end
end

