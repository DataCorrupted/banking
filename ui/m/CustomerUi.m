classdef CustomerUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        TextArea              matlab.ui.control.TextArea
        LogoutButton          matlab.ui.control.Button
        AccountDropDownLabel  matlab.ui.control.Label
        AccountDropDown       matlab.ui.control.DropDown
        ManageButton          matlab.ui.control.Button
        NewAccountButton      matlab.ui.control.Button
    end

    
    properties (Access = public)
        processor
        customer
    end
    
    methods (Access = public)
        function update(app)
            app.AccountDropDown.Items = app.customer.getAccounts();
        end
    end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor, customer)
            app.processor = processor;
            app.customer = customer;
            
            app.TextArea.Value = "Welcome " + app.customer.getName() + newline + " Please select an account to manage";
            accounts =  app.customer.getAccounts();
            if (isempty(accounts))
                app.AccountDropDown.Items = ("No Account Available");
                app.ManageButton.Enable = false;
            else
                app.AccountDropDown.Items = accounts;
            end
        end

        % Button pushed function: LogoutButton
        function LogoutButtonPushed(app, event)
            CustomerLogInUi(app.processor);
            app.delete;
        end

        % Button pushed function: ManageButton
        function ManageButtonPushed(app, event)
            aid = app.AccountDropDown.Value;
            isATM = 0;
            AccountLogInUi(app.processor, aid, isATM);
        end

        % Button pushed function: NewAccountButton
        function NewAccountButtonPushed(app, event)
            NewAccountUi(app.processor, app.customer, 0, app);
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
            app.TextArea.Position = [72 370 224 60];

            % Create LogoutButton
            app.LogoutButton = uibutton(app.UIFigure, 'push');
            app.LogoutButton.ButtonPushedFcn = createCallbackFcn(app, @LogoutButtonPushed, true);
            app.LogoutButton.Position = [525 18 100 22];
            app.LogoutButton.Text = 'Log out';

            % Create AccountDropDownLabel
            app.AccountDropDownLabel = uilabel(app.UIFigure);
            app.AccountDropDownLabel.HorizontalAlignment = 'right';
            app.AccountDropDownLabel.Position = [215 298 49 22];
            app.AccountDropDownLabel.Text = 'Account';

            % Create AccountDropDown
            app.AccountDropDown = uidropdown(app.UIFigure);
            app.AccountDropDown.Position = [279 298 147 22];

            % Create ManageButton
            app.ManageButton = uibutton(app.UIFigure, 'push');
            app.ManageButton.ButtonPushedFcn = createCallbackFcn(app, @ManageButtonPushed, true);
            app.ManageButton.Position = [72 298 100 22];
            app.ManageButton.Text = 'Manage';

            % Create NewAccountButton
            app.NewAccountButton = uibutton(app.UIFigure, 'push');
            app.NewAccountButton.ButtonPushedFcn = createCallbackFcn(app, @NewAccountButtonPushed, true);
            app.NewAccountButton.Position = [72 248 100 22];
            app.NewAccountButton.Text = 'New Account';
        end
    end

    methods (Access = public)

        % Construct app
        function app = CustomerUi(varargin)

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