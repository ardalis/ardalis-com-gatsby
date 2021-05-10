---
templateKey: blog-post
title: Handling Errors with ASP.NET MVC
date: 2011-03-22
path: blog-post
description: Sometimes your ASP.NET MVC application is going to throw unhandled exceptions. Do you think your users want to see a Yellow Screen Of Death and a stack trace, or maybe something a bit friendlier? In this article, Steve describes a few simple techniques to set up error handling in ASP.NET MVC applications.
featuredpost: false
featuredimage: /img/handling-errors-mvc.png
tags:
  - ASP.NET MVC
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

Nobody likes to talk about it, but sometimes your web application is going to fail.  When it does, you want to make sure your users still get the best possible experience, and ideally that you as the developer get what you need to fix the problem.  In this article, you'll learn how to configure error handling in your ASP.NET MVC 3 applications.

## In the beginning...

When you first create your ASP.NET MVC 3 application, it won't include any error handling information at all, aside from a very simple shared view called Error.cshtml (assuming you're using the Razor view engine).  That page is static and simply tells the user, "Sorry, an error occurred while processing your request."  If you create a new controller action and throw an exception (see Listing 1), and then hit that controller action in your browser, you may be surprised to see that the error view is not rendered.

#### Listing 1 - Throwing an Exception in an Action

```csharp
public ActionResult CreateErrorOne()
{
    throw new Exception("No attributes.");
}
```

The result is a Yellow Screen of Death (YSOD).

## Adding HandleError Attribute

