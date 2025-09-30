﻿---
title: How To Move or Rename a File using MSBuild
date: "2010-04-07T05:02:00.0000000-04:00"
description: MSBuild is a very powerful tool, and it's relatively easy to get
featuredImage: img/how-to-move-or-rename-a-file-using-msbuild-featured.png
---

MSBuild is a very powerful tool, and it's relatively easy to get started using it. You can run [a "hello world" example of MSBuild](http://msdn.microsoft.com/en-us/library/dd393573%28VS.100%29.aspx) in no time, and it's easy to build up the files incrementally as your needs (and knowledge of the tool) increase. Here's a [handy list of the tasks that are built into MSBuild](http://msdn.microsoft.com/en-us/library/7z253716%28v=VS.90%29.aspx).

**Move File Task or Rename File Task**

One thing that is missing from the built-in list of tasks is a file rename (or move) task. Fortunately, this is pretty easy to accomplish using a combination of the Copy and Delete tasks. Here's a real-world example that renames a file from _web.config to web.config as part of a deployment script written in msbuild:

```
<Copy SourceFiles="precompiledwebLakeQuincyCom_configproduction_web.config" DestinationFiles="precompiledwebLakeQuincyCom_configproductionweb.config"> <Copy>
<Delete>
```

This is part of a larger build script that's using the <AspNetCompiler> task to generate the site and ensure there are no build errors in the.aspx files of the site. The file paths in this care are relative to my build.proj file, but you could also specify absolute paths if you preferred.

There's also a library of tasks you can install separately that includes a <Move> target, which you can find here:

[http://msbuildtasks.tigris.org/](http://msbuildtasks.tigris.org/"http\://msbuildtasks.tigris.org/")

I haven't used this library in a number of years so I can't say for certain how well it's kept up. There are a bunch of potentially useful tasks in it, though, so if you need something more than simple file moving it might be worth investigating. For my needs of the day, Copy/Delete did the trick.

