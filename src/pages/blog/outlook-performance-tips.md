---
templateKey: blog-post
title: Outlook Performance Tips
path: blog-post
date: 2008-03-31T12:03:45.429Z
description: "I’ve been living with Outlook 2007 since it shipped, and it’s been
  pretty painful, but my life is in it so I’m stuck with it. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Microsoft Office
  - Outlook
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been living with Outlook 2007 since it shipped, and it’s been pretty painful, but my life is in it so I’m stuck with it. I’ve posted some [Outlook tips](http://aspadvice.com/blogs/ssmith/archive/2007/05/14/Outlook-Data-File-PST-Not-Closed-Properly.aspx) in the past about how to deal with it not shutting down properly, and that has grown into a fairly sizable post with dozens of comments (and #1 for the search term [outlook did not shut down properly](http://www.google.com/search?q=outlook+did+not+shut+down+properly&rls=com.microsoft:*:IE-SearchBox&ie=UTF-8&oe=UTF-8&sourceid=ie7&rlz=1I7ADBF). Nice.). Anyway, I have some additional tips that I thought would be worth sharing.

**Use Exchange If You Can**

In general, most of the people I’ve talked to say that Outlook 2007 doesn’t have any huge performance problems when it is working with Exchange. This makes perfect sense to me since I’m sure Microsoft uses Exchange extensively and they probably would have noticed if its performance were complete poo in this scenario. If you can, use Outlook with Exchange to get the best experience.

**Avoid Touching Multiple PSTs At Once**

The biggest issue with performance that I notice with Outlook 2007 is disk access. The program goes nuts with disk access any time it’s doing anything (and sometimes when it doesn’t appear to be doing anything). What makes this worse is if you have several PST files (because of course you want them to be small – see below) and you’ve set up rules to move things automatically between your main PST and one or more others. This takes the disk access problem from bad to horrendous, and will really slow things down. Ideally, you should have everything dump into one PST file. If you need to keep it from getting too big, you should periodically archive it to one or more others (and don’t plan on Outlook being responsive while you do so – do it before heading to lunch or something).

**Keep Your PSTs Small and Defragged**

Outlook is heavily disk IO bound with its data store. Watch your hard drive light while it’s checking email to see this in action. The larger your PST files get, the longer they take to read and write and the more likely they are to be fragmented all over your physical disk. Since [your disk is most likely the biggest bottleneck in your whole computer](http://www.codinghorror.com/blog/archives/000800.html), you want to avoid this as much as possible. You can also go buy a faster drive, but barring that, you should keep your PST files under 1GB if possible and keep individual folders under 5,000 or so items in it ([YMMV](http://en.wikipedia.org/wiki/Your_mileage_may_vary) – it depends on what they are). Your ideal setup should be 2 PST files, one that is small that all new mail arrives in (and is filed into) and another that is largely static but is periodically filled via archiving (and frequently backed up).

I still find that POP3 access via Outlook is abysmal. I haven’t found any fix for this yet, but the above tips should help improve your Outlook performance.

<!--EndFragment-->