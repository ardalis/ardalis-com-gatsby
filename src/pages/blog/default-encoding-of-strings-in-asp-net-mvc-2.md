---
templateKey: blog-post
title: Default Encoding of Strings in ASP.NET MVC 2
path: blog-post
date: 2010-06-23T14:35:00.000Z
description: "If you have ASP.NET MVC 1 code you are moving to ASP.NET MVC 2
  (and ASP.NET 4) you are likely to encounter a problem in which your
  application starts displaying encoded HTML on the page "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
If you have ASP.NET MVC 1 code you are moving to ASP.NET MVC 2 (and ASP.NET 4) you are likely to encounter a problem in which your application starts displaying encoded HTML on the page rather than the actual results of that HTML (e.g. you see <a href … /> instead of a hyperlink).

One of the greatest features added to ASP.NET 4 is a new way to render content that is encoded by default in your .aspx/.ascx pages/views. This new syntax uses <%: Model.SomeString %> instead of the ever-popular <%= Model.SomeString %> way of doing it. Note the third character is now a : not an =. It actually takes up a tiny bit less horizontal space – isn’t that nice of the ASP.NET team to be looking out for us that way (assuming you don’t use a fixed-width font for your programming/markup, which applies to some tiny percentage of you).

So go forth, and whenever you see <%= in your ASP.NET 4 apps, replace it with <%:, and life will be good. Your apps will be more secure. Cross site scripting attacks will decrease. Hackers will be sad.

But what about your existing code that used to look like this:

![](/img/login.png)

and now looks like this:

![](/img/login-2.png)

This happened when you went from this code:

```
<%= Html.LoginLink() %>
```

to this code:

```
<%: Html.LoginLink() %>
```

## MvcHtmlString

The solution to this is MvcHtmlString. It’s a new class that <%: is aware of and if you change your helper to return one of these, you’ll get back the behavior you expect. In effect, if you are returning one of these objects, you’re telling the renderer that you know what you’re doing and you’ll handle any encoding requirements and it should just display whatever you pass in.

This allows you not have to think about whether to use <%= vs. <%: in your views. You can (and should!) always use <%: in your views. I say again, you should always use <%: in your views.

So how to fix LoginLink()? Simply change its signature to return an MvcHtmlString, and create one when you are returning, like so. Here’s the original:

```
public static String LoginLink(this HtmlHelper helper)
{
     string currentControllerName = (string)helper.ViewContext.RouteData.Values["controller"];

     string currentActionName = (string)helper.ViewContext.RouteData.Values["action"];

     bool isAuthenticated = helper.ViewContext.HttpContext.Request.IsAuthenticated;

     var sb = new StringBuilder();

    if (isAuthenticated)
    {
        sb.Append("Logged in as <span>");
        sb.Append(helper.Encode(helper.ViewContext.HttpContext.User.Identity.Name));
        sb.Append("</span>");
    }
    sb.Append("<div id="loginlink"");
    if (currentControllerName.Equals("Account", StringComparison.CurrentCultureIgnoreCase) && (currentActionName.Equals("Login", StringComparison.CurrentCultureIgnoreCase) || currentActionName.Equals("Logout", StringComparison.CurrentCultureIgnoreCase)))
        sb.Append(" class="selected">");
    else
        sb.Append(">");

    if (isAuthenticated)
    {
        sb.Append(helper.ActionLink("Logout", "Logout", "Account"));
    }
    else
    {
        sb.Append(helper.ActionLink("Login", "Logon", "Account"));
    }
    sb.Append("</div>");

    return sb.ToString();
}
```

Now just change the return type to MvcHtmlString and call MvcHtmlString.Create(“your string”) when you are ready to return, like so:

```
public static String LoginLink(this HtmlHelper helper)
{
     string currentControllerName = (string)helper.ViewContext.RouteData.Values["controller"];

     string currentActionName = (string)helper.ViewContext.RouteData.Values["action"];

     bool isAuthenticated = helper.ViewContext.HttpContext.Request.IsAuthenticated;

     var sb = new StringBuilder();

    if (isAuthenticated)
    {
        sb.Append("Logged in as <span>");
        sb.Append(helper.Encode(helper.ViewContext.HttpContext.User.Identity.Name));
        sb.Append("</span>");
    }
    sb.Append("<div id="loginlink"");
    if (currentControllerName.Equals("Account", StringComparison.CurrentCultureIgnoreCase) && (currentActionName.Equals("Login", StringComparison.CurrentCultureIgnoreCase) || currentActionName.Equals("Logout", StringComparison.CurrentCultureIgnoreCase)))
        sb.Append(" class="selected">");
    else
        sb.Append(">");

    if (isAuthenticated)
    {
        sb.Append(helper.ActionLink("Logout", "Logout", "Account"));
    }
    else
    {
        sb.Append(helper.ActionLink("Login", "Logon", "Account"));
    }
    sb.Append("</div>");

    return MvcHtmlString.Create(sb.ToString());
}
```

Note above in the LoginLink method that we are calling helper.Encode(…) when displaying the user’s name. It’s possible that a malicious user could register with a name that includes some script tags, and depending on the registration validation or the membership API in place, it might get into our system through those means. If that user then left a comment or did something else that resulted in their username being displayed on the site, it could run some malicious script that might, among other things, redirect all of our site’s users to a malicious site that could try to exploit their machine. That would be bad.

**Always encode untrusted user inputs.**

## Summary

Encoding by default is a good thing. With ASP.NET 4 this is very easy to do if you just enforce the rules that <%= is no longer used, and is replaced everywhere with <%:. This may result in some breaking changes from existing code that is expecting to render plain strings that contain HTML in them. These can easily be fixed through the use of the MvcHtmlString class described above.