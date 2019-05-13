classdef AccountLogInUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        PasswordEditFieldLabel   matlab.ui.control.Label
        PasswordEditField        matlab.ui.control.EditField
        LogInButton              matlab.ui.control.Button
        TextArea                 matlab.ui.control.TextArea
        AccountIdEditFieldLabel  matlab.ui.control.Label
        AccountIdEditField       matlab.ui.control.EditField
        Heading                  matlab.ui.control.TextArea
    end

    
    properties (Access = private)
        processor
        passwordHider
        aid
        isATM
    end

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor, aid, isATM)
            app.processor = processor;
            app.aid = aid;
            app.isATM = isATM;
            app.passwordHider = PasswordHider();
            
            if (~ isATM)
                app.AccountIdEditField.Value = aid;
                app.AccountIdEditField.Editable = false;
                app.Heading.Value = Common.AccountLogInUiHead;
            else
                app.Heading.Value = Common.ATMLogInUiHead;
            end
        end

        % Button pushed function: LogInButton
        function LogInButtonPushed(app, event)
            if (app.isATM)
                app.aid = app.AccountIdEditField.Value;
            end
            [retStr, account] = app.processor.logInAccount(app.aid, app.passwordHider.getPassword());
            if (strcmp(retStr, Common.LogInSuccessful))
                AccountUi(app.processor, account, app.isATM);
                app.delete;
            else
                app.TextArea.Value = retStr;
                app.PasswordEditField.Value = "";
            end
        end

        % Value changing function: PasswordEditField
        function PasswordEditFieldValueChanging(app, event)
            hider = app.passwordHider.updatePassword(event.Value);
            app.PasswordEditField.Value = hider;
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create PasswordEditFieldLabel
            app.PasswordEditFieldLabel = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel.HorizontalAlignment = 'right';
            app.PasswordEditFieldLabel.Position = [219 266 58 22];
            app.PasswordEditFieldLabel.Text = 'Password';

            % Create PasswordEditField
            app.PasswordEditField = uieditfield(app.UIFigure, 'text');
            app.PasswordEditField.ValueChangingFcn = createCallbackFcn(app, @PasswordEditFieldValueChanging, true);
            app.PasswordEditField.Position = [285 266 120 22];

            % Create LogInButton
            app.LogInButton = uibutton(app.UIFigure, 'push');
            app.LogInButton.ButtonPushedFcn = createCallbackFcn(app, @LogInButtonPushed, true);
            app.LogInButton.Position = [208 220 197 22];
            app.LogInButton.Text = 'Log In';

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Editable = 'off';
            app.TextArea.Position = [202 177 203 37];
            app.TextArea.Value = {'Please type in your Account Id and password to log in.'};

            % Create AccountIdEditFieldLabel
            app.AccountIdEditFieldLabel = uilabel(app.UIFigure);
            app.AccountIdEditFieldLabel.HorizontalAlignment = 'right';
            app.AccountIdEditFieldLabel.Position = [215 306 62 22];
            app.AccountIdEditFieldLabel.Text = 'Account Id';

            % Create AccountIdEditField
            app.AccountIdEditField = uieditfield(app.UIFigure, 'text');
            app.AccountIdEditField.Position = [285 306 120 22];

            % Create Heading
            app.Heading = uitextarea(app.UIFigure);
            app.Heading.HandleVisibility = 'off';
            app.Heading.Editable = 'off';
            app.Heading.HorizontalAlignment = 'center';
            app.Heading.FontSize = 15;
            app.Heading.FontWeight = 'bold';
            app.Heading.Position = [144 365 324 28];
            app.Heading.Value = {'Place Holder'};
        end
    end

    methods (Access = public)

        % Construct app
        function app = AccountLogInUi(varargin)

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end