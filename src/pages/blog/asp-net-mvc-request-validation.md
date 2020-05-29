---
templateKey: blog-post
title: ASP.NET MVC Request Validation
path: blog-post
date: 2009-02-11T00:25:00.000Z
description: When using ASP.NET MVC to post data that might contain HTML or
  other potentially “dangerous” data, the default behavior as of the Release
  Candidate is to throw an exception, preventing the posting of the data.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET MVC
category:
  - Uncategorized
comments: true
share: true
---
When using ASP.NET MVC to post data that might contain HTML or other potentially “dangerous” data, the default behavior as of the Release Candidate is to throw an exception, preventing the posting of the data. This is a well-known feature of ASP.NET that was introduced several versions ago, and the typical way to avoid it (when necessary for the application’s function) is to add validate Request=”false” either to the @Page attribute or to the `<pages />` section in web.config. Notably, this doesn’t actually work with ASP.NET MVC RC (and v1.0 I presume).

The reason for this is because of the way ASP.NET MVC processes requests. In traditional web forms, the page itself is responsible for handling the request, but in MVC the controller has this responsibility. The ASPX page in MVC is simply the view, and in fact a particular request might not even render a view, completely bypassing the Request Validation features of the Page.

Instead, request validation has been moved to the controller, which is where any logic for writing possibly dangerous data to the database would reside. If it is necessary to bypass Request Validation in an ASP.NET MVC application, then the way to achieve it is with an attribute on the controller or action involved.

In my case, I was working with [Steve Marx’s blog sample described in my last post](/azure-table-storage-gotcha), and I was trying to add a post with an `<img />` tag in it to test out one of the features of the blog. Unfortunately, I initially got a request validation exception when I tried to post the content, and after adding `validateRequest="false"` to the `<pages />` section in web.config, the error persisted. A little bit of research revealed the need to update the controller associated with the post (not the one used to render the Add view) with the `ValidateInput(false)` attribute, like so:

```csharp
[ValidateInput(false)]
public ActionResult Create([Bind(Prefix="")] Models.BlogEntry entry)
{
  // code
}
```
