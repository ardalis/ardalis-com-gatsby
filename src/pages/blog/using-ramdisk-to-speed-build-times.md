---
templateKey: blog-post
title: Using RAMDisk to Speed Build Times
path: blog-post
date: 2009-12-20T19:42:00.000Z
description: Now that computers with 64-bit operating systems and 8 or 12 GB of
  RAM are pretty affordable, there are some fairly easy things you can do to
  speed up your build time for large project.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - RAMDisk
category:
  - Uncategorized
comments: true
share: true
---
Now that computers with 64-bit operating systems and 8 or 12 GB of RAM are pretty affordable, there are some fairly easy things you can do to speed up your build time for large project. [Jeffrey Palermo wrote about six months ago about a few options for using RAM drives to speed up builds](http://jeffreypalermo.com/blog/speeding-up-the-build-ndash-ditch-the-ssd-and-go-for-the-ram-drive), and at the time my primary laptop only had 3GB of RAM so I wasn’t able to take advantage of his advice. However, recently I’ve gotten a new laptop and maxed it out with 8GB of RAM and Windows 7 64-bit.

Like Jeffrey, I have a ClickToBuild.bat file that will run my build as well as run all of the unit and integration tests for a given project. I set up a 1GB RAMDisk using [Dataram RAMDisk](http://memory.dataram.com/products-and-services/software/ramdisk) (free version!).

![configure ramdisk](/img/configure-ramdisk.png)

Next, I ran my ClickToBuild.bat script from my laptop’s 7200 RPM hard drive. Note that most of the time spent is in the integration tests, which go against a local SQL Server database, which is running on the hard drive. At the moment I’m in the middle of fixing a problem in the build, but the Time Elapsed is the important aspect to show here:

![build time hard drive](/img/build-time-hard-drive.png)

So, not quite 3 minutes to run the solution with all of its unit and integration tests off of the C magnetic drive. Next, I copied the folder to my G drive, which is the 1GB RAMDisk, and ran the exact same script again.

![build time ramdisk](/img/build-time/ramdisk.png)

Total time: 2 minutes 7 seconds – about 27% faster. Again, the database calls are all still going against my local SQL Server, which is still on the C (magnetic) drive, so these gains are primarily in the build and unit-test load/exec times. I haven’t yet tried putting the database into a RAMDisk. I’m guessing it would help, but probably not too dramatically since SQL Server will already aggressively use available memory to cache things. Perhaps for first-time loading it would make a difference, as that data would tend not to be in the cache and thus would need to come off of (slow) disk the first time.

27% may not sound like a lot to some people. Building and running tests is something that, if you’re head-down writing code, you are probably doing several times per hour. If you can shave a minute off of that time, you’re probably saving 3-5 minutes or more per hour, times 8 hours per day is 24-40 minutes per day. Now, sure, there are things you can do while your app is [compiling](http://xkcd.com/303):

[![compiling](/img/xkcd-303.png)](http://xkcd.com/303 "'Are you stealing those LCDs?' 'Yeah, but I'm doing it while my code compiles.'")

…but you and your our customers would much rather you were able to get back to coding sooner rather than later. A few minutes per hour adds up to real productivity (and $ at any reasonable billing rate), and that’s before we even start talking about [the value of having short feedback cycles to help detect and correct defects](http://www.ambysoft.com/essays/whyAgileWorksFeedback.html).

With the Dataram RAMDisk product, you can have it automatically serialize the disk to/from your persistent hard drive on startup/shutdown. Since it really is just RAM, a sudden power outage or BSOD will lose all of the data, but this is quite tolerable if all you’re using it for is source code that is already in your SCC repository (and of course you check in ALL THE TIME because small check-ins are amazingly better than huge ones). Thus, the amount of work you might ever lose as a result of the disk disappearing should be minimal.

**Don’t put stuff you don’t have a backup of into a RAMDisk. That is all.**
