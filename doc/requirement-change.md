# Requirement Change

The development of banking system is a little different from requirement.
More details(security, code reuse, user experience, etc) are considered and changed. 
This document will specify these changes.

All classes will have Italy font to standout, method will be put in quotes.

## _Entity_ and _EntitySystem_

In the previous design, _Staff_, _Customer_, _Account_ are three different types.

However, all classes need a id-password pair and in order to reuse this part of code, these classes inherient from a new class _Entity_.

Similarly, all the lookup and write operation to these three systems are alike, so an _EntitySystem_ is created.

## _PasswordHider_

This is a UI feature that is not mentioned in the requirement.
When inputing password, we don't want it to be displayed.

Therefore, when a new character is inputed, _PasswordHider_ will record that char and change it with a star to hide user's input. However, this feature is implemented in a callback function, so the user  can not input too fast or the recording would halt and the recorded password may loss.

## _Challenge_

_Challenge_ is a thrid party method to verify that the user is the person who he claims to be to prevent password leaks.

A _Challenge_ has a secret that is a random 6 char string with a timestamp. Any entity can request a _Challenge_ and use according sub-type methods to send that secret out.

To complete that _Challenge_ the entity need to return that secret and it would be compared against the groundtruth.

This _Challenge_ features is done but not added to main system. It can be added instantly.

## _IndividualCustomer_ and _BusinessCustomer_

Although they are implemented, the system does not distinguish these two.

The reason is simple, MATLAB do not have runtime type system. Meaning I cannot create a list of parent type and put child instances in.

In the future we may split the _CustomerSystem_ into two. But fornow, we do not care.

## ATM Compromises

When withdrawing from ATM, ATM is **supposed** to check if ATM itself have enough money.
However, if we assume that ATM has limited money, an _ATM_ class need to be created with funciton "addMoney".
This means that we need to write a leger system for the bank, which is not part of the plan.

Therefore, we assume that ATM is always filled with money. This check can be done when we know how much money this bank has.

## Combined _CustomerUi_

To be honest _ATMUi_(If there is one) and _CustomerUi_ should not differ much, except that _CustomerUi_ cannot "withdraw" nor "deposit".

Therefore, these two UIs are combined. When known that this machines is an ATM, two more options will appear.

## "newStaff"

_Manager_ has the power to employ "newStaff" and have access to _StaffSystem_. 
However, to make development easier, _Staff_ cannot be promoted to _Manager_. There isn't a notion of _Manager_ in this system. The _Manager_ privilage is granted when creating new _Staff_.


## Race conditions

When creating _Customer_, _Staff_, and _Account_, _EntitySystem_ write operation is required. However, there is no lock on the system when writing, makeing it possible to create a double identity in the system will little possiblity. However, this condition stand to be a main thread to the whole system.

One account can login in multiple places and the system will give each device a handle of the account. If money operation is involved in multiple devices at the same time, there might be fatal errors to this system. There are following fixes possible: 1) Lock; 2) Account can only login in one device. 