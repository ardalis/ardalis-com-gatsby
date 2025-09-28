---
title: Remove ASP.NET Page Output Cache Entries
date: "2005-05-02T00:00:00.0000000"
description: This article discusses two techniques for programmatically invalidating the cache of ASP.NET pages that use Output Caching, allowing control over cache expiration from code.
featuredImage: /img/remove-output-cache.png
---

[Sample Code](http://aspalliance.com/download/668/caching.zip)

## Programmatic Output Cache Entry Removal

### Introduction

A frequently asked question I get when I present or write about ASP.NET's caching features is, "How do I programmatically remove a page from the output cache?" For a long time now I've been unsure of the answer to this. I finally broke down and learned that yes, you can do this, and discovered two methods for implementing the solution. Download this article's sample code and you'll quickly see how each method works -- the code required is minimal.

### Remove One Page from the Cache

The first technique is simply to specify a particular page and have its output cache entry removed. This is accomplished using the `HttpResponse.RemoveOutputCacheItem(string path)` method. The path expected is an"absolute virtual path" which means it must be of the form"/foldername/pagename.aspx". From the sample code, you could create a button that, when pressed, removes the cache entry for a particular page. The code in Listing 1 shows how this would be implemented.

#### Listing 1: Remove Output Cache for One Page

```csharp
private void RemoveButton_Click(object sender, System.EventArgs e)
{
 HttpResponse.RemoveOutputCacheItem("/caching/CacheForever.aspx");
}
```

This works provided that there is a page named CacheForever.aspx in the folder /caching. On that page, you would implement output caching by using the <%@ OutputCache %> directive as usual -- nothing special needs to be done to the cached page for this technique to work.

### Remove Many Pages from the Cache

Another technique involves linking many pages together through the use of a key-based cache dependency. This technique requires a little bit more code, but is still very simple to implement. The simple implementation provided with the sample code download took three lines of code. The most important one is added to the page (every page) that is output cached. Listing 2 shows how the cache dependency is added to the page in its Page_Load event handler.

#### Listing 2: Add Key Dependency to Page

```csharp
private void Page_Load(object sender, System.EventArgs e)
{
 Response.AddCacheItemDependency("Pages");
}
```

At this point, the page depends on the cache key"Pages". In a real application, you would want this string value to be read from a configuration file, since it will be used in several places and it's a bad practice to use a string literal in more than one place if at all avoidable. If you test out your page after adding this, and before you do anything else, you'll find that it has disabled your output caching. The reason for this is that a cache key dependency automatically fails if the key does not exist in the cache. At this point, we haven't done anything to insert an item into the cache with a key of"Pages". That's the next step. Listing 3 shows how to add such a key in Application_Start so that we can be sure it is always present.

#### Listing 3: Configure Global.asax to Create Key

```csharp
protected void Application_Start(Object sender, EventArgs e)
{
 HttpContext.Current.Cache.Insert("Pages", DateTime.Now, null, System.DateTime.MaxValue, System.TimeSpan.Zero, System.Web.Caching.CacheItemPriority.NotRemovable, null);
}
```

Finally, to refresh all pages that depend on this key, we simply need to do this exact same thing inside another page or control. For instance, you might create a button called"Expire Page Cache" in your website's admin menu. Listing 4 shows what that button's click event handler would look like.

#### Listing 4: Button Click Handler to Expire Output Cache Pages

```csharp
private void RemoveKeyButton_Click(object sender, System.EventArgs e)
{
 HttpContext.Current.Cache.Insert("Pages", DateTime.Now, null, System.DateTime.MaxValue, System.TimeSpan.Zero, System.Web.Caching.CacheItemPriority.NotRemovable, null);
}
```

### Summary

I'd like to thank Scott Mitchell for his [blog entry](http://scottonwriting.net/sowblog/posts/3513.aspx) that I found when I [Googled](http://www.google.com/search?sourceid=navclient&ie=UTF-8&rls=GGLD,GGLD:2005-04,GGLD:en&q=asp%2Enet+output+cache+remove) for this. He led me to find the first method. I'd also like to thank [G. Andrew Duthie](http://blogs.msdn.com/gduthie/), who suggested the second method in a private mailing list.

### Resources

- [MSDN: Caching Page Output with Cache Key Dependencies](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpguide/html/cpconcachingpageoutputwithcachekeydependencies.asp)
- [Discuss ASP.NET Performance](http://aspadvice.com/SignUp/list.aspx?l=136&c=17)
- [ASP.NET Caching Forum](http://beta.aspalliance.com/groups/Read.aspx?server=forums.asp.net&group=asp.net_discussions.caching&s=2)
- [Caching Newsgroup](http://beta.aspalliance.com/groups/Read.aspx?server=msnews.microsoft.com&group=microsoft.public.dotnet.framework.aspnet.caching&s=1)
- [Performance Newsgroup](http://beta.aspalliance.com/groups/Read.aspx?server=msnews.microsoft.com&group=microsoft.public.dotnet.framework.performance&s=1)

Originally published on [ASPAlliance.com](http://aspalliance.com/668_Remove_ASPNET_Page_Output_Cache_Entries)

