# Rong's Banking

This is a project for CS192 Software Engineering.

**Please refer to doc/ for change of requirements and testing plans.**

In this banking project, I was responsible for development. Unfortunately, we have to use MATLAB, many features that I am not familar with is not used. The project could have been developed better if I am using Java.

However, MATLAB's App Designer is really powerful, allowing me to develop 10 frontend pages and 3 backend data bases in 2 days. I spent another few days on testing UI and other stuff.

Anyway, this is a fun project.   
(Jun 10, 2019 Update)It is not a fun project, MATLAB is hell.

## Install

Just got an MATLAB 2018b and you are good.

It is known that it will run on MATLAB 2016\*.
There are reports that apps designed in MATLAB 2018 cannot run properly in MATLAB 2019. Not sure how this app performs.
Be prepared :)

## Test

Using `<test.m>` you may do a through testing on all components.
The test would take approx. 10 minutes, as UI testing is really slow.
However, you may also choose to only test backend components using `<test/testBackend.m>`, it would only last for 10 seconds.

## Run

In MATLAB, change current folder to the one _main.m_ is in.

Press F5 or type main and press enter. Four interfaces will show.

If you are interested in running anything independently, please make sure that you run `<addPath.m>` as MATLAB will not detect folders by default, we have to manually add it.

## Play with it

I have prepared some customer accounts, bank accounts and staff accounts in `<sample>` folder. 
These sample data is used by my tests.
Or you can register an account an play with it.

## Limitations

I didn't implement Challenge part. Although I felt necessary. But it is not part of the requrement, and I am lazy, mostly lazy. (Man, fight with MATLAB OOP for two days and you know what I mean)

Manager can only create new Staff, that's all. Staff cannot get promoted or else I have to write a new frontend. (Poor Staff.)

Cannot deposit for now since I don't have an ATM.

These functions are not implemented, but you can press the button, just there will be no response. Relax, it will not explode.

## Doc

To pretend that this is a commerical, fully finished and well-organized project. There are documents inside `<doc/>`, including requirements, plan changes, user manual, validation plan, etc.

You may refer to these docs should you have any questions about it.

## Something else

This project can be found on [github](https://github.com/DataCorrupted/banking)(It's possible I have't open sourced this project by the time you press this link, so it may not work. But hey, this is MATLAB, the moment when you read this README means you have source code at hand.)

You can contact me through PeterRong96@gmail.com.
I am always open for communications. Tell me what you think about it.

