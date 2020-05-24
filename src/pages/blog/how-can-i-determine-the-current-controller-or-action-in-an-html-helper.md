---
templateKey: blog-post
title: How Can I Determine The Current Controller or Action in an Html Helper
path: blog-post
date: 2010-07-02T00:47:00.000Z
description: If you’re writing an HTML Helper for ASP.NET MVC you may want to do
  something different based on whether the page that is to be rendered was
  arrived at via a particular controller or controller action.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - asp.net mvc
  - html helpers
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

If you’re writing an HTML Helper for ASP.NET MVC you may want to do something different based on whether the page that is to be rendered was arrived at via a particular controller or controller action. I found the following code which does just this in one of the ASP.NET MVC Themes available from the [www.asp.net](http://www.asp.net/) web site (the Dark theme, I believe it’s called).

Note that I’ve already modified this code to [work with the new ASP.NET 4 string encoding and the MvcHtmlString type](http://stevesmithblog.com/blog/default-encoding-of-strings-in-asp-net-mvc-2), as I wrote about previously.

<!--EndFragment-->

```html
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> MvcHtmlString LoginLink(<span style="color: #0000ff">this</span> HtmlHelper helper)




1
{




1
    <span style="color: #0000ff">string</span> currentControllerName = 




1
      (<span style="color: #0000ff">string</span>)helper.ViewContext.RouteData.Values[<span style="color: #006080">&quot;controller&quot;</span>];




1
&#160;




1
    <span style="color: #0000ff">string</span> currentActionName = 




1
      (<span style="color: #0000ff">string</span>)helper.ViewContext.RouteData.Values[<span style="color: #006080">&quot;action&quot;</span>];




1
&#160;




1
    <span style="color: #0000ff">bool</span> isAuthenticated = 




1
      helper.ViewContext.HttpContext.Request.IsAuthenticated;




1
    




1
    <span style="color: #008000">// more stuff here</span>










1
}
```

<!--StartFragment-->

As you can see, the HtmlHelper has a ViewContext property, which allows you to access RouteData and ultimately from there determine the controller and/or action that was used for this request. Incidentally, you can also use the ViewContext to get to HttpContext and determine whether the request is authenticated as well.

And that’s it!

*You can[follow me on twitter here](http://twitter.com/ardalis) or [subscribe to my blog here](http://feeds.feedburner.com/StevenSmith).*

<!--EndFragment-->