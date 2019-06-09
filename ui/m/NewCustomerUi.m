classdef NewCustomerUi < matlab.apps.AppBase

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
        IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox  matlab.ui.control.CheckBox
        IwillregisterlaterButton      matlab.ui.control.Button
        RegisterNowButton             matlab.ui.control.Button
        Hints                         matlab.ui.control.TextArea
        PasswordEditFieldLabel_2      matlab.ui.control.Label
        PasswordEditFieldLabel_3      matlab.ui.control.Label
        PasswordEditFieldLabel_4      matlab.ui.control.Label
        PasswordEditFieldLabel_5      matlab.ui.control.Label
        IDEditFieldLabel              matlab.ui.control.Label
        IDEditField                   matlab.ui.control.EditField
    end

    
    properties (Access = public)
        passwordHider0
        passwordHider1
    end
    properties (Access = private)
        processor % Description
    end    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor)
            app.processor = processor;
            app.passwordHider0 = PasswordHider();
            app.passwordHider1 = PasswordHider();
            
            app.Head.Value = Common.NewCustomerUiHead;
        end

        % Button pushed function: IwillregisterlaterButton
        function IwillregisterlaterButtonPushed(app, event)
            app.delete;
        end

        % Button pushed function: RegisterNowButton
        function RegisterNowButtonPushed(app, event)
            id = app.IDEditField.Value;
            password0 = app.passwordHider0.getPassword();
            password1 = app.passwordHider1.getPassword();
            [isValidUId, retStr] = app.processor.isValidUId(id);
            if (~ isValidUId)
                app.Hints.Value = retStr;
                return
            end
            if (app.NameEditField.Value == "")
                app.Hints.Value = Common.NameEmpty;
                app.PasswordEditField.Value = "";
                app.RepeatPasswordEditField.Value = "";
            end
            retStr = app.processor.isValidPassword(password0, password1);
            if ~ strcmp(retStr, Common.PasswordValid)
                app.Hints.Value = retStr;
                app.PasswordEditField.Value = "";
                app.RepeatPasswordEditField.Value = "";
                return
            end
            if (~app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox.Value)
                app.Hints.Value = Common.TermsDisagree;
                app.PasswordEditField.Value = "";
                app.RepeatPasswordEditField.Value = "";
                return
            end
            name = app.NameEditField.Value;
            [retStr, customer] = app.processor.registerNewCustomer(name, password1, id);
            PromptUi(app.processor, retStr, customer);
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
            app.Head.Value = {'Place'; 'Holder'};

            % Create NameEditFieldLabel
            app.NameEditFieldLabel = uilabel(app.UIFigure);
            app.NameEditFieldLabel.Position = [128 293 100 22];
            app.NameEditFieldLabel.Text = 'Name';

            % Create NameEditField
            app.NameEditField = uieditfield(app.UIFigure, 'text');
            app.NameEditField.Position = [243 293 157 22];

            % Create PasswordEditFieldLabel
            app.PasswordEditFieldLabel = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel.Position = [128 249 100 22];
            app.PasswordEditFieldLabel.Text = 'Password';

            % Create PasswordEditField
            app.PasswordEditField = uieditfield(app.UIFigure, 'text');
            app.PasswordEditField.ValueChangingFcn = createCallbackFcn(app, @PasswordEditFieldValueChanging, true);
            app.PasswordEditField.Position = [243 249 157 22];

            % Create RepeatPasswordEditFieldLabel
            app.RepeatPasswordEditFieldLabel = uilabel(app.UIFigure);
            app.RepeatPasswordEditFieldLabel.Position = [128 205 100 22];
            app.RepeatPasswordEditFieldLabel.Text = 'Repeat Password';

            % Create RepeatPasswordEditField
            app.RepeatPasswordEditField = uieditfield(app.UIFigure, 'text');
            app.RepeatPasswordEditField.ValueChangingFcn = createCallbackFcn(app, @RepeatPasswordEditFieldValueChanging, true);
            app.RepeatPasswordEditField.Position = [243 205 157 22];

            % Create IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox
            app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox = uicheckbox(app.UIFigure);
            app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox.Text = 'I have agreed to some nonsense that nobody ever reads';
            app.IhaveagreedtosomenonsensethatnobodyeverreadsCheckBox.Position = [157 171 328 22];

            % Create IwillregisterlaterButton
            app.IwillregisterlaterButton = uibutton(app.UIFigure, 'push');
            app.IwillregisterlaterButton.ButtonPushedFcn = createCallbackFcn(app, @IwillregisterlaterButtonPushed, true);
            app.IwillregisterlaterButton.Position = [509 28 109 22];
            app.IwillregisterlaterButton.Text = 'I will register later';

            % Create RegisterNowButton
            app.RegisterNowButton = uibutton(app.UIFigure, 'push');
            app.RegisterNowButton.ButtonPushedFcn = createCallbackFcn(app, @RegisterNowButtonPushed, true);
            app.RegisterNowButton.Position = [272 83 100 22];
            app.RegisterNowButton.Text = 'Register Now!';

            % Create Hints
            app.Hints = uitextarea(app.UIFigure);
            app.Hints.Editable = 'off';
            app.Hints.Position = [128 122 399 33];

            % Create PasswordEditFieldLabel_2
            app.PasswordEditFieldLabel_2 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_2.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_2.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_2.Position = [401 249 114 22];
            app.PasswordEditFieldLabel_2.Text = 'At least 8 chars long';

            % Create PasswordEditFieldLabel_3
            app.PasswordEditFieldLabel_3 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_3.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_3.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_3.Position = [401 205 130 22];
            app.PasswordEditFieldLabel_3.Text = 'The same as password';

            % Create PasswordEditFieldLabel_4
            app.PasswordEditFieldLabel_4 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_4.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_4.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_4.Position = [401 293 91 22];
            app.PasswordEditFieldLabel_4.Text = 'Your legal name';

            % Create PasswordEditFieldLabel_5
            app.PasswordEditFieldLabel_5 = uilabel(app.UIFigure);
            app.PasswordEditFieldLabel_5.HorizontalAlignment = 'center';
            app.PasswordEditFieldLabel_5.FontColor = [0.502 0.502 0.502];
            app.PasswordEditFieldLabel_5.Position = [401 335 102 22];
            app.PasswordEditFieldLabel_5.Text = '18 digits, your UId';

            % Create IDEditFieldLabel
            app.IDEditFieldLabel = uilabel(app.UIFigure);
            app.IDEditFieldLabel.Position = [128 335 100 22];
            app.IDEditFieldLabel.Text = 'ID';

            % Create IDEditField
            app.IDEditField = uieditfield(app.UIFigure, 'text');
            app.IDEditField.Position = [243 335 157 22];
        end
    end

    methods (Access = public)

        % Construct app
        function app = NewCustomerUi(varargin)

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