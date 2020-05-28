---
templateKey: blog-post
title: MS Money Vista Issues
path: blog-post
date: 2007-03-20T16:02:46.299Z
description: "This is a summary of some problems my wife experienced recently
  upon installing Microsoft Money 2007 on Windows Vista:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - msmoney
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

This is a summary of some problems my wife experienced recently upon installing Microsoft Money 2007 on Windows Vista:

Here is what I did:

1.Installed Vista

2.Installed Money 2007 Deluxe

3.Opened Money – it wanted to install a service pack. No prompting for restart of computer when installation was complete. No suggesting that there needed to be a restart.

4.Opened the Money file from the backup on the desktop.

5.Tried to download transactions from the banks. Got an error message – unable to complete the action, try again or contact support. (Error OFXIE12007).

6.Tried again. No luck.

7.Tried to click the link for support, which didn’t work as the internet was not available from inside the program.

8.Tried the other suggestion in the error message, which was to check the internet set up options under Connections in the Tools menu. There was no Connections option in the list of choices. None of the other options (Internet was one, but just talked about how to handle downloaded transactions, not how to connect) had anything relevant either.

9.Tried Money Help. Obviously that didn’t work, no internet connection from inside Money, and no listing for the website in case you had internet access but just couldn’t connect from within the program.

10.Tried restarting the computer. No luck.

11.Tried restarting the computer, moving the Money file to the documents folder, and then opening it. No luck, and none with restarting.

12.Tried Microsoft’s Money help. It talked about connection problems, often to do with firewalls. Talked about lots of third party component issues, with nice ways to fix them. For issues with Vista, it said to see the Vista section, which so far as I can tell does not exist, or is hidden really well. Talked about how the service packs fixed various things, and how to check to see that you had the most current version (which I did).

13.Tried adding Money to the trusted programs list. (I was never prompted to allow Money to do anything like is often the case with Vista, but I figured maybe it wasn’t getting to that point for some reason, and maybe that was the problem – that I couldn’t authorize it to work.) No luck. No luck after restarting the computer AGAIN either.

14.Searched for the specific error, found this website:<http://money.mvps.org/faq/article/466.aspx>. However, I was a little leery of trying his suggestions since I could not find ANY other reference to this problem, the site owner is not clearly identified, and the site is littered with Google ads and looks a little questionable. I think it is really an MVP, but I am always a little cautious.

15.I did try enabling the SSL2 protocol. No luck. Restarted the computer. No luck.

16.Tried adding some of the sites. I was pretty comfortable with some of them because they were known sites, like moneycentral.msn.com. However, given my doubts with the reference site, I tried to visit them all before I added them. Passport.net would not come up. And no matter how I tried to add money:// it kept coming out money:///.

17.Having added the ones I was comfortable with (moneycentral.msn.com and fdl.microsoft.com and loginllive.com), I tried again. Nope. Restarted again. Nope.

18.Decided it might not work if only some were added, money:// woudn’t add correctly no matter what I did, and I wasn’t going to add the ones I couldn’t pull up and verify. (passport.net works today but the browser couldn’t find it last night.) So, I figured this step wasn’t going to do anything, so I deleted them all. Restarted. Nope.

19.Decided this whole solution was junk, or at least I didn’t trust it enough to fully implement it, and so I also unchecked the SSL2 box. Restared. And…. It worked!



So, what changed between when I turned on my computer and when it worked? The service pack was installed, Money was added to the trusted program list. The changes in the internet protocol and trusted sites were temporary and were returned to their original settings before I had any success. The only thing that I can figure is that the computer requires 8 restarts before Money and Vista are friendly enough to work together….

\[categories:msmoney]

Tags: [msmoney](http://technorati.com/tag/msmoney)

<!--EndFragment-->