---
templateKey: blog-post
title: Find Duplicate Files and Clean Up Disk Space
path: blog-post
date: 2008-09-11T02:33:00.000Z
description: I’m in file cleanup mode tonight as my laptop hard drive is
  consistently nearly full lately. On a side note I’m really looking at getting
  an HP MediaSmart Windows Home Server like the one ScottHa got a while back,
  but they’re a bit old at this point so I figure newer models with more RAM and
  larger built-in HDDs must be coming soon.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - diskspace
category:
  - Uncategorized
comments: true
share: true
---
I’m in file cleanup mode tonight as my laptop hard drive is consistently nearly full lately. On a side note I’m really looking at getting an [HP MediaSmart Windows Home Server](http://www.amazon.com/gp/redirect.html?ie=UTF8&location=http%3A%2F%2Fwww.amazon.com%2FEX475-MediaSmart-Server-Windows-Drive%2Fdp%2FB000UXZUZC%3Fie%3DUTF8%26s%3Delectronics%26qid%3D1221189261%26sr%3D8-5&tag=aspalliancecom&linkCode=ur2&camp=1789&creative=9325) like the one [ScottHa got a while back](http://www.hanselman.com/blog/ReviewHPMediaSmartWindowsHomeServer.aspx), but they’re a bit old at this point so I figure newer models with more RAM and larger built-in HDDs must be coming soon. But I digress.

In the course of cleaning up hard drives, I religiously use [SpaceMonger](http://www.sixty-five.cc/sm/v1x.php), which is (was) free and shows you everything broken out by proportionally sized rectangles ([SpaceMonger 2.1](http://www.sixty-five.cc/sm) is not free, looks improved, but I haven’t tried it yet). This app is awesome for finding out why you suddenly have no disk space. I sometimes still miss my old MS-DOS dirtree command, though (at least I think that’s what it was called). SpaceMonger belongs in your c:Util folder along with other goodies (update: these are now kept in a [DropBox or Copy folder](https://ardalis.com/incent-all-parties-involved)):

![](/img/findduplicatefile1.png)

What SpaceMonger (1.4) provides is something like this (click for full size)

![](/img/findduplicatefile2.png)

This makes it easy to spot large offenders. However, beware that Vista’s junction points are not handled correctly, so you’ll end up seeing things like Music and My Music as duplicates. I’m not sure if this is corrected in 2.1, but it would not surprise me if it is. In any event, you can drill down into individual folders to see the relative sizes of everything in them, which is extremely useful.

The other thing that can quickly eat up space is multiple copies of the same files. Duplicate files can happen when poor-man’s backups are made (e.g. copy My Documents to Backup1) or from any number of other ways. For me, I tend to fall way behind on photos, which I try to archive on JungleDisk and publish on Flickr, as well as storing them on a NAS at home. Getting them off of the camera I’m pretty good at, but sometimes I need to do something with them before I get through the workflow of copying them hither, thither, and yon. What I ought to do is write a Windows Workflow EXE that will suck photos off of a camera, copy them to the NAS, copy \*those\* to JungleDisk, and send me a reminder to add the ones I like from these folders to Flickr. Perhaps some day. What I do now sometimes results in duplicate photos lying around, and I want to be able to find and clean up these and other duplicate files.

I’ve tried some duplicate file finder apps in the past. Today I searched for one and came up with the [Easy Duplicate File Finder on PCWorld](http://www.pcworld.com/downloads/file_download/fid,67281-order,4-page,1-c,filemanagement/download.html). I pointed it at My Documents and it went to town for I think at least an hour. It certainly wasn’t quick. But it analyzed about 8,000 files, and it thought it analyzed almost twice that, again because of the Vista junction folders for Pictures, etc. The program was definitely useful and did what I wanted, so I would recommend it, but I wish there were an easy way for me to tell it that c:\Users\Foo\Pictures is really the same as c:\Users\Foo\Documents\My Pictures. It’s very annoying that tools like this one and SpaceMonger don’t realize this.

Here’s a screenshot of the Easy Duplicate File Finder which by the way is free

![](/img/findduplicatefile3.png)

As you can see, you can limit which folders it analyzes, so you can avoid the junction point issues if you have it start in the Documents folder. In my case, I really did want to find duplicates in AppData and other subfolders of my user account.

Got a favorite file management utility? Let me (and others) know and post a comment.