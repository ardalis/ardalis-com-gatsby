---
templateKey: blog-post
title: Adding Master Page Support to Dynamically Created Pages
path: blog-post
date: 2006-07-21T03:25:50.758Z
description: "Yesterday I wrote about AspAlliance.SimpleCms, which is coming
  along still today. One hurdle Brendan and I were facing was how to allow a
  dynamically created (from a PageHandlerFactory) page to specify a master page.
  "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.Net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Yesterday I wrote about [AspAlliance.SimpleCms](http://aspadvice.com/blogs/ssmith/archive/2006/07/19/19797.aspx), which is coming along still today. One hurdle Brendan and I were facing was how to allow a dynamically created (from a PageHandlerFactory) page to specify a master page. The idea is that the page, which resides in a separate assembly from the main web application, will use a master page specified within web.config and residing in the main web application. Let me walk through our steps…

First, you would think you could just set the Page’s MasterPageFile property in Page_Load and everything would work, but that would be naive. Doing so results in a very helpful (seriously – no sarcasm this time!) error message:

## *The ‘MasterPageFile’ property can only be set in or before the ‘Page_PreInit’ event.*

At this point, the next logical step is to move the line of code into Page_PreInit. Doing this in a real ASPX page avoids the above error (but doesn’t quite actually work – more on that below), but doing this in our PageHandlerFactory served page results in a NullReferenceException like this one:

[NullReferenceException: Object reference not set to an instance of an\
object.]\
System.Web.Hosting.VirtualPathProvider.CombineVirtualPaths(VirtualPath\
basePath, VirtualPath relativePath) +6\
System.Web.UI.MasterPage.CreateMaster(TemplateControl owner, HttpContext\
context, VirtualPath masterPageFile, IDictionary contentTemplateCollection)\
+113\
System.Web.UI.Page.get_Master() +49\
System.Web.UI.Page.ApplyMasterPage() +17\
System.Web.UI.Page.ProcessRequestMain(Boolean\
includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +1373

Simon Calvert pointed me to the fix for this: Set AppRelativeVirtualPath for the dynamic page, first. So, for instance, if the page is going to be named “template.ashx” then you need to have the following:



this.AppRelativeVirtualPath =“~/template.ashx”;

this.MasterPageFile =“~/Site.master”;

This is great, now we were getting somewhere, except that inside our Page’s Render() method, when we went to add a Content control and set its ContentPlaceHolderID property, we were met with an exception stating “Setting the ContentPlaceHolderID property of System.Web.UI.WebControls.Content is not supported.” Using Reflector revealed that it could only be set when DesignMode was true.

I thought we were close to sunk here, but some more Q&A led to a solution from RyanTS, who suggested that I could use Page.AddContentTemplate() with my own ITemplate class to get things. So I did and it did, at least in a very simple test (I’ll try it in SimpleCms tomorrow).

Here’s my simple test page, which works, given a simple Master page with a single ContentPlaceHolder1:

```
publicpartialclass_Default: System.Web.UI.Page

{

protectedvoidPage_PreInit(objectsender,EventArgse)

{

this.AppRelativeVirtualPath =“~/default.aspx”;

this.MasterPageFile =“~/Site.master”;

base.AddContentTemplate(“ContentPlaceHolder1”,newTestContent());

}

}

publicclassTestContent: System.Web.UI.ITemplate

{

voidSystem.Web.UI.ITemplate.InstantiateIn(Controlcontainer)

{

container.Controls.Add(newLiteralControl(“Hello World”));

}
```



<!--EndFragment-->