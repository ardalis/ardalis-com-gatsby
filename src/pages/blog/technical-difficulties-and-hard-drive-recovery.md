---
templateKey: blog-post
title: Technical Difficulties and Hard Drive Recovery
path: blog-post
date: 2005-10-27T13:27:23.152Z
description: "Drove to Findlay to speak at their user group last night (about
  2.5 hrs away). Was working on my computer until the mid-afternoon, when I
  packed up and left. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Hard Drive
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Drove to Findlay to speak at their user group last night (about 2.5 hrs away). Was working on my computer until the mid-afternoon, when I packed up and left. When I arrived, I started plugging everything in and booted up my laptop to get this message:



**Windows could not start because the following file is missing or\
corrupt:\
windowssystem32configsystem****\
You can attempt to repair this file by starting windows setup using the original cd-rom. Select ‘r’ at the first screen to start repair.**

Sadly, I did not have a windows CD with me, not that it would actually have helped. I got home and tried that option to no effect — it couldn’t see anything at all on the C drive. I sent out a quick cry for help to the RD list and shortly afterward got a phone call from [Scott Hanselman](http://www.hanselman.com/blog), who pointed me to [Michele’s similar issue](http://www.dasblonde.net/PermaLink.aspx?guid=c9a15185-db99-4b8e-835d-82d021ea6540)from several months ago and her eventual solution of purchasing Winternals [ERD Commander product](http://www.dasblonde.net/ct.ashx?id=c9a15185-db99-4b8e-835d-82d021ea6540&url=http%3a%2f%2fwww.winternals.com%2fproducts%2frepairandrecovery%2ferdcommander2002.asp%3fpid%3derd). After reading her experience, I decided to just bite the bullet and buy the product as well. It took me a couple of tries to get the right drivers onto the boot disk (through no fault of the product’s), but once I did, I was able to boot up and see my C drive again. It couldn’t attach to Windows, though, which tells me the OS is shot. It did, however, allow me to connect my Maxtor OneTouch BigHonkingUSBDrive to it and pull off the latest junk (I’d last backed it up last week, but I’m using the backup/restore software that comes with the Maxtor drive and I haven’t yet tried a restore so I’m being extra careful).

Looks like it just finished copying. So now I just have to do a final once-over and make sure there’s nothing else I want on the drive before I pave it. It’s actually a RAID 0 Stripe of two drives, which is good for a little increase performance, but does have the downside of being twice as likely to fail as a single drive (which I think I’m experiencing now). They’re 2 60gb drives and with RAID 0 I get all the space (120gb), which is nice, but I think I might reconfigure them as RAID 1 (mirroring) this time around. I’ll only get 60gb of storage, but if there is a failure, I can just swap out one drive and keep all my stuff (in theory, unless they both fail at once).

<!--EndFragment-->