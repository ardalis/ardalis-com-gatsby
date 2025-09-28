---
title: How to Delete hiberfil.sys and Recover Disk Space on Windows
date: "2019-08-21T00:00:00.0000000"
featuredImage: /img/image-4.png
---

Desktop computers rarely need to hibernate, so you can probably safely remove the hiberfil.sys file and save yourself a few GB of space. To do so, just open up a new command prompt as an administrator:

1. Click on the Start button
2. Type 'cmd' (don't hit enter)
3. Right click on the Command Prompt that comes up and choose Run As Administrator.

Once you have an administrator command prompt up, just run this command:

![](/img/image-4.png)

powercfg.exe /hibernate off

Now check your disk space again and you should see the hiberfil.sys file is gone.

