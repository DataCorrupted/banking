classdef AccountUi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        transferButton            matlab.ui.control.Button
        queryButton               matlab.ui.control.Button
        TextArea                  matlab.ui.control.TextArea
        TransfertoEditFieldLabel  matlab.ui.control.Label
        TransfertoEditField       matlab.ui.control.EditField
        AmountEditFieldLabel      matlab.ui.control.Label
        AmountEditField           matlab.ui.control.NumericEditField
        LogOutButton              matlab.ui.control.Button
        Welcome                   matlab.ui.control.Label
    end

    
    properties (Access = public)
        processor
        account
        isATM       % Decides whether this ui runs on ATM or customer's browser.
    end
    
    properties (Access = public)
        withdrawButton
        withdrawAmountEditField
        withdrawAmountEditFieldLabel
        depositButton
    end
    
    methods (Access = private)
        function createATMCompononts(app)
            % Create withdrawButton
            app.withdrawButton = uibutton(app.UIFigure, 'push');
            app.withdrawButton.ButtonPushedFcn = createCallbackFcn(app, @withdrawButtonPushed, true);
            app.withdrawButton.Position = [91 290 100 22];
            app.withdrawButton.Text = 'withdraw';
            
            % Create AmountEditField_2Label
            app.withdrawAmountEditFieldLabel = uilabel(app.UIFigure);
            app.withdrawAmountEditFieldLabel.HorizontalAlignment = 'right';
            app.withdrawAmountEditFieldLabel.Position = [222 290 47 22];
            app.withdrawAmountEditFieldLabel.Text = 'Amount';
            
            % Create EditField
            app.withdrawAmountEditField = uieditfield(app.UIFigure, 'numeric');
            app.withdrawAmountEditField.Position = [284 290 117 22];
            
            % Create depositButton
            app.depositButton = uibutton(app.UIFigure, 'push');
            app.depositButton.ButtonPushedFcn = createCallbackFcn(app, @depositButtonPushed, true);
            app.depositButton.Position = [91 242 100 22];
            app.depositButton.Text = 'deposit';            
        end
        function withdrawButtonPushed(app, ~)
            % We are assuming that ATM always have enough fund.
            amount = app.withdrawAmountEditField.Value;
            app.TextArea.Value = app.processor.withdraw(app.account, amount);
        end
        function depositButtonPushed(~, ~)
            % TODO
        end
    end
        

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, processor, account, isATM)
            app.processor = processor;
            app.account = account;
            app.isATM = isATM;
            
            if (app.isATM)
                app.createATMCompononts();
            end
            
            app.Welcome.Text = "Welcome! Your account id is: " + account.getId();
        end

        % Button pushed function: transferButton
        function transferButtonPushed(app, event)
            aid = app.TransfertoEditField.Value;
            amount = app.AmountEditField.Value;
            retStr = app.processor.transfer(app.account, aid, amount);
            app.TextArea.Value = retStr;
            app.AmountEditField.Value = 0;
        end

        % Button pushed function: queryButton
        function queryButtonPushed(app, event)
            app.TextArea.Value = app.processor.query(app.account);
        end

        % Button pushed function: LogOutButton
        function LogOutButtonPushed(app, event)
            if (app.isATM)
                app.processor.darkSpace = AccountLogInUi(app.processor, "0", app.isATM);
            end
            app.delete
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

            % Create transferButton
            app.transferButton = uibutton(app.UIFigure, 'push');
            app.transferButton.ButtonPushedFcn = createCallbackFcn(app, @transferButtonPushed, true);
            app.transferButton.Position = [91 390 100 22];
            app.transferButton.Text = 'transfer';

            % Create queryButton
            app.queryButton = uibutton(app.UIFigure, 'push');
            app.queryButton.ButtonPushedFcn = createCallbackFcn(app, @queryButtonPushed, true);
            app.queryButton.Position = [91 344 100 22];
            app.queryButton.Text = 'query';

            % Create TextArea
            app.TextArea = uitextarea(app.UIFigure);
            app.TextArea.Position = [91 119 293 60];
            app.TextArea.Value = {'What you gonna do with this account?'};

            % Create TransfertoEditFieldLabel
            app.TransfertoEditFieldLabel = uilabel(app.UIFigure);
            app.TransfertoEditFieldLabel.HorizontalAlignment = 'right';
            app.TransfertoEditFieldLabel.Position = [206 390 63 22];
            app.TransfertoEditFieldLabel.Text = 'Transfer to';

            % Create TransfertoEditField
            app.TransfertoEditField = uieditfield(app.UIFigure, 'text');
            app.TransfertoEditField.Position = [284 390 117 22];

            % Create AmountEditFieldLabel
            app.AmountEditFieldLabel = uilabel(app.UIFigure);
            app.AmountEditFieldLabel.HorizontalAlignment = 'right';
            app.AmountEditFieldLabel.Position = [429 390 47 22];
            app.AmountEditFieldLabel.Text = 'Amount';

            % Create AmountEditField
            app.AmountEditField = uieditfield(app.UIFigure, 'numeric');
            app.AmountEditField.Position = [491 390 100 22];

            % Create LogOutButton
            app.LogOutButton = uibutton(app.UIFigure, 'push');
            app.LogOutButton.ButtonPushedFcn = createCallbackFcn(app, @LogOutButtonPushed, true);
            app.LogOutButton.Position = [491 34 100 22];
            app.LogOutButton.Text = 'Log Out';

            % Create Welcome
            app.Welcome = uilabel(app.UIFigure);
            app.Welcome.Position = [91 432 339 22];
            app.Welcome.Text = 'Welcome! You account id is: ';
        end
    end

    methods (Access = public)

        % Construct app
        function app = AccountUi(varargin)

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