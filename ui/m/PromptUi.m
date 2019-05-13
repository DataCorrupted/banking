classdef PromptUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure        matlab.ui.Figure
        TextArea        matlab.ui.control.TextArea
        Head            matlab.ui.control.TextArea
        ContinueButton  matlab.ui.control.Button
        CloseButton     matlab.ui.control.Button
    end

    
    properties (Access = private)
        entity
        processor
        continueCallBack
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor, displayString, entity)
            app.processor = processor;
            app.entity = entity;
            
            app.TextArea.Value = displayString;
            app.Head.Value = Common.PromptUiHead;
        end

        % Button pushed function: CloseButton
        function CloseButtonPushed(app, event)
            app.delete
        end

        % Button pushed function: ContinueButton
        function ContinueButtonPushed(app, event)
            type = class(app.entity);
            if (strcmp(type, "Customer"))
                CustomerUi(app.processor, app.entity);
            end
            if (strcmp(type, "Account"))
                AccountUi(app.processor, app.entity, 0);
            end
            if (strcmp(type, "Staff"))
                StaffUi(app.processor, app.entity);
            end
            app.delete;
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

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Position = [192 295 257 60];

            % Create Head
            app.Head = uitextarea(app.UIFigure);
            app.Head.HandleVisibility = 'off';
            app.Head.HorizontalAlignment = 'center';
            app.Head.FontSize = 15;
            app.Head.FontWeight = 'bold';
            app.Head.Position = [204 395 234 28];
            app.Head.Value = {'Place Holder'};

            % Create ContinueButton
            app.ContinueButton = uibutton(app.UIFigure, 'push');
            app.ContinueButton.ButtonPushedFcn = createCallbackFcn(app, @ContinueButtonPushed, true);
            app.ContinueButton.Position = [192 230 100 22];
            app.ContinueButton.Text = 'Continue';

            % Create CloseButton
            app.CloseButton = uibutton(app.UIFigure, 'push');
            app.CloseButton.ButtonPushedFcn = createCallbackFcn(app, @CloseButtonPushed, true);
            app.CloseButton.Position = [349 230 100 22];
            app.CloseButton.Text = 'Close';
        end
    end

    methods (Access = public)

        % Construct app
        function app = PromptUi(varargin)

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