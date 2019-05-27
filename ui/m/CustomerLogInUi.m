classdef CustomerLogInUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        UserIdEditFieldLabel    matlab.ui.control.Label
        UserIdEditField         matlab.ui.control.EditField
        LoginButton             matlab.ui.control.Button
        PasswordEditFieldLabel  matlab.ui.control.Label
        PasswordEditField       matlab.ui.control.EditField
        TextArea                matlab.ui.control.TextArea
        Head                    matlab.ui.control.TextArea
        NotavaluedcustomerRegisterNowButton  matlab.ui.control.Button
    end

    
    properties (Access = private)
        processor
        passwordHider
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor)
            app.processor = processor;
            app.Head.Value = Common.CustomerLogInUiHead;
            app.passwordHider = PasswordHider();
        end

        % Button pushed function: LoginButton
        function LoginButtonPushed(app, event)
            uid = app.UserIdEditField.Value;
            [retStr, customer] = app.processor.logInCustomer(uid, app.passwordHider.getPassword());
            app.TextArea.Value = retStr;
            if (strcmp(retStr, Common.LogInSuccessful))
                CustomerUi(app.processor, customer);
                app.delete;     % Shutdown this page.
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

        % Button pushed function: NotavaluedcustomerRegisterNowButton
        function NotavaluedcustomerRegisterNowButtonPushed(app, event)
            NewCustomerUi(app.processor);
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

            % Create UserIdEditFieldLabel
            app.UserIdEditFieldLabel = uilabel(app.UIFigure);
            app.UserIdEditFieldLabel.HorizontalAlignment = 'right';
            app.UserIdEditFieldLabel.Position = [180 324 44 22];
            app.UserIdEditFieldLabel.Text = 'User Id';

            % Create UserIdEditField
            app.UserIdEditField = uieditfield(app.UIFigure, 'text');
            app.UserIdEditField.Position = [236 324 163 22];

            % Create LoginButton
            app.LoginButton = uibutton(app.UIFigure, 'push');
            app.LoginButton.ButtonPushedFcn = createCallbackFcn(app, @LoginButtonPushed, true);
            app.LoginButton.Position = [180 230 219 22];
            app.LoginButton.Text = 'Log in';

            % Create PasswordEditFieldLabel
            app.PasswordEditFieldLabel = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel.HorizontalAlignment = 'right';
            app.PasswordEditFieldLabel.Position = [180 276 58 22];
            app.PasswordEditFieldLabel.Text = 'Password';

            % Create PasswordEditField
            app.PasswordEditField = uieditfield(app.UIFigure, 'text');
            app.PasswordEditField.ValueChangingFcn = createCallbackFcn(app, @PasswordEditFieldValueChanging, true);
            app.PasswordEditField.Position = [253 276 146 22];

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Editable = 'off';
            app.TextArea.Position = [203 130 173 37];
            app.TextArea.Value = {'Please type in your User Id and password to log in.'};

            % Create Head
            app.Head = uitextarea(app.UIFigure);
            app.Head.HandleVisibility = 'off';
            app.Head.Editable = 'off';
            app.Head.HorizontalAlignment = 'center';
            app.Head.FontSize = 15;
            app.Head.FontWeight = 'bold';
            app.Head.Position = [148 374 301 28];
            app.Head.Value = {'Place Holder'};

            % Create NotavaluedcustomerRegisterNowButton
            app.NotavaluedcustomerRegisterNowButton = uibutton(app.UIFigure, 'push');
            app.NotavaluedcustomerRegisterNowButton.ButtonPushedFcn = createCallbackFcn(app, @NotavaluedcustomerRegisterNowButtonPushed, true);
            app.NotavaluedcustomerRegisterNowButton.Position = [179.5 190 219 22];
            app.NotavaluedcustomerRegisterNowButton.Text = 'Not a valued customer? Register Now';
        end
    end

    methods (Access = public)

        % Construct app
        function app = CustomerLogInUi(varargin)

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