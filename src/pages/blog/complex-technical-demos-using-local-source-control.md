---
templateKey: blog-post
title: Complex Technical Demos Using Local Source Control
path: blog-post
date: 2011-03-01T22:04:00.000Z
description: "Last summer at the Software Engineering 101 event put on by
  NimblePros in Cleveland, I saw Kevin Kuebler do a demo using git or Mercurial
  to iterate from phase of the project he was building to the next.  "
featuredpost: false
featuredimage: /img/computer-311339_1280-760x360.png
tags:
  - demos
  - git
  - presenting
  - speaking
  - subversion
category:
  - Software Development
comments: true
share: true
---
Last summer at the [Software Engineering 101 event put on by NimblePros in Cleveland](http://nimblepros.com/news-and-events/software-engineering-101---cleveland.aspx), I saw Kevin Kuebler do a demo using git or Mercurial to iterate from phase of the project he was building to the next. It worked amazingly well and I thought I would document how to set this up yourself, so that when you’re giving a technical presentation that involves a somewhat complex set of changes to a project, you can easily step through the updates without having to resort to a lot of on-stage typing, code snippets in multiple files, or switching between different projects/folders.

For this example, I’m going to be using as a base a stock ASP.NET MVC 3 web project, but that choice was made somewhat arbitrarily and you could certainly use this technique with any project, and even with non-software demos that involve many changes to files. At the start, I simply have this project, and I’ve checked it into my personal SVN repository (note, I haven’t made the jump to Hg/Git yet for this). One of the cool things I want to show here, too, is how you can combine Mercurial (Hg) and other source control tools. You certainly don’t have to do so, and if you don’t keep your presentations in any kind of source control currently, you can ignore this unless it spurs you to start doing so (which might be a good idea). In my case, I’m going to create a local Hg repository which I will then check into my remote SVN repo. Good stuff. Here’s a screenshot of the starting root folder:

![image](<> "image")

The next step is to add an Hg repository. You’ll want to [install TortoiseHg](http://tortoisehg.bitbucket.org/) if you want to follow along with my steps, though you’re certainly able to do these same steps from the command line. Assuming you have TortoiseHg, just right-click in your project root folder, go to the TortoiseHg menu option, and select Create Repository Here.

![image](<> "image")

You should see something like this showing the repo was created successfully:

![image](<> "image")

Next, create a command prompt in the same folder location. You can do this from Windows Explorer by using shift-rightclick, and then selecting Open command window here (not sure which versions of Windows this works on – I’m running Windows 7 and I’m pretty sure it’s been in there for a few versions).

![image](<> "image")

From there, if you simply type ‘hg’ into the command prompt, you should get output like this, showing that hg is in your path and usable (which will become important).

![SNAGHTMLa4c332](<> "SNAGHTMLa4c332")

Now it’s time to go and write some code. Get your demo into its basic, starting state where you want it when you start to show it as part of your presentation. In my case, to keep things simple, I’m just going to do some simple edits to the home page of the page, adding a line saying this is the first part of the demo:

![image](<> "image")

Now that I have the opening version of my demo done, I’m going to check it into Hg (but not SVN). You can do your commits from the command prompt, but in my case I’m just going to use Hg Commit from Windows Explorer:

![image](<> "image")

At this point, you may need to ignore some of the files, like the .svn folders, since this is the initial checkin. It’s not as important that you ignore all kinds of files like /obj, /bin, .svn, .suo, etc. and in fact you may even want to check in your /bin folder if you want to be able to show your demos without even needing to rebuild. However, in my case I’m ignoring these folders just as I do with my production source control provider. You can see the filters I’m using here:

![image](<> "image")

Select all of the files, click Commit, and you should see a dialog telling you:

> committed changeset 0: \[somehexvalue]

If it doesn’t work, you’ll need to troubleshoot that before proceeding. It’s important to note the changeset number. If you’re trying to follow these steps in an existing repository, your changeset may be a much higher number than 0!

Now it’s time for me to complete my demo steps. Naturally in a real scenario I would be doing major changes that touch many files, not simple things I could easily accomplish typing by hand or using code snippets. For this demo, I’m going to update my home page text:

![image](<> "image")

Now I need to perform another commit. If your Hg Commit windows is still open, you can just Refresh it to see the changed files. Add your comments, and commit. Your

new changeset should be one number higher than the previous one (in my case, 1). I make one more update (this is the \*third\* part) and check in. Now, you can look at the Hg Repository Explorer and you should see something like this:

![SNAGHTMLbca18f](<> "SNAGHTMLbca18f")

Now you’ve done the hard part – recording your demo. Now it’s time to rehearse it. Jump back to that command prompt and type in:

> hg update 0

This will update your project to revision 0 in Mercurial – the initial state of the demo. If you’re running Visual Studio, it will ask you to reload the file(s) that have changed. When you refresh your site, you’ll see you’re back at the first part of the demo. Show the audience what you want to show them, and when you’re ready to move to the next step, simply type:

> hg update 1

and now you’re on to the 1st update in your demo. Repeat until you’re done. Note that you can just hit “\[uparrow] \[backspace] 1 \[enter]” rather than typing in the whole command so it only takes 4 keystrokes to make the update at each step. You can also use the shortcut “hg up 1” if you like; “up” is an alias for “update.”

[![SNAGHTMLc1eabf](<> "SNAGHTMLc1eabf")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Presentation-Tip_BE16/SNAGHTMLc1eabf.png)

If you don’t like the idea of using the command window, you can do the same thing from the repo explorer. Just right click on each step and choose update:

![image](<> "image")

It’s not quite as fast, but it certainly works, too.

**Wrapping Up**

When you’re happy with the demo, and you want to check everything into your actual remote revision control system, you can reset the demo to whichever state you want it to be in (probably either the initial update 0 state or the final state), and then check everything into source control. In my case as I mentioned that means Subversion. When you do this check-in, be sure that you \*do\* include the .hg folder structure, so that next time you pull from SVN, either on this machine or on another, you’ll get the demo complete with the Hg repository that has all of the steps of your demo in it, and you’ll be able to run your demo in a repeatable fashion using this technique even from different machines.

[![SNAGHTMLc5bdb7](<> "SNAGHTMLc5bdb7")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Presentation-Tip_BE16/SNAGHTMLc5bdb7.png)

Note too that if you’re presenting with multiple monitors, you can certainly keep the command window off of the projector screen, so your updates are not a distraction to your audience. If you do use this in your presentation, please post a comment here letting me know how it worked for you, and any tips you have to share. Thanks again to Kevin for the idea and his feedback on this article!

[Download HgDemo Including Hg Repository](http://stevesmithblog.s3.amazonaws.com/HgForDemo.zip)