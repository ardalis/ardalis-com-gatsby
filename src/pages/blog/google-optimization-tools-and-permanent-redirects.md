---
templateKey: blog-post
title: Google Optimization Tools and Permanent Redirects
path: blog-post
date: 2006-01-17T13:39:26.404Z
description: A recent forum thread on AspAdvice.com dealt with this issue. It’s
  far better to use 301 redirects than 302 redirects within your applications if
  the page in question is permanently at the new location.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Marketing
  - Search
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

A [recent forum thread on AspAdvice.com](http://ardalis.com/forums/14693/ShowPost.aspx) dealt with this issue. It’s far better to use 301 redirects than 302 redirects within your applications if the page in question is permanently at the new location. One example of this would be when handling site moves from an old architecture to a new architecture — you want to avoid tons of 404 errors and keep you search indexes, so you redirect users looking for the old URL to the new one. Works great, but if you use Response.Redirect, it’s sending a 302 (Found / Moved Temporarily) code, which is not what you want. Instead, you want to use a 301 Moved Permanently code, along with the new location.

Unfortunately, there is no built in way to do this with a single line of code in ASP.NET. I wrote one up a while back that looks like this — feel free to use it:

<!--EndFragment-->

```
public abstract class Utility
{
public static void Redirect301(string url)
{
Redirect301(url, true);
}
public static void Redirect301(string url, bool endResponse)
{
System.Web.HttpContext context = System.Web.HttpContext.Current;
if(context != null)
{
context.Response.Status = “301 Moved Permanently”;
context.Response.AddHeader(“Location”,url);
if(endResponse)
{
context.Response.End();
}
}
}
}
```

<!--StartFragment-->

A handy web-based tool to use to check whether your site is sending the proper response code is this [HTTP Header Response Test App](http://gsitecrawler.com/tools/Server-Status.aspx). Although it does have an annoying javascript bug. You should also read about [URL Canonicalization on Matt Cutt’s Blog](http://www.mattcutts.com/blog/seo-advice-url-canonicalization) and of course [Google’s Webmaster Guidelines](http://www.google.com/intl/en/webmasters/guidelines.html) – in particular this one: “Don’t create multiple pages, subdomains, or domains with substantially duplicate content.” Basically a lot of the 302 redirects out there confuse the search engines and result in multiple entries for the same content. For example, if “oldpage.aspx” sends a 302 redirect to “newpage.aspx” it’s quite possible that a search engine will place both URLs in their index with the same content for each. It’s also possible the 302 page will be indexed first, and thus at a higher priority. A 301 redirect would have resulted in the “oldpage.aspx” being dropped from the index, and instead the “newpage.aspx” being used. This in turn would boost the importance of “newpage.aspx” because it would be in the index more frequently (in essence it would get credit for all links to oldpage.aspx in addition to any links to newpage.aspx).

Another important consideration here is the use of “www.” in URLs. A lot of people still type in “www.” as a force of habit. However, these four characters are largely obsolete today. With very few exceptions, websites today do not require any “www.” prefix, and most sites advertise without them (notice on TV that commercials end with nfl.com or aol.com, or moviename.com, not www DOT anything). Having a site that works equally well with and without WWW as a subdomain (or perhaps with anything as a subdomain — it’s not difficult to map \[anything].domain.com to one web server) is pretty much standard today, but it can present a problem with URL Canonicalization. If both [www.aspalliance.com](http://www.aspalliance.com/) and aspalliance.com refer to the same content, it can result in duplicate entries in the search engine’s index. The solution is to use 301 redirects from one address to the other. Personally I prefer the shorter URL to the archaic www URL, so I would create a 301 redirect from [www.aspalliance.com](http://www.aspalliance.com/) to aspalliance.com. This can easily be done in ASP.NET in the BeginRequest method, or through some third party tools such as [ISAPIRewrite](http://www.isapirewrite.com/).

<!--EndFragment-->