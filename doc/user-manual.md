# User Manual

## Staff Manual

_Staff_ is catogrized into staff and manager.
In sample staffs there is an admin that has manager privilage that serves as the root user. 

_Staff_ can manage accounts and customers. 
It can create new users and accounts, refer to Customer Manual for that information.
It can also do transactions to user account, refer to Customer Manual for that information.

Once _Staff_ is done serving current user, he can press "Next Customer" button. The next customer will be called. 
If he didn't show up immediately, he can press it again to repeat that call.
If three calls later the user still don't show up, press "Next Customer" again and the next one will be server, the previous user will have to take another ticket.

## Customer Manual

There is no difference between _BusinessCustomer_ and _IndividualCustomer_.
All customers may refer to this manual.

### Create a new _Customer_
To create a new customer, you may press "Register" to do so.
Customer may use his 18 digit government issued id as their user id. 
It is unique and therefore each person can only have one _Customer_ account.
He also need to provide his name and password for furture login.

### Create a new _Account_
No _Customer_ has initial account. You need to create it on your own or ask for a _Staff_'s help. 
To create a new _Account_, you only need to provide a password. 
The account id will be setup automatically. 
To make your life easier, you all existing accounts will show up in a drop down bar for you to manage in your customer page.

### _Account_ management
An account can be managed. 4 Actions are allowed:

- Transfer
- Withdraw
- Deposit
- Query

You may transfer your money to any existing account, provided that you have a valid account id.
Only in an ATM you can with draw or deposit cash.
You may also query the remaining money in your account at any time to know how much money is left.

### How to reach out to an staff

On step inside our banking, you need to take a _Ticket_. 
These tickets show how many people a ahead of you while you are waiting to be served.
Once it's your time, you may be called at most 3 times. If you don't show up in time, you may have to take another ticket.

Once you met with a staff, tell him what you need and provide necessary information is suffice.

## Server Manual

The server is closed to all entities to guarantee data integrity.

No _Customer_ nor _Staff_ can only interface with backend directly, they can only interact with _Processor_ and _Processor_ will interact with backend.