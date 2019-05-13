classdef DummyChallenge < Challenge
    %DUMMYCHALLENGE Summary of this class goes here
    %   Detailed explanation goes here
    methods
        function this = DummyChallenge()
            this@Challenge("DummyChallenge");
        end
        
        function passed = doChallenge(~)
            passed = true;
        end
    end
end

