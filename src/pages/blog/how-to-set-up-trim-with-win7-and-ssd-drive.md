---
templateKey: blog-post
title: How to set up TRIM with Win7 and SSD Drive
path: blog-post
date: 2010-01-31T13:22:00.000Z
description: I have an [Intel X-25M SSD in my developer workstation machine (and
  it’s quite fast). However, I’ve heard from others that over time SSD
  performance can degrade due to [sub-block level fragmentation that occurs as a
  result of write combining.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Win7 SSD
category:
  - Uncategorized
comments: true
share: true
---
I have an [Intel X-25M SSD](http://www.amazon.com/gp/product/B002IJA1EQ?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=B002IJA1EQ)in my developer workstation machine (and it’s quite fast). However, I’ve heard from others that over time SSD performance can degrade due to [sub-block level fragmentation that occurs as a result of write combining](http://www.pcper.com/article.php?aid=669&type=expert&pid=7). Fortunately, newer SSD drives (like mine) support the TRIM command, but of course this only works if your system is sending the command to the drive.

## How Do I Know if Windows is Using TRIM for my SSD?

Fortunately (and thanks to [Ken](http://www.adopenstatic.com/cs/blogs/ken)), there is a simple command you can execute to determine if windows is sending TRIM commands to your SSD drive.

![image](/img/fsutil.png)

Run the following command:

```powershell
fsutil behavior query disabledeletenotify
```

If the result is 0, then Windows is sending TRIM commands to the device (which obviously needs to have firmware that supports TRIM for this to matter).
