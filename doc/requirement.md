# Requirement

The original requirement is sent to you using diagrams. Therefore the requirement here will have no images and only serve the descriptive purpose and will be brief.

## R1: _Entity_
_Entity_ is a id-password pair to hide all the log in operation for the safety concern.

_Entity_ has three children: _Staff_, _Customer_ and _Account_.
Each class will handle the details of a certain person.
### R1.1 Account
- R1.1.1 Transfer
- R1.1.2 Withdraw
- R1.1.3 Query
- R1.1.4 Deposit
### R1.2 Customer
- R1.2.1 New Account
- R1.2.2 Manage Account
### R1.3 Staff
- R1.3.1 Manage Account for customers
- R1.3.2 Create _Customer_ and _Account_
- R1.3.3 Call next customer

## R2: _EntitySystem_
_EntitySystem_ is used to manage all information for a collection of entities.
It provides search, insert and log in operation.
- R2.1 LogIn
- R2.2 New Entity

## R3: _TicketSystem_
When user arrives he needs to take a ticket and wait to be served.
_TicketSystem_ is used to make that happen.

## R4: Ui
### R4.1 EntityUi
- R4.1.1 _AccountUi_
- R4.1.2 _CustomerUi_
- R4.1.3 _StaffUi_

### R4.2 EntityLogInUi
- R4.2.1 _AccountLogInUi_
- R4.2.2 _CustomerLogInUi_
- R4.2.3 _StaffLogInUi_

### R4.3 NewEntityUi
- R4.3.1 _NewAccountUi_
- R4.3.2 _NewCustomerUi_
- R4.3.3 _NewStaffUi_

### R4.4 TicketUi