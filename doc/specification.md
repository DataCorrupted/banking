# Specification

## S1 Log In
On all id and password information provided, check with target systems if the entity exists.
### S1.1 Exist
Get the instance of that entity, pass it to create the next Ui interface.
### S1.2 Error
Stay on the same window, provide with error information.
### S1.3 Log Out

## S2 CustomerUi
### S2.1 New Account
Switch to new Account window
### S2.2 Manage Account
Switch to AccountUi according to the account selected.

## S3 AccountUi
### S3.1 Transfer
- If the information is correct, make the transfer
- If any information is not(wrong id, invalid amount, insuficient amount, etc.), stop.
### S3.2 Query
Show the amount of money the customer has.
### S3.3 Withdraw
- If the information is correct, withdraw
- If any information is not(invalid amount, insuficient amount, etc.), stop.
### S3.4 Deposit
Save money.

## S4 StaffUi
### S4.1 New eneity
Switch to new entity page.
### S4.2 Manage Account
Switch to S3
### S4.3 Call next
If the next customer doesn't show up after 3rd call, call again and it will switch automatically.

## S5 TicketSystem
The customer can take a ticket and wait.

## S6 New Entity
The staff/customer will provide with necessary information and then we decide if we can create a new entity:

### S6.1 Legal information
Add the entity to according systems and switch to such entity's main page.
### S6.2 Illegal information
Refuse to register and ask the entity to re-enter the information.
### S6.3 Abort

