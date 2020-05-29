---
templateKey: blog-post
title: Moving SVN Repositories to new Server
path: blog-post
date: 2010-02-12T12:42:00.000Z
description: "Recently I had to move some SVN repositories from one server to
  another.  Here are the steps that worked for me, courtesy of Pete Freitag:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SVN
category:
  - Uncategorized
comments: true
share: true
---
Recently I had to [move some SVN repositories from one server to another](http://www.petefreitag.com/item/665.cfm). Here are the steps that worked for me, courtesy of [Pete Freitag](http://www.petefreitag.com/):

**Step 1: Back up SVN Repository**

Back up your existing repository with the following command. Note that if you are [using VisualSVN](/installing-visualsvn-subversion) Server as I blogged about previously, you should be able to right-click within the VisualSVN server manager and get a command prompt that will have the correct paths and such to do this:

```
svnadmin dump /path/repositoryfolder &gt; repositoryname.svn_dump
```

*Notice the ‘>’ and its direction. It’s important.*



**Step 2: Create New SVN Repository (on new server)**

Next create a new repository. You can issue this command or just use VisualSVN Server Manager. If you do the latter, don’t check the box to create a default structure.

```
svnadmin create /path/repositoryname
```

**Step 3: Import your SVN Repository from its Dump**

Issue the following command on the new server from an SVN command prompt:

```
svnadmin load /path/repositoryfolder &lt; repositoryname.svn_dump
```

That’s all there is to it. If you use VisualSVN to look at the repository as it is in mid-load, you may need to refresh it after the load is complete. Otherwise, you may panic when you see the load is done but only some of your repository has been restored. Don’t ask how I know this.

I didn’t have to worry about this, but [Pete also has info on what to do if someone commits to the old location](http://www.petefreitag.com/item/665.cfm) while you’re in mid-move. My recommendation is to shut down the old location’s server (or set the specific repository’s permissions to just Everyone : No Access). The whole move with the above steps should require less than 15 minutes (unless transferring the files takes you longer than this due to their size and/or your bandwidth).



**What about my Working Copies?**

Of course, once the server is moved and you’ve shut down access to the old location, what do you do with your existing working copies that are linked to the old location? There are two options:

1. **Relocate**. If you are using TortoiseSVN (and I’m sure there’s a command line tool for this as well, but I’m using Tortoise), you can simply right-click on your existing working copy folder and select TortoiseSVN –> Relocate. In the dialog that comes up, enter the new location of the repository, and click OK. Assuming nothing has changed since you moved the repository, this should take just a few seconds to complete. This is the **safer, recommended approach**.
2. **Delete and Re-Checkout.** Assuming you checked in everything you cared about before the move, you can simply delete your working copy and then re-fetch it using SVN Checkout. This is kind of the brute force approach and is **not recommended if you have any work in progress!**