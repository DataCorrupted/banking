classdef PinChallenge < Challenge
    %PINCHALLENGE Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Access = public)
        function this = PinChallenge(name)
            this@Challenge(name);
        end
        
        function passed = challenge(this)
            % Randomly generate a pin
            randomPin = 132456;
            
            % From GUI take user contact
            
            % Send the pin out.
            
            % Get user input from GUI
            inputPin = 123456;
            
            passed = (randomPin == inputPin);
        end
    end
end

