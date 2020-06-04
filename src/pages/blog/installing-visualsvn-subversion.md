---
templateKey: blog-post
title: Installing VisualSVN Subversion
path: blog-post
date: 2008-10-02T15:36:00.000Z
description: Wrapping up HeadSpring's Agile Boot Camp class this week, we're
  installing VisualSVN Server locally. Running the setup is just a matter of
  hitting Next three times – it's very simple. Running the visual server window
  yields this opening screen
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - VisualSVN
category:
  - Uncategorized
comments: true
share: true
---
Wrapping up [HeadSpring's Agile Boot Camp](http://www.headspringsystems.com/training) class this week, we're installing [VisualSVN](http://www.visualsvn.com/) Server locally. Running the setup is just a matter of hitting Next three times – it's very simple. Running the visual server window yields this opening screen:

![image](/img/visualsvn-1.png)

Next, right click on VisualSVN Server and select Properties:

![image](/img/visualsvn-2.png)

These are basically the same settings you had available from the installer. Assuming these settings are fine, the next step is to create a user. Go back to the main screen and right click on Users, Create User.

![image](/img/visualsvn-3.png)

Once a user is created, the next step is to create a repository. Be sure to check the box to set up the default structure.

![image](/img/visualsvn-4.png)

At this point, the server end of things is done. If you want to set up a working folder on your local machine to point to this, go to a folder (like C:working) and assuming you already have TortoiseSVN installed, right click and select in the folder and select SVN Checkout:

![image](/img/visualsvn-5.png)

Configure the URL and local directory:

![checkout](/img/visualsvn-6.png)

Once this is done, you can also see at any time how the folder is mapped to its subversion location by looking at the folder's properties.

![folder properties](/img/visualsvn-7.png)

At this point you're ready to create your initial sub folders and work on your project.

![folder structure](/img/visualsvn-8.png)

Too easy. And oh by the way this also just installed Apache Server, so if you've ever wanted to do that but weren't sure how difficult it would be – you just did it.

![services - visualsvn - apache](/img/visualsvn-9.png)

If you're moving an existing project into this working folder and you want to add it to source control, you're best off using VisualSVN from within Visual Studio to do so. Open the solution in Visual Studio, and then assuming you have VisualSVN client installed, you should be able to right click on the solution and select Add to Subversion.

If you don't see that option on the solution, you'll want to delete the .svn folder from the working folder and then go through the process, stating that you'll set the working folder manually.

Now right click on the folder in Windows Explorer and SVN Commit. Your code is now in a local copy of subversion. Note that you can use this to version any files! If you want to version your word documents or graphic files you're editing or anything you like, this will let you do it. Just be sure you're backing up your hard drive, since this isn't a substitute for backing up your disk. But it will give you local revision history so you can undo changes to any document.