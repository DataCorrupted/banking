classdef TicketUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Heading   matlab.ui.control.TextArea
        TextArea  matlab.ui.control.TextArea
        TakeaticketsitbackandwaitButton  matlab.ui.control.Button
    end

    
    properties (Access = private)
        processor % Description
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor)
            app.processor = processor;
            
            app.Heading.Value = Common.TicketUiHead;
            app.TextArea.Value = Common.TakeATicket;
        end

        % Button pushed function: TakeaticketsitbackandwaitButton
        function TakeaticketsitbackandwaitButtonPushed(app, event)
            app.TextArea.Value = Common.TakeTicketSuccessful + num2str(app.processor.getTail());
            app.processor.takeTicket();
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

            % Create Heading
            app.Heading = uitextarea(app.UIFigure);
            app.Heading.HandleVisibility = 'off';
            app.Heading.Editable = 'off';
            app.Heading.HorizontalAlignment = 'center';
            app.Heading.FontSize = 15;
            app.Heading.FontWeight = 'bold';
            app.Heading.Position = [159 364 324 28];
            app.Heading.Value = {'Place Holder'};

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Editable = 'off';
            app.TextArea.Position = [159 292 324 37];
            app.TextArea.Value = {'N/A'};

            % Create TakeaticketsitbackandwaitButton
            app.TakeaticketsitbackandwaitButton = uibutton(app.UIFigure, 'push');
            app.TakeaticketsitbackandwaitButton.ButtonPushedFcn = createCallbackFcn(app, @TakeaticketsitbackandwaitButtonPushed, true);
            app.TakeaticketsitbackandwaitButton.Position = [159 220 324 22];
            app.TakeaticketsitbackandwaitButton.Text = 'Take a ticket, sit back and wait';
        end
    end

    methods (Access = public)

        % Construct app
        function app = TicketUi(varargin)

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