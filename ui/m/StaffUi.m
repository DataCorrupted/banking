classdef StaffUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        NewCustomerButton    matlab.ui.control.Button
        NewAccountButton     matlab.ui.control.Button
        NewStaffButton       matlab.ui.control.Button
        LogOutButton         matlab.ui.control.Button
        ManageAccountButton  matlab.ui.control.Button
        ManageStaffButton    matlab.ui.control.Button
        NextCustomerButton   matlab.ui.control.Button
    end

    
    properties (Access = private)
        staff
        publicMessageUi
        processor
    end
    
    methods (Access = public)
        function update(~)
        end
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor, staff)
            app.staff = staff;
            app.processor = processor;
            app.publicMessageUi = PublicMessageUi;
        end

        % Button pushed function: LogOutButton
        function LogOutButtonPushed(app, event)
            app.processor.darkSpace = StaffLogInUi(app.processor);
            app.publicMessageUi.delete;
            app.delete;
        end

        % Button pushed function: NewCustomerButton
        function NewCustomerButtonPushed(app, event)
            app.processor.darkSpace = NewCustomerUi(app.processor);
        end

        % Button pushed function: NewAccountButton
        function NewAccountButtonPushed(app, event)
            app.processor.darkSpace = NewAccountUi(app.processor, [], 1, app);
        end

        % Button pushed function: NewStaffButton
        function NewStaffButtonPushed(app, event)
            if (~ app.staff.isManager())
                return
            end
            app.processor.darkSpace = NewStaffUi(app.processor);
        end

        % Button pushed function: NextCustomerButton
        function NextCustomerButtonPushed(app, event)
            retStr = app.processor.callTicket();
            app.publicMessageUi.updateMessage(retStr);
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

            % Create NewCustomerButton
            app.NewCustomerButton = uibutton(app.UIFigure, 'push');
            app.NewCustomerButton.ButtonPushedFcn = createCallbackFcn(app, @NewCustomerButtonPushed, true);
            app.NewCustomerButton.Position = [92 366 100 22];
            app.NewCustomerButton.Text = 'New Customer';

            % Create NewAccountButton
            app.NewAccountButton = uibutton(app.UIFigure, 'push');
            app.NewAccountButton.ButtonPushedFcn = createCallbackFcn(app, @NewAccountButtonPushed, true);
            app.NewAccountButton.Position = [92 317 100 22];
            app.NewAccountButton.Text = 'New Account';

            % Create NewStaffButton
            app.NewStaffButton = uibutton(app.UIFigure, 'push');
            app.NewStaffButton.ButtonPushedFcn = createCallbackFcn(app, @NewStaffButtonPushed, true);
            app.NewStaffButton.Position = [92 215 100 22];
            app.NewStaffButton.Text = 'New Staff';

            % Create LogOutButton
            app.LogOutButton = uibutton(app.UIFigure, 'push');
            app.LogOutButton.ButtonPushedFcn = createCallbackFcn(app, @LogOutButtonPushed, true);
            app.LogOutButton.Position = [491 52 100 22];
            app.LogOutButton.Text = 'Log Out';

            % Create ManageAccountButton
            app.ManageAccountButton = uibutton(app.UIFigure, 'push');
            app.ManageAccountButton.Position = [92 267 106 22];
            app.ManageAccountButton.Text = 'Manage Account';

            % Create ManageStaffButton
            app.ManageStaffButton = uibutton(app.UIFigure, 'push');
            app.ManageStaffButton.Position = [92 165 100 22];
            app.ManageStaffButton.Text = 'Manage Staff';

            % Create NextCustomerButton
            app.NextCustomerButton = uibutton(app.UIFigure, 'push');
            app.NextCustomerButton.ButtonPushedFcn = createCallbackFcn(app, @NextCustomerButtonPushed, true);
            app.NextCustomerButton.Position = [355 52 100 22];
            app.NextCustomerButton.Text = 'Next Customer';
        end
    end

    methods (Access = public)

        % Construct app
        function app = StaffUi(varargin)

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