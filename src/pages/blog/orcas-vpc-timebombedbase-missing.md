---
templateKey: blog-post
title: Orcas VPC TimeBombedBase Missing
path: blog-post
date: 2007-06-13T13:45:09.145Z
description: "I downloaded the Orcas Visual Studio Beta 1 VPC from MSDN
  yesterday and stitched all of the zip files together, and launched it. Ran
  into the dreaded:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - VirtualPC
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I downloaded the Orcas Visual Studio Beta 1 VPC from MSDN yesterday and stitched all of the zip files together, and launched it. Ran into the dreaded:

“E:VPCTimeBombedBaseBase01.vhd” could not be found message. If you run into the same thing, you can find [others with the same issue](http://www.google.com/search?q=orcase+timebombedbase+vpc&rls=com.microsoft:*:IE-SearchBox&ie=UTF-8&oe=UTF-8&sourceid=ie7&rlz=1I7ADBF) easily enough.

The solution is to download the [VSCTPBase.exe](http://www.microsoft.com/downloads/details.aspx?FamilyId=36B6609E-6F3D-40F4-8C7D-AD111679D8DC&displaylang=en#Instructions) file from [here](http://download.microsoft.com/download/5/4/9/5499b008-8ae7-46f0-89ae-aeeb18df67ae/VSCTPBase.exe). Extract the Base01.vhd file and then point to that as the base for your Orcas VPC. It’s working great for me now.

<!--EndFragment-->