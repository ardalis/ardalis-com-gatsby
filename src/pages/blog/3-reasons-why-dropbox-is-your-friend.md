---
templateKey: blog-post
title: 3 Reasons Why DropBox is Your Friend
date: 2013-10-10
path: /3-reasons-why-dropbox-is-your-friend
featuredpost: false
featuredimage: /img/dropbox.png
tags:
  - dropbox
  - tool
  - utility
category:
  - Productivity
comments: true
share: true
---

I’ve been a huge fan of [DropBox](https://www.dropbox.com) since its early days. In fact, I’ve been using similar tools, like [FolderShare](http://foldershare.com) (until Microsoft killed it), for many years, but DropBox is by far the best one I’ve ever used. I work from 3 different machines on a regular basis (work desktop, home desktop, laptop for meetings/travel), and DropBox ensures that every one of them always has all the files I need to be productive. I publish training classes online (occasionally) with Pluralsight, a distributed company with several hundred authors, and DropBox is the primary means of coordinating the many files that need to be shared in order to publish the online courses.

[If you’ve never used DropBox, you can get started here](https://db.tt/9EN76sb) (and boost my total space by doing so). DropBox gives you a 2GB of space for free, and [a bunch of ways you can get more for free](https://www.dropbox.com/getspace), in addition to their Pro and Business plans. Referring someone, for instance, yields a bonus 500MB of space for your account (a number that occasionally increases without your having done anything – originally it was 250MB but it was updated retroactively for all referrals to 500MB a while ago).

Even if you’ve been using DropBox for a while, you may not have used several of its features that really make it shine. I’ve noticed some people treat it like a removable disk drive, copying files to and from it, but always working on things directly in their local documents folder. This model works, but isn’t ideal. You’ll end up with multiple versions of files to deal with, and a lot of manual effort, and it’s quite likely if you use more than one machine that the latest version of something you’re working on is in the local documents folder of another machine when you want it on the machine you’re using now. The real benefits of DropBox accrue when you go “all in” and use it as your main file system for day-to-day files (older/larger files that aren’t needed as frequently can be archived elsewhere to conserve space). If this seems scary, read on.

## 1\. DropBox Remembers Your Old Versions

We’ve all modified a file to give it a new name in order to do “poor man’s version control”. In software development, there’s a name for this: [Copy Folder Versioning](http://deviq.com/copy-folder-versioning), and it’s an [anti-pattern](http://deviq.com/topics/antipatterns). DropBox is source control for normal users. No longer do you need to keep a running history of a file’s changes by renaming it every time you touch it. You can get your old versions back if you need to. In fact, to prove to yourself that it works, I encourage you to give these steps a try yourself (it will take about 2 minutes):

**Create a New Text File in your DropBox**

![image](/img/image_5.png "image")

You should immediately see it in DropBox.

**Right click on the file and choose View on Dropbox.com**

![image](/img/image_6_1.png "image")

And there it is:

![image](/img/image_9.png "image")

Now open the file and add some text. Save it. Add some more text. Save it again. And one more time. If you’re not feeling terribly creative, perhaps the text could be “Version Two”, “Version Three”, and “Version Four”. Realize that version one is the blank text file that’s already out there. At this point you have a file that looks like this, that you’ve saved after each line was added:

![SNAGHTMLef4d594](/img/SNAGHTMLef4d594_1.png "SNAGHTMLef4d594")

What if you suddenly realize that Version Three was the one you wanted to keep? Or maybe you just accidentally deleted the entire document and saved it – what now?

**It’s easy to get to previous versions of your document.**

You can right-click on the file and select “View previous versions” or from the web interface, right click and select Previous versions:

![image](/img/image_12.png "image")

Either way, you’ll end up viewing the version history for your document, which should look something like this:

![image](/img/image_15.png "image")

If you click on Restore, you’ll get back your previous version of the file. Note that this only works if you’re saving frequently and connected to DropBox – if you’re working offline the cloud-based features of DropBox won’t be as much help (you’ll only be able to get the last version that you synchronized with DropBox’s servers).

After restoring, the new file is simply added to the version history, so your current (newer) version is not lost:

![image](/img/image_18.png "image")

## 2\. DropBox Keeps Your Deleted Files

Version history is great, but what if you delete the file? Or the whole folder? How are you going to right click on the file and view its previous versions _then_? DropBox has you covered in this case as well. Let’s walk through it together so you believe it actually works.

**Go ahead, delete the VersionTest.txt file (or whatever you called it).**

![image](/img/image_27.png "image")

It’s pretty much gone, both in Windows Explorer and on the DropBox website at this point.

**On the website, click the _Show deleted files_ icon**

![image](/img/image_26.png "image")

You should see something like this:

![image](/img/image_25.png "image")

**Restore the file by right-clicking on it**

![image](/img/image_32.png "image")

You should immediately see a notification that the file has been added back into your DropBox:

![image](/img/image_33.png "image")

It’s that easy to get back files that you’ve accidentally deleted (or a colleague has). Note too that this is how you permanently delete files, so if you want to make sure something is truly gone, this is the way to do it.

## 3\. Sharing Files

The last area in which DropBox shines is for sharing files. There are several scenarios this covers. The simplest is that you merely want to send someone a file, and it’s too big for an email. The second is that you want to share the files with a wider audience, perhaps as part of a blog post. And the third common scenario is where you want to collaborate with one or more other individuals through a shared folder full of files. DropBox handles all of these (though for blog posts/online articles, it may be better to favor something like uploading to your web server or hosting the files on Amazon EC2, since these probably don’t have DropBox’s space restrictions).

**Share a (big) file with someone via email**

You can send a link to any file in your DropBox to someone, who can then download it (or add it directly to their own DropBox). There are [many custom services out there for sending big files](https://www.google.com/search?q=send+big+files) but DropBox does the trick for me. Once the other party confirms they’ve downloaded the file, you can delete it out of your DropBox to free up the space.

**Share files on the web**

You also can share files on the web just as easily. You can also share folders, and there’s even a Public folder, the contents of which are all shared, by default. Again, for permanent things like articles, you may not want to use DropBox (unless you’re committing to keep the files there forever even if you need the space), but for quick things like distributing files at a user group or training class, this works great.

DropBox also has been improving their support for photos and videos, and has a nice timeline view of all such content you can access from the website.

**Share files and collaborate with others**

A decade ago, the best way to collaborate on a group of files was typically to use a network file share. Most enterprise organizations still go this route. However, more and more of today’s companies use DropBox for this purpose. It offers the usual cloud vs. on-premise benefits (and drawbacks). It works best for files that are generally only being edited by one individual at a time. If you’re looking to collaborate on one document in realtime, then Google Docs or Office365 are probably better choices. One advantage of DropBox over these services is that the files are stored locally, so if you’re disconnected, you still have access to them (and can modify them, with your changes being persisted next time you connect). Web-based tools generally don’t support this scenario.

To invite someone to collaborate with you on a DropBox folder, just right click on it in the web interface and choose Invite to Folder.

![image](/img/image_36.png "image")

You can control whether people you invite can themselves invite others. Once the folder is shared with others, you can of course later kick people out, or transfer ownership of the folder to them.

![image](/img/image_39.png "image")

Incidentally, if you’re looking to get more free space, inviting non-DropBox users to folders is a great way to do that (assuming they actually sign up and join your folder).

## Summary

If you’ve never heard of DropBox before, hopefully some of this was useful to you. Note that I don’t work for DropBox or get anything from this unless somebody signs up via my referral link, and in that case it’s just a little more space. I’m just a big fan of the service because it makes my life easier. If you’re fairly mobile, own more than one device, don’t want to have to back up full computers in order to have near-real-time backups of your most important day-to-day files, or need to collaborate on files with others in and out of your organization and on and offline, DropBox may be worth checking out. If that’s not you, then really what compelled you to read all the way to the end of this article?
