---
templateKey: blog-post
title: "FIX: LoginView Has No Child Controls"
path: blog-post
date: 2007-08-07T11:57:40.628Z
description: "We ran into this issue today: A LoginView control that has always
  worked just fine was failing to have any contents on a PostBack. Stepping
  through it and checking things in the Immediate Window confirmed that it had a
  Controls.Count of 0."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

We ran into this issue today: A LoginView control that has always worked just fine was failing to have any contents on a PostBack. Stepping through it and checking things in the Immediate Window confirmed that it had a Controls.Count of 0. Looking at it in ASP.NET Trace also showed that, after a postback, it had no controls below it in the control tree. This was a problem since it contained a DropDownList and a TextBox that we needed to save the contents of in a click handler, but they were null.

Of course we were accessing these sub-controls using the [recursive FindControl() method](http://ardalis.com/blogs/ssmith/archive/2006/08/23/Add-Profile-Items-in-CreateUserWizard-and-Recursive-FindControl.aspx) that should be included in ASP.NET some day. The LoginView had worked before, but in the last week or two it had stopped. Looking at what had changed recently, nothing much jumped out. About the only major change that had been done to the page had been to add some validation controls to it, and those were all working fine, as were other LoginView controls on the page (even ones with the same RoleGroups).

Turns out, some of the work that was being done to set those validation controls was happening in Page.OnInit(). And one of those validation controls lived inside the problematic LoginView control (named **LoginView1**, natch). So, this line of code ultimately was the culprit because it was being called too early in the life cycle of LoginView1:

PeterBlum.VAM.TextLengthValidator NotesLengthValidator = Common.FindControl(LoginView1, "NotesLengthValidator") as PeterBlum.VAM.TextLengthValidator;

By moving this logic into Page_Load, the problem disappeared. I don't recall now why I was doing it in OnInit – hopefully I won't be introducing **another** regression by moving it to Page_Load.

**Summary: If you try to access a LoginView's Controls() collection in Page.OnInit, it will not have any, and you'll prevent it from creating them when it is supposed to do so.**

Thanks to [Mike Harder](http://blogs.msdn.com/mharder) for help diagnosing this.

<!--EndFragment-->