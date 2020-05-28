---
templateKey: blog-post
title: Run Batch File as Scheduled Task
path: blog-post
date: 2011-05-28T19:43:00.000Z
description: I’ve had problems running batch files as scheduled tasks.  I’m not
  alone – over the past couple of weeks, while I’ve been trying to get a
  scheduled job to work on a new server (when it worked fine on the old one),
  I’ve done a fair bit of searching on this topic.
featuredpost: false
featuredimage: /img/schedule.jpg
tags:
  - batch file
  - schedule task
category:
  - Software Development
comments: true
share: true
---
I’ve had problems running batch files as scheduled tasks. I’m not alone – over the past couple of weeks, while I’ve been trying to get a scheduled job to work on a new server (when it worked fine on the old one), I’ve done a fair bit of searching on this topic. I’ve found long threads on how some folks [cannot run batch file as a scheduled task](http://www.annoyances.org/exec/forum/winxp/1229698587), with suggestions such as using full UNC paths for all of the values (for the program name and start in folder). I [found a blog post explaining how batch files need to have a command window](http://richarddingwall.name/2009/01/26/capture-the-output-from-a-scheduled-task), and thus should be run with cmd.exe, in order for their output to be sent to a file for later examination. I found a [really long thread on technet about running batch files as scheduled tasks](http://social.technet.microsoft.com/Forums/en/winservermanager/thread/d47d116e-10b9-44f0-9a30-7406c86c2fbe), with numerous posts with possible solutions and variations on the problem.

Along the way, I tried some different things. My batch file is very simple – it wraps up a call to an EXE in its folder and tacks on some parameters, like so:

**Foo.exe -v $2 > "%\~dp0error.txt" $1 > "%\~dp0log.txt"**

Something else I learned along the way is that in a batch file, if you us the literal string **%~dp0** it will be translated into the path where the batch file is located (ending with a trailing ). So if the above were run in the d:jobs folder, the two paths would be “d:jobserror.txt” and “d:jobslog.txt”. Even with these, though, I would experience problems with the scheduled job. Running the batch file myself worked like a charm, but the scheduled job had issues. Sometimes it would immediately quit. Other times it would run but not appear to do anything. And if I did put in the path in the optional start in textbox, it would fail with an annoying error:

**The directory name is invalid. (0x8007010B)**

It turns out that this error is caused by the fact that the [Start in (optional) textbox in the Edit Action dialog in the Task Scheduler does not support quotes](http://matthewcevans.com/blog/2010/08/11/windows-task-scheduler-the-directory-name-is-invalid-0x8007010b). So if you have a path that has spaces in it, and you are naturally wrapping it in quotes because, hey, that’s what you do with paths that have spaces in them, you’re going to get this error, every time.

In the end, I didn’t have to use cmd.exe. I didn’t have to use UNC paths. All I had to do was include the Start in (optional) path, without quotes (and without a trailing slash), and my job worked. I \*did\* have quotes around my Program/script file, and that works just fine.

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Run-Batch-File-as-Scheduled-Task_A64F/image_2.png)

Hopefully this is helpful to some others – I know it took me a while to find a working solution to this issue.