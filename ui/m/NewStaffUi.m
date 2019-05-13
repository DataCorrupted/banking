classdef NewStaffUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        Head                          matlab.ui.control.TextArea
        NameEditFieldLabel            matlab.ui.control.Label
        NameEditField                 matlab.ui.control.EditField
        PasswordEditFieldLabel        matlab.ui.control.Label
        PasswordEditField             matlab.ui.control.EditField
        RepeatPasswordEditFieldLabel  matlab.ui.control.Label
        RepeatPasswordEditField       matlab.ui.control.EditField
        ThisisamanagerthathasalofofrightsCheckBox  matlab.ui.control.CheckBox
        IwillregisterlaterButton      matlab.ui.control.Button
        RegisterNowButton             matlab.ui.control.Button
        Hints                         matlab.ui.control.TextArea
        PasswordEditFieldLabel_2      matlab.ui.control.Label
        PasswordEditFieldLabel_3      matlab.ui.control.Label
        PasswordEditFieldLabel_4      matlab.ui.control.Label
    end

    
    properties (Access = private)
        processor % Description
        passwordHider0
        passwordHider1
    end    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor)
            app.processor = processor;
            app.passwordHider0 = PasswordHider();
            app.passwordHider1 = PasswordHider();
            
            app.Head.Value = Common.NewStaffUiHead;
        end

        % Button pushed function: IwillregisterlaterButton
        function IwillregisterlaterButtonPushed(app, event)
            app.delete;
        end

        % Button pushed function: RegisterNowButton
        function RegisterNowButtonPushed(app, event)
            name = app.NameEditField.Value;
            password0 = app.passwordHider0.getPassword();
            password1 = app.passwordHider1.getPassword();
            if (name == "")
                app.Hints.Value = Common.NameEmpty;
            end
            retStr = app.processor.isValidPassword(password0, password1);
            if ~ strcmp(retStr, Common.PasswordValid)
                app.Hints.Value = retStr;
                app.PasswordEditField.Value = "";
                app.RepeatPasswordEditField.Value = "";
                return
            end
            isManager = app.ThisisamanagerthathasalofofrightsCheckBox.Value;
            [retStr, staff] = app.processor.registerNewStaff(name, password1, isManager);
            PromptUi(app.processor, retStr, staff);
            app.delete;
        end

        % Value changing function: PasswordEditField
        function PasswordEditFieldValueChanging(app, event)
            k = length(event.Value);
            % Delete happened, we do not allow user to delete 
            % since event will not tell us what was deleted
            if (k <= strlength(app.password0))
                app.PasswordEditField.Value = "";
                app.password0= "";
                return
            else
                app.password0 = app.password0 + event.Value(k);
                app.PasswordEditField.Value = app.PasswordEditField.Value + "*";
            end
        end

        % Value changing function: RepeatPasswordEditField
        function RepeatPasswordEditFieldValueChanging(app, event)
            k = length(event.Value);
            % Delete happened, we do not allow user to delete 
            % since event will not tell us what was deleted
            if (k <= strlength(app.password1))
                app.RepeatPasswordEditField.Value = "";
                app.password1= "";
                return
            else
                app.password1 = app.password1 + event.Value(k);
                app.RepeatPasswordEditField.Value = app.RepeatPasswordEditField.Value + "*";
            end        
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
            app.Head.Position = [115 374 435 34];
            app.Head.Value = {'Place Holder'};

            % Create NameEditFieldLabel
            app.NameEditFieldLabel = uilabel(app.UIFigure);
            app.NameEditFieldLabel.Position = [163 318 100 22];
            app.NameEditFieldLabel.Text = 'Name';

            % Create NameEditField
            app.NameEditField = uieditfield(app.UIFigure, 'text');
            app.NameEditField.Position = [278 318 100 22];

            % Create PasswordEditFieldLabel
            app.PasswordEditFieldLabel = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel.Position = [163 274 100 22];
            app.PasswordEditFieldLabel.Text = 'Password';

            % Create PasswordEditField
            app.PasswordEditField = uieditfield(app.UIFigure, 'text');
            app.PasswordEditField.ValueChangingFcn = createCallbackFcn(app, @PasswordEditFieldValueChanging, true);
            app.PasswordEditField.Position = [278 274 100 22];

            % Create RepeatPasswordEditFieldLabel
            app.RepeatPasswordEditFieldLabel = uilabel(app.UIFigure);
            app.RepeatPasswordEditFieldLabel.Position = [163 230 100 22];
            app.RepeatPasswordEditFieldLabel.Text = 'Repeat Password';

            % Create RepeatPasswordEditField
            app.RepeatPasswordEditField = uieditfield(app.UIFigure, 'text');
            app.RepeatPasswordEditField.ValueChangingFcn = createCallbackFcn(app, @RepeatPasswordEditFieldValueChanging, true);
            app.RepeatPasswordEditField.Position = [278 230 100 22];

            % Create ThisisamanagerthathasalofofrightsCheckBox
            app.ThisisamanagerthathasalofofrightsCheckBox = uicheckbox(app.UIFigure);
            app.ThisisamanagerthathasalofofrightsCheckBox.Text = 'This is a manager that has a lof of rights';
            app.ThisisamanagerthathasalofofrightsCheckBox.Position = [214 192 237 22];

            % Create IwillregisterlaterButton
            app.IwillregisterlaterButton = uibutton(app.UIFigure, 'push');
            app.IwillregisterlaterButton.ButtonPushedFcn = createCallbackFcn(app, @IwillregisterlaterButtonPushed, true);
            app.IwillregisterlaterButton.Position = [509 28 109 22];
            app.IwillregisterlaterButton.Text = 'I will register later';

            % Create RegisterNowButton
            app.RegisterNowButton = uibutton(app.UIFigure, 'push');
            app.RegisterNowButton.ButtonPushedFcn = createCallbackFcn(app, @RegisterNowButtonPushed, true);
            app.RegisterNowButton.Position = [278 90 100 22];
            app.RegisterNowButton.Text = 'Register Now!';

            % Create Hints
            app.Hints = uitextarea(app.UIFigure);
            app.Hints.Editable = 'off';
            app.Hints.Position = [115 135 435 41];

            % Create PasswordEditFieldLabel_2
            app.PasswordEditFieldLabel_2 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_2.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_2.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_2.Position = [380 274 114 22];
            app.PasswordEditFieldLabel_2.Text = 'At least 8 chars long';

            % Create PasswordEditFieldLabel_3
            app.PasswordEditFieldLabel_3 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_3.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_3.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_3.Position = [380 230 130 22];
            app.PasswordEditFieldLabel_3.Text = 'The same as password';

            % Create PasswordEditFieldLabel_4
            app.PasswordEditFieldLabel_4 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_4.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_4.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_4.Position = [380 318 91 22];
            app.PasswordEditFieldLabel_4.Text = 'Your legal name';
        end
    end

    methods (Access = public)

        % Construct app
        function app = NewStaffUi(varargin)

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