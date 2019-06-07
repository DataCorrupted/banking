classdef PublicMessageUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        TextArea  matlab.ui.control.TextArea
    end

    
    methods (Access = public)
        
        function updateMessage(app, message)
            app.TextArea.Value = message;
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
            app.TextArea.Editable = 'off';
            app.TextArea.Position = [159 292 324 37];
            app.TextArea.Value = {'This is staff public message ui'};
        end
    end

    methods (Access = public)

        % Construct app
        function app = PublicMessageUi

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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