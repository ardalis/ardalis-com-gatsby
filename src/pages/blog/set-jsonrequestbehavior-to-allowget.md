---
templateKey: blog-post
title: Set JsonRequestBehavior to AllowGet
path: blog-post
date: 2011-09-23T12:13:00.000Z
description: "If you’re working with ASP.NET MVC and JsonResult, you may
  encounter this error: This request has been blocked because sensitive
  information could be disclosed to third-party web sites when this is used in a
  GET request. To allow GET requests, set JsonRequestBehavior to AllowGet."
featuredpost: false
featuredimage: /img/error-261887_1280.jpg
tags:
  - error
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

If you’re working with ASP.NET MVC and JsonResult, you may encounter this error:

> #### *This request has been blocked because sensitive information could be disclosed to third party web sites when this is used in a GET request. To allow GET requests, set JsonRequestBehavior to AllowGet.*
>
> **Description:**An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.\
> **Exception Details:**System.InvalidOperationException: This request has been blocked because sensitive information could be disclosed to third party web sites when this is used in a GET request. To allow GET requests, set JsonRequestBehavior to AllowGet.\
> **Source Error:**
>
> `An unhandled exception was generated during the execution of the current web request. Information regarding the origin and location of the exception can be identified using the exception stack trace below.`
>
> **Stack Trace:**

<!--EndFragment-->

```
 [InvalidOperationException: This request has been blocked because sensitive information could be disclosed to third party web sites when this is used in a GET request. To allow GET requests, set JsonRequestBehavior to AllowGet.]
 System.Web.Mvc.JsonResult.ExecuteResult(ControllerContext context) +325809
 System.Web.Mvc.ControllerActionInvoker.InvokeActionResult(ControllerContext controllerContext, ActionResult actionResult) +13
 System.Web.Mvc.<>c__DisplayClass1c.<InvokeActionResultWithFilters>b__19() +23
 System.Web.Mvc.ControllerActionInvoker.InvokeActionResultFilter(IResultFilter filter, ResultExecutingContext preContext, Func`1 continuation) +260
 System.Web.Mvc.<>c__DisplayClass1e.<InvokeActionResultWithFilters>b__1b() +19
System.Web.Mvc.ControllerActionInvoker.InvokeActionResultWithFilters(ControllerContext controllerContext, IList`1 filters, ActionResult actionResult) +177
System.Web.Mvc.ControllerActionInvoker.InvokeAction(ControllerContext controllerContext, String actionName) +343
System.Web.Mvc.Controller.ExecuteCore() +116
```

<!--StartFragment-->

As error messages go, it’s pretty nice that it tells you what you need to do to fix the problem. Unfortunately, it doesn’t tell you how or where to set JsonRequestBehavior to AllowGet. A quick search turned up [this post](http://stackoverflow.com/questions/1663221/asp-net-mvc-2-0-jsonrequestbehavior-global-setting), which shows the syntax you need. When you’re in a controller action that returns a JsonResult, you typically just return Json(foo) to use the default serializer. If you want to AllowGet for this action, simply pass in a second parameter with JsonRequestBehavior.AllowGet, like so:

<!--EndFragment-->

```
{
  // get the data
  return Json(theData, JsonRequestBehavior.AllowGet);
}
```

<!--StartFragment-->

If you never want to block GET requests, first [be sure you know why they’re being blocked, for security reasons](http://haacked.com/archive/2009/06/25/json-hijacking.aspx). Then, you can simply override the Json() method in a BaseController class that inherits from Controller, and then have you controllers inherit from your BaseController. The override would look something like this (also from [this post](http://stackoverflow.com/questions/1663221/asp-net-mvc-2-0-jsonrequestbehavior-global-setting)):

<!--EndFragment-->

```
protected override JsonResult Json(object data,
    string contentType,
    System.Text.Encoding contentEncoding)
{
    return Json(data, contentType, JsonRequestBehavior.AllowGet);
}
```