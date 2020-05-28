---
templateKey: blog-post
title: Codebehind Files in ASP.NET MVC are Evil
path: blog-post
date: 2008-09-17T02:07:00.000Z
description: With the current versions of ASP.NET MVC (Preview 5) that have
  shipped, the default MVC template sites all include codebehind files for the
  ASP.NET views. For example, here’s a screenshot of what a new project looks
  like the one at right.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Codebehind
category:
  - Uncategorized
comments: true
share: true
---
With the current versions of ASP.NET MVC ([Preview 5](http://www.codeplex.com/aspnet/Release/ProjectReleases.aspx?ReleaseId=16775)) that have shipped, the default MVC template sites all include codebehind files for the ASP.NET views. For example, here’s a screenshot of what a new project looks like the one at right. Further, adding a new ASP.NET MVC View Page will also include a .aspx.cs and a .aspx.designer.cs file by default.

![](/img/codebehind1.png)

The question is, why is that codebehind file there, and what are the consequences of having it there by default? If you watch a few screencasts and blog tutorials from [Rob](http://blog.wekeroad.com/),[Phil](http://haacked.com/archive/2008/08/29/asp.net-mvc-codeplex-preview-5-released.aspx),[ScottGu](http://weblogs.asp.net/scottgu/archive/2008/09/02/asp-net-mvc-preview-5-and-form-posting-scenarios.aspx),[ScottHa](http://www.hanselman.com/blog/ASPNETMVCPreview4UsingAjaxAndAjaxForm.aspx), et al, it’s pretty rare that you’ll find anybody actually putting any real code into the codebehind files for the views. In fact, I’m hoping that in addition to negating the need for codebehind files (there is one – wait for it), Microsoft can also take the next available opportunity to use a different file extension for views to make it incredibly, abundantly clear that they are not to be used like traditional ASP.NET web forms.

## Why Are They There?

Today, codebehind files are useful if you want to have a strongly typed View<T>. The easiest way to achieve this is to edit the codebehind file and change:

```
public partial class Register : ViewPage
```

to

```
public partial class Register : ViewPage<Customer>
```

and voila! Now you can reference Customer in a strongly typed fashion from your View’s ASPX file, off of ViewData.Model. Apart from this, the codebehind file may be a useful place to store some display-only functionality or a property that makes accessing a piece of ViewData simpler. Both of which could also easily be done inside the ASPX page – it’s just a matter of personal preference.

Tomorrow (as in, with some future release, I’m guessing), codebehind files may be important for interacting with custom controls. Today that story just isnt’ fleshed out yet.

Getting a View to work without a codebehind is simple provided you don’t need a strongly typed view:

<%@ Page Inherits=”ViewPage” %>

One could still achieve strongly typed views, if they were important, by using the [generic backtick notation](http://blogs.msdn.com/nazimms/archive/2005/01/25/360324.aspx) like this (if VS supported it, which I’m not able to get working so I’m assuming it does not today):

```
<%@ Page Inherits="ViewPage`1[Customer]" %>
```

## Why are Codebehind Files in Views Evil?

The problem with having a codebehind file for a View comes down to temptation and habit. If it’s there, anybody who’s been using “classic ASP.NET” for the last 8 years or so is accustomed to putting all kinds of things into the ASP.NET codebehind files. From click handlers to Page_Load to event wireups to changing display settings based on the value of a data item – most web forms apps have a ton of logic in their codebehind files. And that’s great – but not typically how it should be done with ASP.NET MVC.

With ASP.NET MVC, the View should be dumb. It should be stupidly simple. It should have no logic in it to speak of, not least of all because it’s difficult to test, but also because that’s the Controller’s whole purpose in life. If you need to do any kind of business logic, it should happen in the Controller. Need to format something a particular way if it’s outside of a particular range? Great, do it in the controller and pass the necessary CSS string into the View as ViewData. Then write a test that proves it works. Beautiful.

Having a codebehind file is a temptation. Developers who are new to ASP.NET MVC (and who isn’t – it’s not even a year old and not released yet) but who have a background with web forms (as most will) are going to have to resist a natural inclination to put code into their codebehind files like they always have. This will make the logic in the View more difficult to test and at worst might even involve logic in the codebehind making calls directly to a database or web service and thus completely bypassing the separation of Model from View as well.

*And of course while we’re removing the Codebehind files from the default template, we’ll want to remove the .designer.cs/vb files as well!*

## Fall into the Pit of Success

If having the codebehind file available by default is a temptation to stray from the canonical correct MVC path, then not having it there by default **would help most developers do things the right way without thinking about it**. That’s what is meant by helping them to fall into a “pit of success” (not sure who came up with that term, but kudos for it). Sure, some might simply add in a codebehind file (this would still be simple to do) or just write a bunch of complex logic within the ASPX file, but many more would do the right thing and place this logic in their Controller. New developers joining their first ASP.NET MVC project would immediately realize that Views were not the same as Web Forms because they lack the codebehind files typical of web forms. And the 95% of Views that don’t need a codebehind file for anything would have half as many files cluttering their solutions, without the need for manual deletion of the .aspx.cx / .aspx.vb files.

Some folks really want to have codebehind files included. I think they’re a small minority, and if/when codebehind files are necessary for a View, it will still be simple to Right-Click->Add File to get one. But in the default case, when a new View is added to an ASP.NET MVC project (or when a new project is created from the default template), it would only include the ASPX file(s) (and perhaps in a later rev of Visual Studio/ASP.NET, an ASVX file), and no codebehind or designer files.