---
templateKey: blog-post
title: Enforcing Model Validation Policy in Web APIs
path: blog-post
date: 2017-11-09T20:43:00.000Z
description: If you’re exposing a Web API, one of the most basic things you
  should be doing on every request, and especially on those requests that mutate
  your system’s state, is ensuring that the data you’re accepting is valid.
featuredpost: false
featuredimage: /img/webdesign-3411373_1280.jpg
tags:
  - asp.net
  - asp.net core
  - mvc
  - web api
category:
  - Software Development
comments: true
share: true
---
If you’re exposing a Web API, one of the most basic things you should be doing on every request, and especially on those requests that mutate your system’s state, is ensuring that the data you’re accepting is valid. ASP.NET Core MVC (and Web API 2 and MVC 5, too!) supports [model validation](https://docs.microsoft.com/en-us/aspnet/core/mvc/models/validation) as part of the [model binding](https://docs.microsoft.com/en-us/aspnet/core/mvc/models/model-binding) process. You’re likely familiar with it and have seen it used in combination with data annotations like **\[Required]** on model types. (**Pro Tip**: You don’t need**\[Required]** on value types like int and DateTime – these are inherently required as long as their not marked as nullable via int? or DateTime?). Model validation occurs automatically, but it’s up to you to check its **IsValid** property and act accordingly. If you don’t, you risk working with an invalid model, which can result in bad data or even security vulnerabilities. Assuming you’re writing an API (not returning a View), the most appropriate response when you encounter bad model state is to return a BadRequest with details about why the data wasn’t valid. You can do so like this:

```
if (!ModelState.IsValid)
{
  return BadRequest(ModelState);
}
```

Unfortunately, this gets pretty verbose when you need to add it to literally every action method in every controller in your API. It violates the [DRY principle](http://deviq.com/don-t-repeat-yourself/). You should also strive to avoid conditional logic in your action methods, keeping them small and as simple as possible. In my [MSDN article on ASP.NET Core Filters](https://ardalis.com/real-world-aspnet-core-mvc-filters), I talk about how you can use filters to enforce policies in your Web API, making their behavior more consistent and less likely to have bugs. One simple way to do this is with the addition of a **ValidateModelAttribute** that can be used to perform this same policy action, but using a filter instead of code inside every action method. You’ll find the source for my implementation of this attribute in my [Filters sample on GitHub](https://github.com/ardalis/GettingStartedWithFilters).

If you don’t want to create and maintain your own filter, even one as simple as this one, you can instead just add the [Ardalis.ValidateModel nuget package](https://www.nuget.org/packages/Ardalis.ValidateModel). Once you’ve added it, you can apply it to your API controllers on a per-method or per-class basis. I recommend creating a BaseApiController class that includes the attribute, and having all of your API controllers inherit from this base class. For instance:

```
[Route("[controller]")]
[ValidateModel]
public abstract class BaseApiController : Controller
{
    // any other common behavior or properties
}
```

With this in place, you’ll ensure that model validation takes place automatically on every action method in your web API.

**Update**: With [ASP.NET Core 2.1 you can use the \[ApiController] attribute](https://www.strathweb.com/2018/02/exploring-the-apicontrollerattribute-and-its-features-for-asp-net-core-mvc-2-1/) to automatically enfoce model validation for your web API controllers.