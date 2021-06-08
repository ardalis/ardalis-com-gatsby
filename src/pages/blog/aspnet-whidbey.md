---
templateKey: blog-post
title: ASP.NET Whidbey Overview
date: 2004-03-29
path: blog-post
description: ASP.NET 2.0 and Visual Studio 2005, collectively referred to as 'Whidbey', are approaching their first beta release. These two products have a huge feature set and will revolutionize how ASP.NET developers build solutions. This article attempts to cover a few of the major features that will be included.
featuredpost: false
featuredimage: /img/whidbey.png
tags:
  - ASP.NET
  - Whidbey
category:
  - Software Development
  - Productivity
comments: true
share: true
---

## Introduction

ASP.NET was first previewed at PDC in July of 2000.  The first beta followed about a year later and the actual RTM of ASP.NET 1.0 came in February of 2002.  ASP.NET 1.1 and Visual Studio 2003 came about a year after that, but did not include many feature updates.

ASP.NET 2.0 / Visual Studio 2005, collectively code-named 'Whidbey', have been in development since before ASP.NET 1.0 was officially released.  This next version will not be as revolutionary a change as the update from ASP 3.0 to ASP.NET 1.0 was, since it builds on a common foundation provided by the Common Language Runtime and the .NET Framework.  However, this new release really takes things to the next level in terms of developer productivity.

Although ASP.NET is leaps and bounds better than legacy (or, if you prefer, classic) ASP, there are still many common scenarios that require a lot of work and code to accomplish.  Databinding, authentication and authorization, site templates, and pageable/sortable/editable data grids are all prime examples of things that are still too hard to do with ASP.NET 1.x.  One of the goals of Whidbey is to reduce the amount of code developers will have to write by **2/3**.  Other goals include improving developer productivity, performance, easier configuration and hosting, and providing a single set of controls for all devices.

## New Feature List

There are a LOT of new features in ASP.NET 2.0 / VS 2005.  This is just a simple list of features -- we'll look at some of the more notable ones in detail further in this article.

- Master Pages
- New Web Controls
  - BulletedList
  - FileUpload
  - HiddenField
  - Panel
  - DynamicImage
  - MultiView / View
  - Wizard
  - Login / LoginName / LoginStatus / LoginView / PasswordRecovery
  - AdRotator (improved)
  - ImageMap
  - SiteMapPath (breadcrumb based on SiteMap file)
  - Buttons/HyperLinks can record impressions/clicks
  - TreeView
  - GridView (better DataGrid)
  - DetailsView (single-record vertical display control)
- New Data Controls
- No Code DataBinding
- New Visual Studio IDE (a la Web Matrix)
- Language Enhancements (generics, partial classes, anonymous methods)
- Precompilation and no-source deployment
- Better codebehind model
- /Code folder
- More configuration support
- Built-in connection string encryption
- Better ASP.NET tracing
- Themes
- Skins
- Site Counters
- ADO.NET PageReader
- ADO.NET SqlResultSet
- XML XQuery Support
- Client focus / Client Scrolling support
- Cross-Page Postbacks (with full event and intellisense support)
- SQL Cache Invalidation
- Validation Regions
- Better Mobile Support
- ObjectSpaces (object-relational-mapping)
- Web Parts
- Personalization Engine
- Membership Engine
- Role Manager
- Site Directory Definition (and data sources)
- URL Mapping

## Master Pages

With ASP.NET 1.x, it's too hard to create a common look for a site.  The standard options include creating header and footer (at least) user controls and adding them to every page, or using a base page class, or some combination of these two.  A couple of good articles on these techniques can be found here:

