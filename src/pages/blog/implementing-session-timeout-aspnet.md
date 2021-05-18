---
templateKey: blog-post
title: Implementing a Session Timeout Page in ASP.NET
date: 2008-04-02
path: blog-post
description: In this article, Steve walks through the steps required to implement a Session Logged Out page that users are automatically sent to in their browser when their ASP.NET session expires. He examines each step with the help of detailed explanation supported by relevant source code.
featuredpost: false
featuredimage: /img/implementing-session-timeout.png
tags:
  - ASP.NET
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

In many applications, an authenticated user's session expires after a set amount of time, after which the user must log back into the system to continue using the application. Often, the user may begin entering data into a large form, switch to some other more pressing task, then return to complete the form only to find that his session has expired and he has wasted his time. One way to alleviate this user interface annoyance is to automatically redirect the user to a "session expired" page once their session has expired. The user may still lose some work he was in the middle of on the page he was on, but that would have been lost anyway had he tried to submit it while no longer authenticated. At least with this solution, the user immediately knows his session has ended, and he can re-initiate it and continue his work without any loss of time.

## Technique

The simplest way to implement a cross-browser session expiration page is to add a META tag to the HTML headers of any pages that require authentication and/or a valid session. The syntax for the META tag, when used for this purpose, is pretty simple. A typical tag would look like this:

```html
<meta http-equiv='refresh' content='60;url=/SessionExpired.aspx' />
```

