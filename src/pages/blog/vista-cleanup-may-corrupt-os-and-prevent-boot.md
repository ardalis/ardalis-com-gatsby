---
templateKey: blog-post
title: Vista Cleanup May Corrupt OS And Prevent Boot
path: blog-post
date: 2008-11-04T13:21:00.000Z
description: Ran into this gem yesterday. My intelide.sys file was corrupted and
  prevented Windows Vista from booting on my laptop. I found this forum and
  several others referencing the problem, which appears to be the result of
  running Vista Cleanup to free up space.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Windows Vista
category:
  - Uncategorized
comments: true
share: true
---
Ran into this gem yesterday. My intelide.sys file was corrupted and prevented Windows Vista from booting on my laptop. I found [this forum](http://www.computerforum.com/128066-intelide-sys-corrupt-after-disk-cleanup.html) and several others referencing the problem, which appears to be the result of running Vista Cleanup to free up space. A few days previously, Vista warned me that I was low on disk space and presented its little cleanup dialog with options for compressing files, deleting internet cached files, and temp files. I’ve used this little tool before so I said sure, do your thing. And it did, and it was happy afterward, and I didn’t give it much more thought. One thing that struck me as odd, though, was that it thought there was something like 16GB of temp files in need of deleting. That seemed high to me, but I didn’t investigate as I had real work to do and I figured surely the OS knew what it was doing when it came to something as critical as deleting files…

Some days later (yesterday) I finally decided to restart my machine (having only been sleeping it in the interim), and to my great surprise, it would no longer boot. Apparently the file **intelide.sys** had been somehow corrupted. Running Repair from the OS install disks didn’t help. In fact, for quite a number of tries I could only get Startup Repair to run – I couldn’t even get to a command prompt as part of the repair process. I’m not sure if this is due to the Vista SP1 disk I was using or if it was just user error, but when I switched to an old, original, non-SP1 Vista disk, I was able to get to the System Recovery Options dialog and from there the Command Prompt.

From there I followed the advice on [How to fix your Hard Drive When Vista Won’t Boot](http://www.computerforum.com/128066-intelide-sys-corrupt-after-disk-cleanup.html) and found a couple of variations of my intelide.sys file in my DriverStore. I dutifully copied each one to my /system32/drivers folder but in each case I was either left with the original behavior or Windows would start to boot and then Blue Screen Of Death on me.

However, I was able to access the whole disk (no hardware failure – just Vista stupidity) as well as connected USB drives. So for the last 12 hours or so I’ve been using robocopy to back up the machine just to be sure (I have a backup from not too long ago as well but I don’t like the possibility of losing stuff forever), and then I’ll spend the next 2 days or so reinstalling Windows and my plethora of applications. This would be quicker except robocopy keeps getting confused and going down infinite folder trees like /AppData/AppData/AppData… and finding Access Denied on certain files.

Maybe I’ll press my luck and throw Windows 7 on the machine… but probably not since I have a couple of presentations to give this month off of it.

The annoying thing is that I was getting ready to get a new laptop before the year’s end, and to transfer everything and repave this one at that time. Instead, I’m losing two days of productivity because of a stupid Vista bug. I like to give Microsoft every benefit of the doubt, but in this case I’m not a happy camper and I’m perfectly content to share this with you, my readers. If you’ve run into this same behavior, please comment (for others’ benefit, not mine) if you’ve found a solution other than reinstalling Windows.