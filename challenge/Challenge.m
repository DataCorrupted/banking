classdef Challenge < handle
    properties (Access = protected)
        name
        secret
        timestamp
    end
    
    properties (Constant)
        secretLen = 6;
    end

    methods (Access = protected)
        function this = Challenge(name)
            this.name = name;
        end
        function generateChallenge(this)
            this.generateSecret();
            this.timestamp = clock;
        end
        function passed = doChallenge(secret)
            passed = strcmp(secret, this.secret) && etime(clock, this.timestamp) < 60;
        end

        function this = generateSecret(this)
            symbols = ['a':'z' 'A':'Z' '0':'9'];
            sec = randi(numel(symbols),[1 this.secretLen]);
            this.secret = string(symbols(sec));
        end

    end
end

