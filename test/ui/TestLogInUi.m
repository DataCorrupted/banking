classdef TestLogInUi < matlab.uitest.TestCase
    properties (Access = private)
        processor
        app
    end
    methods (TestMethodSetup)
        function createTestLogInUi(t)
            [~, ~, ~, t.processor] = getSample();
            t.app = AccountLogInUi(t.processor, 0, 1);
            t.addTeardown(@delete,t.processor.darkSpace);
        end
    end

    methods (Test)
        function testLogInSuccessful(t)
            % t.type(t.app.AccountIdEditField.Value, 1);

            t.verifyEqual(class(t.processor.darkSpace), "AccountUi");
        end
    end
end

