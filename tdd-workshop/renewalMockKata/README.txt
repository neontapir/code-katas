Goal

You just got a new job at a Magazine. The CEO tells you that they're losing a lot of business, and they're pretty sure its because people aren't checking their mailboxes for renewal forms anymore.
His solution? Use email instead! He asks you to write a program that will email his subscribers that are within three months of relapsing on their subscriptions the message "Please renew your subscription to Ferret Fancy!"

Description
You quickly run into two problems: the CEO hired someone else to write the email connector for the application. The fellow promises "it will be done when its done!" and is no longer answering your calls.
Also, the real subscriber service appears to be unreliable and will sometimes drop its connection.

Using mocks and test driving, make sure that your program will be able to handle as many situations as these two services can possibly throw at it.

- Extra credit
You just got the email module from old Grumplestiltskin, and it appears to throw an exception whenever it fails to send the email. Prove with tests that you can recover from this.