The way to tell your MVC controller to use the Error view for errors is to add the [HandleError attribute](https://docs.microsoft.com/en-us/dotnet/api/system.web.mvc.handleerrorattribute?redirectedfrom=MSDN&view=aspnet-mvc-5.2) to it.  HandleError is an ActionFilter that can be used to specify how the controller (or action) should respond to any unhandled exceptions that may occur.  You should also configure error handling in your configuration file by adding a `<customErrors />` section to your `<system.web />` section.  While testing, you can set the mode to "On" or "Off", and in production you'll likely want the mode to be "RemoteOnly".  Note that these are case-sensitive.

If you have customErrors mode set to Off, then HandleError won't actually do anything, and you'll continue to see the YSOD when errors occur in your application.  However, when you set customErrors mode to On, you'll start to see the correct behavior, which is a 500 error result and the custom error page (by default /Views/Shared/Error.cshtml but it will also search for other Views named Error in non-shared folder).

Listing 2 shows how to apply the HandleError attribute to two controller action methods.  When customerErrors is set to On, the first one will display the default Error.cshtml view and the second will display the MyErrorView.cshtml view.

#### Listing 2

```csharp
[HandleError]
public ActionResult CreateErrorTwo()
{
    throw new Exception("Using HandleError Attribute.");
}

[HandleError (View="MyErrorView")]
public ActionResult CreateErrorThree()
{
    throw new Exception("Using HandleError Attribute and MyErrorView.");
}
```

You can also specify different ways to handle errors based on the type of the exception by setting the ExceptionType parameter on HandleError.  The attribute also supports an Order parameter, which will control the order in which the attributes are fired (highest number first, apparently, despite what the docs say).  Listing 3 shows how you can stack multiple HandleError attributes on a single action (and note that you can also apply the attribute at the Controller/class level).

#### Listing 3

```csharp
[HandleError(View = "MyErrorView", ExceptionType = typeof(NotImplementedException), Order=2)]
[HandleError(View = "Error", Order=1)]
public ActionResult CreateErrorFour(int id)
{
    if(id < 0)
        throw new NotImplementedException("id < 0");
    throw new Exception("id >= 0");
}
```

## Passing Error Details to an ErrorViewResult

Although usually the attribute / ActionFilter approach is the way to go, you may find that you want to have more control over how errors are handled, or you want to be able to more easily test that an Exception occurred within your controller.  In this case, you may want to create a custom ViewResult for exceptions.  Listing 4 shows an ErrorViewResult class created for this purpose.

#### Listing 4

```csharp
public class ErrorViewResult : ViewResult
{
    public Exception Exception { get; private set; }

    public ErrorViewResult(Exception exception)
    {
        Exception = exception;
    }

    public override void ExecuteResult(ControllerContext context)
    {
        context.HttpContext.Response.StatusCode = 500;
        context.HttpContext.Response.TrySkipIisCustomErrors = true;
        if(context.HttpContext.IsCustomErrorEnabled)
        {
            base.ViewName = "Error";
            base.ExecuteResult(context);
            return;
        }
        string controllerName = (string)context.RouteData.Values["controller"];
        string actionName = (string)context.RouteData.Values["action"];
        HandleErrorInfo info = new HandleErrorInfo(Exception, controllerName, actionName);
        ViewData.Model = info;

        if (String.IsNullOrEmpty(base.ViewName))
        {
            base.ViewName = "ErrorDetails";
        }
        base.ExecuteResult(context);
    }
}
```

It expects an Exception in its constructor, and its `ExecuteResult() `method handles the rest of the work.  Note that it will respect the `<customErrors />` section and if this is turned on, it will default to simply rendering the Error view.  You can remove or reconfigure this bit of logic if you'd like for this to work regardless of how customErrors are configured.  Otherwise, it simply wraps up the Exception that was passed in along with the controller and action names into a System.Web.Mvc.HandleErrorInfo object, which it then passes to a strongly typed ErrorDetails view.  Listing 5 shows this View:

#### Listing 5 - ErrorDetails.cshtml

```html
<span style='background:yellow'>@model </span>System.Web.Mvc.HandleErrorInfo
<span style='background:yellow'>@{</span
    Layout = null>;
    
<span style='background:yellow'>}</span>
 
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h2>
        Sorry, an error occurred while processing your request.
    </h2>
    <b>Error: </b>
    <p>Controller: <span style='background: yellow'>@</span>Model.ControllerName</p>
    <p>Action: <span style='background:yellow'>@</span>Model.ActionName</p>
<p><span style='background:yellow'>@</span>Model.Exception.Message</p>
<p><span style='background:yellow'>@</span>Model.Exception.ToString()</p>
</body>
</html>
```

Setting up a call to the ErrorViewResult would typically occur in the `catch{}` block, as Listing 6 shows.

#### Listing 6 - Returning an ErrorViewResult from an Action

```csharp
public ActionResult CreateErrorWithErrorViewResult()
{
    try
    {
        throw new ApplicationException("Something bad happened.");
    }
    catch (Exception ex)
    {
        return new ErrorViewResult(ex);
    }
    return View();
}
```

Naturally you can extend the functionality of the ErrorViewResult as needed, for instance if you wanted to be able to pass in the name of the View to use when rendering exceptions.

If you need to log exceptions, probably the best way to do so today is with ELMAH.  You'll find some useful code showing [how to wire up ELMAH with ASP.NET MVC here](https://stackoverflow.com/questions/766610/how-to-get-elmah-to-work-with-asp-net-mvc-handleerror-attribute).  It shows how to subclass the HandleError attribute and hook into its OnException event to control what happens when an exception occurs.

## Summary

There are a number of ways to deal with unhandled exceptions in ASP.NET MVC.  By default, nothing is handled and users are shown ugly error stack traces.  With a bit of effort, and using some of the same configuration values that have always been available within ASP.NET, it is easy to set up much friendlier error pages.  If you need to be able to really customize the way errors are handled, you can override the HandleError attribute, or you can create a custom ViewResult that encapsulates the details of the exception and specifies how they should be displayed.

You can download the code for this article [here](http://stevesmithblog.s3.amazonaws.com/ASPNETMVC_ErrorHandling.zip).

Originally published on [ASPAlliance.com](http://aspalliance.com/2050_Handling_Errors_with_ASPNET_MVC)
