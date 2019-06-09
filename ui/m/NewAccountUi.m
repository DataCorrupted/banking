classdef NewAccountUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        Head                          matlab.ui.control.TextArea
        YourUidEditFieldLabel         matlab.ui.control.Label
        YourUidEditField              matlab.ui.control.EditField
        PasswordEditFieldLabel        matlab.ui.control.Label
        PasswordEditField             matlab.ui.control.EditField
        RepeatPasswordEditFieldLabel  matlab.ui.control.Label
        RepeatPasswordEditField       matlab.ui.control.EditField
        IwillregisterlaterButton      matlab.ui.control.Button
        RegisterNowButton             matlab.ui.control.Button
        Hints                         matlab.ui.control.TextArea
        PasswordEditFieldLabel_2      matlab.ui.control.Label
        PasswordEditFieldLabel_3      matlab.ui.control.Label
    end

    
    properties (Access = public)
        passwordHider0
        passwordHider1
    end
    properties (Access = private)
        processor % Description
        customer
        isStaff
        lastApp
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor, customer, isStaff, lastApp)
            app.processor = processor;
            app.customer = customer;
            app.isStaff = isStaff;
            app.lastApp = lastApp;
            app.passwordHider0 = PasswordHider;
            app.passwordHider1 = PasswordHider;
            
            if (~ app.isStaff)
                app.YourUidEditField.Value = customer.getId();
                app.YourUidEditField.Editable = false;
            end
            app.Head.Value = Common.NewAccountUiHead;
        end

        % Button pushed function: IwillregisterlaterButton
        function IwillregisterlaterButtonPushed(app, event)
            app.delete;
        end

        % Button pushed function: RegisterNowButton
        function RegisterNowButtonPushed(app, event)
            [retStr, isExisting] = app.processor.isExistingUId(app.YourUidEditField.Value);
            password0 = app.passwordHider0.getPassword();
            password1 = app.passwordHider1.getPassword();
            if (~ isExisting)
                app.Hints.Value = retStr;
                app.PasswordEditField.Value = "";
                app.RepeatPasswordEditField.Value = "";
                return;
            end
            retStr = app.processor.isValidPassword(password0, password1);
            if ~ strcmp(retStr, Common.PasswordValid)
                app.Hints.Value = retStr;
                app.PasswordEditField.Value = "";
                app.RepeatPasswordEditField.Value = "";
                return
            end
            [retStr, account] = app.processor.registerNewAccount(app.YourUidEditField.Value, password1);
            PromptUi(app.processor, retStr, account);
            % If the user is creating account on he's own, 
            % a new user window should pop up on account creating.
            app.lastApp.update();
            app.delete;
        end

        % Value changing function: PasswordEditField
        function PasswordEditFieldValueChanging(app, event)
            hider = app.passwordHider0.updatePassword(event.Value);
            app.PasswordEditField.Value = hider;
        end

        % Value changing function: RepeatPasswordEditField
        function RepeatPasswordEditFieldValueChanging(app, event)
            hider = app.passwordHider1.updatePassword(event.Value);
            app.RepeatPasswordEditField.Value = hider;     
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

            % Create Head
            app.Head = uitextarea(app.UIFigure);
            app.Head.Editable = 'off';
            app.Head.HorizontalAlignment = 'center';
            app.Head.FontSize = 15;
            app.Head.FontWeight = 'bold';
            app.Head.Position = [115 382 412 46];
            app.Head.Value = {'Place '; 'Holder'};

            % Create YourUidEditFieldLabel
            app.YourUidEditFieldLabel = uilabel(app.UIFigure);
            app.YourUidEditFieldLabel.HorizontalAlignment = 'center';
            app.YourUidEditFieldLabel.Position = [115 318 100 22];
            app.YourUidEditFieldLabel.Text = 'Your Uid';

            % Create YourUidEditField
            app.YourUidEditField = uieditfield(app.UIFigure, 'text');
            app.YourUidEditField.Position = [230 318 172 22];

            % Create PasswordEditFieldLabel
            app.PasswordEditFieldLabel = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel.Position = [115 274 100 22];
            app.PasswordEditFieldLabel.Text = 'Password';

            % Create PasswordEditField
            app.PasswordEditField = uieditfield(app.UIFigure, 'text');
            app.PasswordEditField.ValueChangingFcn = createCallbackFcn(app, @PasswordEditFieldValueChanging, true);
            app.PasswordEditField.Position = [230 274 172 22];

            % Create RepeatPasswordEditFieldLabel
            app.RepeatPasswordEditFieldLabel = uilabel(app.UIFigure);
            app.RepeatPasswordEditFieldLabel.HorizontalAlignment = 'right';
            app.RepeatPasswordEditFieldLabel.Position = [115 230 100 22];
            app.RepeatPasswordEditFieldLabel.Text = 'Repeat Password';

            % Create RepeatPasswordEditField
            app.RepeatPasswordEditField = uieditfield(app.UIFigure, 'text');
            app.RepeatPasswordEditField.ValueChangingFcn = createCallbackFcn(app, @RepeatPasswordEditFieldValueChanging, true);
            app.RepeatPasswordEditField.Position = [230 230 172 22];

            % Create IwillregisterlaterButton
            app.IwillregisterlaterButton = uibutton(app.UIFigure, 'push');
            app.IwillregisterlaterButton.ButtonPushedFcn = createCallbackFcn(app, @IwillregisterlaterButtonPushed, true);
            app.IwillregisterlaterButton.Position = [509 28 109 22];
            app.IwillregisterlaterButton.Text = 'I will register later';

            % Create RegisterNowButton
            app.RegisterNowButton = uibutton(app.UIFigure, 'push');
            app.RegisterNowButton.ButtonPushedFcn = createCallbackFcn(app, @RegisterNowButtonPushed, true);
            app.RegisterNowButton.Position = [266 107 100 22];
            app.RegisterNowButton.Text = 'Register Now!';

            % Create Hints
            app.Hints = uitextarea(app.UIFigure);
            app.Hints.Editable = 'off';
            app.Hints.Position = [115 156 412 29];

            % Create PasswordEditFieldLabel_2
            app.PasswordEditFieldLabel_2 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_2.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_2.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_2.Position = [407 274 114 22];
            app.PasswordEditFieldLabel_2.Text = 'At least 8 chars long';

            % Create PasswordEditFieldLabel_3
            app.PasswordEditFieldLabel_3 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_3.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_3.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_3.Position = [407 230 130 22];
            app.PasswordEditFieldLabel_3.Text = 'The same as password';
        end
    end

    methods (Access = public)

        % Construct app
        function app = NewAccountUi(varargin)

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