- [Page Templates: Introduction](http://aspalliance.com/91), [Paul Wilson](http://aspalliance.com/author.aspx?uId=1746)
- [Page Templates: Designer Issues](http://aspalliance.com/92), [Paul Wilson](http://aspalliance.com/author.aspx?uId=1746)
- [Page Templates: Server Forms](http://aspalliance.com/93), [Paul Wilson](http://aspalliance.com/author.aspx?uId=1746)
- [Base Page and User Control Classes](http://aspalliance.com/63), [Robert Boedigheimer](http://aspalliance.com/author.aspx?uId=37622)

The downside to these options is that they're not natively supported by the framework, so any solution is going to be a custom solution, and thus not something you're likely to be able to reuse between organizations.  Further, there's not much IDE support for any of these techniques.

With Master Pages, it is very easy to create a template page for the site (a 'master' page) and save it with its own extension (.master).  Any page can inherit its visual formatting from a master page through a page directive.  Master pages can inherit from other master pages.  Content can be place in one more more regions within a master page, not just a single place around which all other UI is placed (as is common with today's techniques).  Lastly, there is excellent IDE support for master pages, as this screenshot demonstrates:

![Master Page IDE](.img/whidbey-master-page.gif)

This is a page that has specified a master page.  As you can see, some of it is greyed out and some of it is enabled.  The grey portion is the master page content, and can be edited only by right clicking and selecting "Edit Master".  The other section of the page is a content area that can be manipulated on this page.  In this case, this is the home page of an "Internet Site" that can be created as a sample project in either VB or C#.  More on these sample projects later

## Wizard Control

A common requirement in data entry or registration form pages is to collect user data across a series of pages.  For instance, a bank account application might require personal information from one or more applications, business information, financial information, etc., each on separate forms.  Or an ecommerce application my collect information about billing address, shipping address, and payment on separate forms.  In ASP.NET 1.x, this can be done, but there is not built-in support for it, so a lot of code must be written to support updating the page state, or many separate forms must be written and state managed between them.  It's messy.

The Wizard web control is designed to make these scenarios easier.  The wizard control allows the developer to create templated "steps" within the control, and manages the state throughout the steps.  Validation within individual steps can be completed without incomplete steps' RequiredFieldValidators firing (as is a problem in 1.x).  Users can navigate forward, backward, or jump to a specific step within the wizard.

At design time, it's very easy to manipulate the Wizard and its step templates, as this screenshot demonstrates:

![Wizard Screenshot](/img/whidbey-wizard.gif)

Here's an example of a very simple Wizard control in action, using the March 2004 Preview build of VS2005:

```aspnet
<%@ page language="C#" %>
<script runat="server">
    void Wizard1_FinishButtonClick (object sender, WizardNavigationEventArgs e)
    {
        Response.Write ("Finish clicked!");
    }
</script>

<html>
    <head runat="server">
        <title>Untitled Page</title>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <asp:Wizard ID="Wizard1" Runat="server" SideBarEnabled="true" OnFinishButtonClick="Wizard1_FinishButtonClick">
                    <WizardSteps>
                        <asp:WizardStep Runat="server" Title="Step 1">
                            This is content for STEP 1.
                        </asp:WizardStep>
                        <asp:WizardStep Runat="server" Title="Step 2">
                            This is content for STEP 2.
                        </asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
            </div>
        </form>
    </body>
</html>
```

## GridView / DetailsView

If you've done any heavy lifting with ASP.NET, you've probably at least played with the DataGrid control.  This is the "Mother of All Controls" in ASP.NET 1.x, being one of the biggest honkin' web controls around.  However, despite its wealth of functionality, it still requires **a ton** of code to get to do anything beyond displaying data in a single fashion.  Since one of the goals of Whidbey was to reduce total code written by 2/3, the DataGrid was targeted for some major overhaul work to help address this issue.  The most common things that are added to the standard DataGrid, each of which requiring more code than the last, are paging, sorting, and editing.

The answer is the GridView.  Want to add paging?  Just turn it on and it works.  Want sorting?  Same deal.  Bidirectional sorting?  No problem.  Editing?  Again, it just works.  Even databinding, which for the DataGrid requires at least a line of code to call .DataBind() has been streamlined so that it can be done without any code by using the new fooDataSource controls (where **foo** is the type of Data Source).

An example GridView from the Pubs database with paging and sorting enabled (and no code required) is shown here:

![GridView Screenshot](/img/whidbey-gridview.gif)

With a minimal amount of code, this GridView can be modified to include support for Master-Detail viewing, where selecting an author will update a separate GridView showing that author's titles.  Further, selecting a title will bring it up in a DetailsView for editing, again with little or no code.  Here's a completed page, built on the PDC Preview build of Whidbey, which rolls these features together and uses less than 10 lines of code.

![GridView Screenshot](/img/whidbey-detail.gif)

Although the object model for the GridView is very similar to the DataGrid, its **Columns** collection is populated with *fooField* objects, rather than *fooColumn* objects.  For example, while a DataGrid has a **BoundColumn** control, the GridView has a **BoundField**.

## Authentication Controls

A very common task in web applications revolves around determining who the current user is and whether or not they are authorized to access a particular resource.  To support these tasks, a suite of security controls is included in ASP.NET 2.0.  These controls include:

- Login
  - Prompts user for login name and password
  - Supports usual options such as Forgot Password link and Remember Password? checkbox
  - Integrates with Membership provider
- LoginName
  - A simple control that displaysthe current logged-in user's name (or nothing if the user is not authenticated).
- LoginStatus
  - Another simple but very common control, this one displays a link to the Login page if the user is not authenticated, otherwise it displays a link to the Logout pages
- LoginView
  - Allows custom content to be displayed based on whether the user is logged in.
  - Content can be customized for individual user roles
- PasswordRecovery
  - Displays a Forgot Password? dialog and allows you to easily choose one of several common mechanisms for sending or resetting a user's password

## Validation Groups

One of the coolest features of ASP.NET is its suite of Validation Controls.  The difference between validating user input in ASP.NET vs. ASP 3.0 with JavaScript is like night and day.  That said, the validation controls do have some severe limitations in ASP.NET 1.0.  One of the largest ones is that validation occurs strictly at the page level, so a page is either valid or it isn't.  This makes it impossible to use these controls to validate separate parts of one page (including panel-based wizard style pages where all the panels are in one page and visibility is controlled by the user's button clicks).

With ASP.NET 2.0, this problem is addressed through the introduction of Validation Groups.  All validation controls and all controls that cause a postback support this new property.  The ValidationGroup property is just a simple text field.  When a postback occurs, only those validators whose ValidationGroup matches the postback control's ValidationGroup (even if it is blank, the default) are fired.  This simple yet elegant solution solves a significant problem with the 1.x implementation of validation.

Validation groups are also supported in code.  A particular group's validity can be checked using `If (Page.Validate("GroupName")) Then`. Also, the standard Page.IsValid now evaluates the ValidationGroup associated with the last PostBack.

## Image Generation

ASP.NET 2.0 will have native support for dynamic image generation.  This is often done today using an ASPX page and setting the content type and using a bit of GDI+ from the System.Drawing namespace.  In ASP.NET 2.0, there will be some new base classes that will make this much easier, and a new file extension dedicated to this type of content, *.asix.  Coupled with these features will be a new web control, the DynamicImage control, which will make it easy to place generated images on a page.  Images may be stored in memory or on disk using these features, and will support automatic detection of supported formats for mobile devices and can convert the image on-the-fly to a supported type if necessary.

## URL Mapping

Another common problem with ASP.NET sites today is long, ugly URLs (look at any MSDN article for example).  While URL mapping can certainly be done today using either Application_BeginRequest in the global.asax or a custom HttpHandler, ASP.NET 2.0 makes common mappings simple by adding support for them to the web.config file.  A new configuration section, urlMappings, will allow individual 'fake' URLs to be mapped to their actual (probably much longer) counterparts.  A very common use for this would be to eliminate navigation-specific querystring data, such as that used by the IBuySpy or Rainbow portal applications.  Instead of having users navigate to `http://yourwebsite.com/Default.aspx?tabid=0` you can point them to `http://yourwebsite.com/Home.aspx`, and specify the mapping in the config like so:

```aspnet
<urlMappings enabled="true">
  <add url="~/Home.aspx" mappedUrl="~/Default.aspx?tabid=0" />
</urlMappings>
```

## Site Counters

Let's say you have a button on your page and you want to know how often it's clicked.  Or you just want to know how often users are viewing the pages in your application, but you're not a sysadmin and you don't want to deal with web logs and a log analyzer.  Well then, ASP.NET 2.0's site counters are for you.  These counters are built into the existing link and button controls, and use a built-in service or your own custom provider (the built-in service works with Sql Server or Access).  The counters simply track impressions and/or clicks over whatever timespan you specify (e.g. impressions/hour vs impressions/day -- one row of data will exist per timespan, so more granularity equals a larger database).

The main properties used for individual controls are `CountClicks` (bool), `CounterGroup` (string), and `CounterName` (string).  An example hyperlink:

```aspnet
 <asp:hyperlink  Text=“Click for Partner Details” NavigateUrl=“http://www.partnersite.com” CountClicks=“true” CounterGroup=“PartnerClicks” CounterName=“Partner1” runat=“server” />
```

Before these counters will work, the site counters need to be set up using the ASP.NET configuration tool (which unfortunately appears to be broken in the build I'm using at the moment).

You can also specify site-level counters through a section in web.config.  The config section is `<siteCounters>` but the exact syntax seems to be still up in the air at this point.  Suffice to say, you will be able to specify individual page paths or wildcard paths of page groups/folders you would like to track activity on.

## Client-Side Features

ASP.NET 2.0 has some frequently requested client side features, as well.  First, it was way too hard to add client side click handlers in ASP.NET 1.x (using the Attributes collection), so now there is an OnClientClick property that can be used.

Another frequent request was to improve support for client-side Focus.  Several features have been added to address this, including a Page.SetFocus(control) method which works today in the alpha builds of VS2005.  You can also declaratively set the default focus of a form by specifying a DefaultFocus in the `<form>` tag.  This also supports a DefaultButton property, which will ensure that when the user hits enter, that button is clicked.  I know these features will handle a LOT of frequent questions on several lists and forums I frequent.  Example syntax:

```aspnet
<form DefaultFocus=“textbox1” DefaultButton="button1" runat=“server”>
```

You'll also be able to specify an individual control and call its Focus() method to set focus to that control.  With the current build (March 2004 Preview) I'm not having much luck with the `<form>` and .Focus() techniques, but the Page.SetFocus(control) method has worked since before the PDC03 preview bits.

The validation controls also have a new property, `SetFocusOnError` (boolean), which will set the focus to the first control on the page that had a validator fail.  This seems to be working currently.

## Visual Studio 2005

Visual Studio 2005 has a number of new improvements over VS.NET 2003.  One of the big ones is that FrontPage Server Extensions are no longer required.  In fact, Microsoft has embraced a new Internet standard -- they're really leading the pack on this one -- called File Transfer Protocol, or FTP.  Ok, so maybe it's not that new, but it **is** supported (*finally*) by VS2005, along with a number of other methods for connecting to webs.

### No more project files (for websites)

VS2K5 uses a directory-based model that no longer requires project files.  You can edit any web anywhere.  The performance impact of this change is pretty dramatic for big sites.

### No More Single DLL Per Website

It's no longer necessary to build the entire web application into a single DLL, which made team-development of a single web app a nightmare.  In fact, by default you're never building web pages at all anymore.  It's very much just like it was back in the 'good old' ASP 3.0 days where to build a web form you just saved the file, uploaded it, and to test you viewed it in your browser.  Everything is compiled server-side.  Now you can modify a single page in the application and not worry that you'll have to rebuild the whole thing (and restart the whole app due to changes in the bin folder) just to touch one page.

### HTML Source Preservation

In theory, and so far the theory is proving to be true from my experience, the tool will never, ever, ever reformat or mangle your HTML code.  It does support some reformatting features, but you specify when and if you use these.  There is also going to be built-in support for a variety of schemas against which the HTML can be validated, including XHTML.

### Intellisense Everywhere

No longer limited to codebehind files, you'll now see intellisense in HTML view, including for HTML elements.  In page directives.  In `<script runat="server">` blocks within HTML, etc.  All of these work in the March04 preview build.  A big one that's not there yet but should be before release is web.config intellisense (but there should also be a web.config GUI editor, too, by then).

### HTML Tag Navigator

Displays nesting depth at the bottom of the editor (e.g. `<html><body><form><table>` to show that you're inside a `<table>` tag).  Will also support collapsing/expanding of HTML elements, similar to #regions in code.

### Built-In Test Web Server

No longer requires IIS, so XP Home users can develop ASP.NET pages.  The test web server is built on Cassini, which ships with the free Web Matrix tool (and for that matter, a lot of the ideas that went into VS2K5 came from Web Matrix).  Only responds to requests from localhost, and not optimized at all for any significant traffic, this is purely a test web server.

## Sample Web Projects

There are two powerful sample web projects built into VS2K5 whch provide a head start toward building two common types of applications.  By release, there may be more such samples.  These two samples are an Intranet 'portal' site and an Internet site.  The main difference between these two sites is their target audience -- internal users versus anybody on the 'net.

The Intranet Portal is a great application to use to get up to speed with how to build sites with ASP.NET 2.0.  It includes support for master pages, a sitemap file, web parts, some security controls, and a bunch of web controls.  Web parts in particular are an awesome way to provide users with customization options.  Writing about them doesn't do them justice -- if you haven't seen them you really have to try them out to believe how cool they are.  Using web parts, users can customize the layout of the page to suit them, using a drag-and-drop interface.  The user literally just clicks a link to 'customize page' and from there they can drag controls from one column or header or section to another.  Controls can be deleted or added from a 'catalog' as well.  When they're done, they just click another link to finish customizing the page, and from that point on whenever they come back, the page will be as they left it.

The Site Map file bears mentioning simply because I think almost all ASP.NET 2.0 developers will end up using this.  It can be used along with the SiteMapDataSource control to bind site navigation data to controls like the TreeView or the SiteMapPath (breadcrumb) control, allowing for easy navigation updates.

The Internet site is very similar to the Intranet site except that instead of relying on windows authentication, it has support for authentication using forms authentication.  It also has a photo album built into it and some reports for site counters.  Naturally the authentication pieces use the new built-in security web controls, and everything is tied into the membership provider by default.  The site also uses standard features like master pages and sitemap files to good effect.  It's a great starting point for an Internet site, or a great way to learn how to use many of the new tools and techniques available in ASP.NET 2.0.

## Summary

Whidbey, or ASP.NET 2.0 / Visual Studio 2005, should be available as a full release in about a year, give or take a couple of quarters.  The first beta is due in June 2004, and a second beta will likely follow before the end of the year.  When the second beta comes, it is widely anticipated that it will include a 'Go Live' license like the second beta of ASP.NET 1.0 carried, and many organizations will begin hosting production sites on the beta bits (as many did on ASP.NET 1.0 Beta 2).  With the wealth of new features, many of which eliminate effort that must be expended on virtually every web application built using 1.x code, it will definitely provide a competitive advantage for organizations to move to 2.0 quickly.  The learning curve is nothing compared to moving to 1.0 from legacy ASP, and the productivity enhancements are huge.  In this article, I've only scratched the surface of what is coming in 2.0, and hopefully my enthusiasm for this new release of ASP.NET is evident.

Originally published on [ASPAlliance.com](http://aspalliance.com/28_ASPNET_Whidbey_Overview).
