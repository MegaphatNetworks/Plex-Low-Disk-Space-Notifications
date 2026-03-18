# Plex-Low-Disk-Space-Notifications
When your Plex Media Server is running low on disk space, this PowerShell script wil email you a notification.
---
I came across a problem where my HDD for TV shows (Live TV & DVR from my HDHomeRun) ran out of space and I had no clue.  I missed the Oscars and more because I had no clue my disk space for my TV shows was low.   Had I known I would have cleaned up some stuff.  Well, now I will know.
---
The way this works is kind of simple.  You save this script in Plex script folders, such as:
`C:\Users\Megaplex\%Username%\AppData\Local\Plex Media Server\Scripts`  
Where `%Username%` is the name of the user account your Plex is installed under.  By default I made this script to work under Gmail.  You can customize the SMTP server but you must use a valid account.

Once there, be sure to customize the script.    
`$MinSpace = 10GB` If estimating by space, this value will be used.   
`$MinPercent = 0.10` If estimating by percentage, this value will be used.   
`$MailFrom = "YOUR_GMAIL_ADDRESS"` Clearly this is your Gmail account login name.   
`$AppPwd = "YOUR_GMAIL_APP-PWD"` Gmail uses Less Secure Apps for non-OAuth access.  You will need to create an app password.   
   
You can customize your text message to be sent if you like.  I recommend trying it out first.   
   
So next I created a ***Scheduled Task*** so that the system checks daily.  I should have it check hourly  but then it would just nag me more often.  So I'd rather check daily.   
   
To create the Scheduled Task, Run Task Scheduler, Create New Task (not a Basic Task).   
GENERAL TAB: 
* Name it whatever you like.  
* Have it run whether or not you are logged in.  
   
TRIGGERS TAB:  
* Daily @ 4am  
   
ACTIONS TAB:  
* Start Program: *powershell.exe*  
* Add Arguments: *-executionpolicy bypass -windowstyle hidden -file  C:\Users\%Username%\AppData\Local\Plex Media Server\Scripts\PMSLowDiskNotify.ps1*  

Click OK to Save it.  Right-Click on your newly created task and RUN in order to test it.



