---
templateKey: blog-post
title: Outlook Send Mail Infinite Loop - Message in Outbox
date: 2012-02-02
path: /outlook-send-mail-infinite-loop-ndash-message-in-outbox
featuredpost: false
featuredimage: /img/laptop-rebuild.jpg
tags:
  - outlook
category:
  - Productivity
comments: true
share: true
---

Last week I encountered a problem with Outlook that I’m happy to report I’ve just solved. I found a bunch of things on the Interwebs that looked like they might be useful, but none of the fixes there did the trick for me (of the ones I tried – some fixes were more extreme than I wanted to attempt). Here are some resources that may help you if my fix does not:

- [Outlook Send-Mail Infinite Loop](http://buhjillions.spikecurtis.com/outlook-send-mail-infinite-loop)
- [Message stuck in Outbox](http://www.howto-outlook.com/faq/messagestuckinoutbox.htm)
- [How to troubleshoot mail stuck in Outbox in Outlook 2000](http://support.microsoft.com/?id=195922)
- [Delete a stuck Read Receipt](http://www.howto-outlook.com/howto/deletereadreceipt.htm)
- [Download MDBVU32.EXE](http://www.microsoft.com/downloads/details.aspx?FamilyID=3D1C7482-4C6E-4EC5-983E-127100D71376&displaylang=en) (see previous link for why)
- [Forum with some tips for trying to delete messages](http://forums.majorgeeks.com/showthread.php?t=154379)

**The Problem**

I tried to send an email on Sunday and for whatever reason it got stuck in my outbox. It was italicized, and if I tried to open or delete it, it would inform me that Outlook was already trying to send the message and thus I couldn’t do anything to it. This was a minor annoyance, at first.

However, this became much more of an annoyance when Outlook would, from time to time, get into some kind of an infinite loop while trying to send messages. It would generate “Successful” account synchonrization messages over and over again (racking up hundreds of such messages per minute). Some of my online research suggested this might mean that my [Address Book was out of sync with my contacts, but following the steps in that post](http://buhjillions.spikecurtis.com/outlook-send-mail-infinite-loop) revealed that this wasn’t my issue. While this loop was going on, Outlook was unusable and the Send/Receive dialog would flicker, taking focus from other windows, which basically forced me to close OULOOK.EXE from Task Manager.

I downloaded MDBVU32.EXE on the advice of some other blogs, which let me view my PST file and attempt to manipulate its contents. I was able to see the message in the outbox but attempting to delete it did nothing, and attempts to abort sending the message resulted in an error.

I tried switching to Offline mode, but that didn’t help. In fact, the infinite loop still occurred (I wasn’t really sure why it was still trying to connect to anything, but it was). Some of the possible solutions I’d found online suggested that I create a new PST file and delete all of my accounts and re-create them in the new PST file, and then move over my messages. That definitely seemed like overkill and really at that point I was starting to consider just giving up on Outlook altogether. Luckily, I found the solution today before resorting to anything that drastic.

**The Solution**

Thanks to Outlook guru Alon Brown, the solution was pretty straightforward. Restart Outlook in safe mode, switch to Offline mode, then **restart Outlook in safe mode again (while still offline),** and delete the message. **This worked!**

I’d tried safe mode, and I’d tried offline mode, but I hadn’t tried restarting Outlook with these settings in place. I’m not sure if it was necessary to be in safe mode each time or not, but those are the steps that worked for me. To get outlook into safe mode, simply browse to the path where OUTLOOK.EXE is located (e.g. C:Program FilesMicrosoft OfficeOffice12OUTLOOK.EXE) and run it from the command prompt with the /safe switch. Then you should be able to navigate to the Outbox and delete any messages found there.