The first attribute, http-equiv, must be set to refresh. The META tag supports a number of other options, such as providing information about page authors, keywords, or descriptions, which are beyond the scope of this article (learn more about them [here](http://www.w3schools.com/tags/tag_meta.asp)). The second attribute, content, includes two parts which must be separated by a semicolon. The first piece indicates the number of seconds the page should delay before refreshing its content. A page can be made to simply automatically refresh itself by simply adding this:

```html
<meta http-equiv='refresh' content='60' />
```

However, to complete the requirement for the session expiration page, we need to send the user's browser to a new page, in this case /SessionExpired.aspx which is set with the url= string within the content attribute. It should be pretty obvious that this behavior is really stretching the intended purpose of the `<meta>` tag, which is why there are so many fields being overloaded into the content attribute. It would have made more sense to have a `<refresh delay='60' refreshUrl='http://whatever.com' />` tag, but it is no simple task to add a new tag to the HTML specification and then to get it supported in 1.2 million different versions of user agents. So, plan on the existing overloaded use of the `<meta>` tag for the foreseeable future.

With just this bit of code, you can start hand-coding session expirations into your ASP.NET pages to your heart's content, but it is hardly a scalable solution. It also does not take advantage of ASP.NET's programmability model at all, and so I do not recommend it. The problem that remains is how to include this meta tag into the appropriate pages (the ones that require a session) without adding it to public pages, and how to set up the delay and destination URL so that they do not need to be hand-edited on every ASPX page. But before we show how to do that, let us design our session expired page.

#### Listing 1 - Session Expired Page

```html
<@ Page Language="C#" AutoEventWireup="true" 
CodeBehind="SessionExpired.aspx.cs" 
Inherits="SessionExpirePage.SessionExpired"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Session Expired</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Session Expired</h1>
    <p>
    Your session has expired.  
    Please <a href="Default.aspx">return to the home page</a> 
    and log in again to continue accessing your account.</p>
    </div>
    </form>
</body>
</html>
```

#### Listing 2 - Session Expired Page CodeBehind

```csharp
using System;
namespace SessionExpirePage
{
    public partial class SessionExpired : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Abandon();
        }
    }
}
```

Of course the code in Listing 1 is extremely simple and you will want to update it to use your site's design, ideally with a Master Page. Note in Listing 2 the call to `Session.Abandon()`. This is important and ensures that if the client countdown and the server countdown are not quite in sync, the session is terminated when this page is loaded.

There are several ways we could go about including the session expiration META tag on a large number of secured pages. We could write it by hand - not a good idea. We could use an include file (yes, those still exist in ASP.NET) - even worse idea. We could write a custom control and include it by hand. Slightly better, but still requires touching a lot of ASPX files. We could create a base page class or extend one that is already in use. This is actually a promising technique that would work, but is not the one that I will demonstrate. You could easily implement it using a variation of my sample, though. Or you could use an ASP.NET master page. This is the simplest, most elegant solution, in my opinion, and is the one I will demonstrate.

In most applications I have worked with, it is typical to have a separate master page for the secure, admin portion of the site from the public facing area of the site. This technique works best in such situations. Essentially, the application's secure area will share a single master page file, which for this example will be called Secure.Master. Secure.Master will include some UI, but will also include a ContentPlaceHolder in the HTML `<head>` section that will be used to render the Session Expiration META tag. Then, in the Master page's codebehind, the actual META tag will be constructed from the Session.Timeout set in the site's web.config and the URL that should be used when the session expires (in this case set as a property of the master page, but ideally this would come from a custom configuration section in web.config). The complete code for the master page is shown in Listings 3 and 4.

#### Listing 3 - Secure.Master

```html
<@ Master Language="C#" AutoEventWireup="true" 
CodeBehind="Secure.master.cs" 
Inherits="SessionExpirePage.Secure" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="PageHead">
    <title>Secure Page</title>
    <asp:ContentPlaceHolder ID="head" runat="server">
    </asp:ContentPlaceHolder>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>
            Your Account [SECURE]</h1>
        <asp:ContentPlaceHolder ID="Main" runat="server">
        </asp:ContentPlaceHolder>
        <p>
            Note: Your session will expire in
            <%=SessionLengthMinutes %>
            minute(s), <%=Session["name"] %> .
        </p>
    </div>
    </form>
</body>
</html>
```

#### Listing 4 - Secure.Master CodeBehind

```csharp
using System;
using System.Web.UI;
 
namespace SessionExpirePage
{
    public partial class Secure : System.Web.UI.MasterPage
    {
        public int SessionLengthMinutes
        {
            get { return Session.Timeout; }
        }
        public string SessionExpireDestinationUrl
        {
            get { return "/SessionExpired.aspx"; }
        }
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            this.PageHead.Controls.Add(new LiteralControl(
                String.Format("<meta http-equiv='refresh' content='{0};url={1}'>", 
                SessionLengthMinutes*60, SessionExpireDestinationUrl)));
        }
    }
}
```

The important work is all done within the OnPreRender event handler, which adds the `<meta>` tag to the page using String.Format. One important thing to note about this approach is that it follows DRY ([Don't Repeat Yourself](https://deviq.com/principles/dont-repeat-yourself)) by keeping the actual session timeout period defined in only one place. If you were to hardcode your session timeouts in your META tags, and later the application's session timeout changed, you would need to update the META tags everywhere they were specified (and if you did not, you would not get a compiler error, just a site that did not work as expected). Setting the session timeout is easily done within web.config and completes this example. The relevant code is shown in Listing 5.

#### Listing 5 - Set Session Timeout in web.config

```xml
<system.web>
  <sessionState timeout="1" mode="InProc" />
</system.web>
```

## Considerations

One thing to keep in mind with this approach is that it will start counting from the moment the page is first sent to the browser. If the user interacts with that page without loading a new page, such as adding data or even working with the server through AJAX callbacks or UpdatePanels, the session expiration page redirect will still occur when the session would have timed out after the initial page load. In practice, this is not an issue for most pages since if a user is going to work with the page they will do so soon after it first loads, and if they do not use it for some time, they will return to find the Session Expired page and will re-authenticate.  However, if your site makes heavy use of AJAX (or Silverlight or any other client-centric technology), you may need to consider another (more complex) approach, such as using an AJAX Timer for this purpose.

## Download

Download the source for the above examples [here](http://aspalliance.com/download/SessionExpirePage.zip).

## Summary

Providing users with a clear indication that their session has expired within the browser, rather than waiting for them to hit the server, can greatly improve the user experience. This technique demonstrates a fairly simple and robust way to achieve this with a minimum of code and, more importantly, with minimal repetition of code. Adding this to an existing site that limits session length should take less than an hour, and your users will thank you.

Originally published on [ASPAlliance.com](http://aspalliance.com/1621_Implementing_a_Session_Timeout_Page_in_ASPNET)
