classdef StaffLogInUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        StaffIdEditFieldLabel   matlab.ui.control.Label
        StaffIdEditField        matlab.ui.control.EditField
        LogInButton             matlab.ui.control.Button
        PasswordEditFieldLabel  matlab.ui.control.Label
        PasswordEditField       matlab.ui.control.EditField
        TextArea                matlab.ui.control.TextArea
        Header                  matlab.ui.control.TextArea
    end

    
    properties (Access = public)
        passwordHider
    end
    properties (Access = private)
        processor
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor)
            app.processor = processor;
            app.passwordHider = PasswordHider();
            app.Header.Value = Common.StaffLogInUiHead;
        end

        % Button pushed function: LogInButton
        function LogInButtonPushed(app, event)
            uid = app.StaffIdEditField.Value;
            [retStr, staff] = app.processor.logInStaff(uid, app.passwordHider.getPassword);
            app.TextArea.Value = retStr;
            if (strcmp(retStr, Common.LogInSuccessful))
                app.processor.darkSpace = StaffUi(app.processor, staff);
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
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create StaffIdEditFieldLabel
            app.StaffIdEditFieldLabel = uilabel(app.UIFigure);
            app.StaffIdEditFieldLabel.HorizontalAlignment = 'right';
            app.StaffIdEditFieldLabel.Position = [220 322 43 22];
            app.StaffIdEditFieldLabel.Text = 'Staff Id';

            % Create StaffIdEditField
            app.StaffIdEditField = uieditfield(app.UIFigure, 'text');
            app.StaffIdEditField.Position = [275 322 103 22];

            % Create LogInButton
            app.LogInButton = uibutton(app.UIFigure, 'push');
            app.LogInButton.ButtonPushedFcn = createCallbackFcn(app, @LogInButtonPushed, true);
            app.LogInButton.Position = [201.5 230 174 22];
            app.LogInButton.Text = 'Log In';

            % Create PasswordEditFieldLabel
            app.PasswordEditFieldLabel = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel.HorizontalAlignment = 'right';
            app.PasswordEditFieldLabel.Position = [202 276 58 22];
            app.PasswordEditFieldLabel.Text = 'Password';

            % Create PasswordEditField
            app.PasswordEditField = uieditfield(app.UIFigure, 'text');
            app.PasswordEditField.ValueChangingFcn = createCallbackFcn(app, @PasswordEditFieldValueChanging, true);
            app.PasswordEditField.Position = [275 276 103 22];

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Editable = 'off';
            app.TextArea.Position = [202 177 173 37];
            app.TextArea.Value = {'Please type in your User Id and password to log in.'};

            % Create Header
            app.Header = uitextarea(app.UIFigure);
            app.Header.HandleVisibility = 'off';
            app.Header.Editable = 'off';
            app.Header.HorizontalAlignment = 'center';
            app.Header.FontSize = 15;
            app.Header.FontWeight = 'bold';
            app.Header.Position = [172 387 234 28];
            app.Header.Value = {'Place Holder'};
        end
    end

    methods (Access = public)

        % Construct app
        function app = StaffLogInUi(varargin)

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