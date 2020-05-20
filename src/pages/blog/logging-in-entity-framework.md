---
templateKey: blog-post
title: Logging in Entity Framework
path: blog-post
date: 2014-08-15T14:48:00.000Z
description: When working with any ORM tool, it can sometimes be helpful to see
  just what, exactly, is being sent to the underlying data store.
featuredpost: false
featuredimage: /img/debugview_ef.png
tags:
  - ef6
  - entity framework
  - logging
category:
  - Software Development
comments: true
share: true
---
When working with any ORM tool, it can sometimes be helpful to see just what, exactly, is being sent to the underlying data store. This can help identify bugs as well as performance issues in how the query is being performed (or how many queries are being performed, in the case of [SELECT N+1 problems](http://www.codeproject.com/Articles/102647/Select-N-Problem-How-to-Decrease-Your-ORM-Perfor)). There are several existing tools available that provide assistance with this:

* [SQL Server Profiler](http://msdn.microsoft.com/en-us/library/ms181091.aspx)
* [EFProf](http://www.hibernatingrhinos.com/products/efprof) (third-party commercial tool)
* [IntelliTrace](http://peterkellner.net/2013/05/05/using-intellitrace-with-entity-framework-in-visual-studio-2012/)
* [Glimpse](https://www.nuget.org/packages/Glimpse.EF6)

Sometimes, though, you want to be able to log what EF is doing to a standard logger, whether using the built-in System.Diagnostics calls, or a logging tool like [log4net](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CB8QFjAA&url=http%3A%2F%2Flogging.apache.org%2Flog4net%2F&ei=im_uU5_LH4mAygSdm4K4BA&usg=AFQjCNEdDcVKM8X4j-ILZQt9pLW1G13vdA&bvm=bv.73231344,d.aWw) or [NLog](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CB0QFjAA&url=http%3A%2F%2Fnlog-project.org%2F&ei=lW_uU8STE4mNyATZvoCAAw&usg=AFQjCNFFFNdj1vDQrQYPlAJjYoqJ8zuxeg&bvm=bv.73231344,d.aWw). In this case, there’s a very simple way to achieve this. Entity Framework exposes a Log property, that accepts any Action<string> type. What this means is you can specify a simple lambda expression that takes in a string and doesn’t return anything, and that expression will be executed whenever EF performs a database operation. You can specify this in the DbContext constructor if you want every operation to be logged during the lifetime of the DbContext, like in this example:

```
public MovieDbContext()
{
    Database.Log = s => Debug.Print(s);
}
```

In this[example](https://github.com/ardalis/MvcMovieEFLogAndCache), I’ve added logging to the MvcMovie sample application associated with this[MVC 5 tutorial](http://www.asp.net/mvc/tutorials/mvc-5/introduction/getting-started). With this in place, using a tool like[DebugView from SysInternals](http://technet.microsoft.com/en-us/sysinternals/bb842059.aspx)(or the Debug output window in Visual Studio, but DebugView is nice to have for viewing on production machines) will show:

![](/img/debugview_ef.png)

Now, in this case, you’ll see that refreshing the app again and again will result in these same two queries being executed. That’s because the sample is just a starting point, not something you want to actually use in a real application.

Shameless Plugs Follow…

If you want to see how to go from such an application to something that you can easily maintain and that performs and scales effectively, I recommend you check out [my N-Tier Architecture and Domain-Driven Design courses on Pluralsight](http://pluralsight.com/training/Authors/Details?handle=steve-smith). At a minimum, you should remember that [New is Glue](http://ardalis.com/new-is-glue) and avoid things like this in your controllers:

```
namespace MvcMovie.Controllers
{
    public class MoviesController : Controller
    {
        private MovieDbContext db = new MovieDbContext();
 
// omitted
```

This kind of code tightly couples your controller to your data access implementation, and in fact to your database itself, making it extremely difficult to test the controller. It’s also the wrong level of abstraction to have in your UI layer, and thus results in a lot more duplicate code in the UI layer that should belong somewhere else. In my workshops with clients, we start out with code like this and write tests for it, requiring a test database and a lot of extra effort (see for example [Integration Testing Entity Framework with Migrations](http://blog.falafel.com/integration-testing-entity-framework-migrations/)). Then, we [refactor](http://pluralsight.com/training/Courses/TableOfContents/refactoring-fundamentals) the code and introduce [Domain-Driven Design style architecture](http://pluralsight.com/training/courses/TableOfContents?courseName=domain-driven-design-fundamentals), resulting in a much more modular and maintainable application that is easier to extend as well as test.

If you or your team are unsure of how to get your existing or new application into a state where it can more easily be maintained, extended, and tested, [contact me](http://ardalis.com/contact) and I may be available to help.