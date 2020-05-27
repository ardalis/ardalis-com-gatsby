---
templateKey: blog-post
title: Velocity CTP1 Install
path: blog-post
date: 2008-07-09T02:22:21.411Z
description: Finally have a few minutes to play with Velocity, Microsoft’s new
  distributed cache offering that’s currently in CTP1 status (since a month ago
  at TechEd Developers in Orlando).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Velocity
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Finally have a few minutes to play with [Velocity](http://www.microsoft.com/downloads/details.aspx?FamilyId=B24C3708-EEFF-4055-A867-19B5851E7CD2&displaylang=en#filelist), Microsoft’s new distributed cache offering that’s currently in CTP1 status (since a month ago at TechEd Developers in Orlando). Read the official announcement [here](http://blogs.msdn.com/velocity/archive/2008/06/02/introducing-project-codename-velocity.aspx). The installation immediately asks you to configure your machine as a Cache Host:

[![Cache Host Configuration](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_2.png)

To proceed, create a shared folder that grants Everyone Read and Write permissions (per the [README](http://download.microsoft.com/download/3/2/d/32d36b1a-2ed8-4e93-9d04-a28d4fbb94f4/code_name_velocity_readme.txt) this will be addressed in a future release).

[![Folder Permissions](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_4.png)

When complete:

[![Configuration Complete](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_8.png)

Note that the Cluster Name must be a single word, no spaces or special characters.

[![image](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_10.png)

YES!

[![image](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_12.png)

[![image](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_14.png)

Now that that’s over with, we can start doing stuff with the cache using its console-style Administration Tool. Here are a few quick commands that get our cache service up and running and confirm that it at least appears to be functional, albeit thus far nothing is using it.

[![Velocity Admin Tool](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_16.png)

The next post on this topic will show how to actually program against Velocity. It looks like there are some good How To articles in the included Help file:

[![image](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VelocityCTP1Install_55/image_18.png)

[ScottW](http://simpable.com/) also has a [Velocity setup writeup](http://simpable.com/code/velocity-setup) that until just now I hadn’t had a chance to read over. Mine’s likely to be very similar, now that I read his, but we’ll see if I can’t stretch it a bit further.

<!--EndFragment-->