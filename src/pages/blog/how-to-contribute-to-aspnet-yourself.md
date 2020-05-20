---
templateKey: blog-post
title: How To Contribute to ASPNET Yourself
path: blog-post
date: 2013-02-19T21:36:00.000Z
description: "Recently I upgraded the Stir Trek conference site’s web code from
  ASP.NET MVC 2 to 4. When I did, I ran into an issue where the [OutputCache]
  attribute’s behavior changed for RenderAction code. "
featuredpost: false
featuredimage: /img/codeplex.png
tags:
  - asp.net
  - Caching
  - community
  - git
category:
  - Software Development
comments: true
share: true
---
Recently I upgraded the Stir Trek conference site’s web code from ASP.NET MVC 2 to 4. When I did, I ran into an issue where the \[OutputCache] attribute’s behavior changed for RenderAction code. Specifically, if you had code like this:

```
[OutputCache(CacheProfile="Default")]
public ActionResult SponsorList()
{
    var context = new DataContext();
    var sponsors = context.Sponsors.GetAll().Where(s => s.Type.Amount > 0).OrderByDescending(x => x.Type.Amount).ToList(); 
 
    return this.View(sponsors);
}
```

it would stop working. You would get an error message like this:

![](/img/server-error.png)

Now, this error will make no sense to you if, like me, it used to work just fine in MVC 2, and you check your configuration file to ensure that you have, in fact, set the duration to a non-zero value:

![](/img/caching.png)

Doing a bit of searching will turn up others who have encountered the issue, such as this Stackoverflow post:\
[http://stackoverflow.com/questions/4728958/caching-childactions-using-cache-profiles-wont-work](http://stackoverflow.com/questions/4728958/caching-childactions-using-cache-profiles-wont-work "http\://stackoverflow.com/questions/4728958/caching-childactions-using-cache-profiles-wont-work")

The bug in question here is that the error message is wrong. It should be this one:

![](/img/server-error-2.png)

The reason this doesn’t fire is that [the code that checks for this performs the checks in the wrong order](http://aspnetwebstack.codeplex.com/SourceControl/changeset/view/971b17d51e5f#src/System.Web.Mvc/OutputCacheAttribute.cs):

![](/img/validatechild.png)

So now, we’ve discovered the issue. We’ve fixed our code (replace CacheProfile usage with this: \[OutputCache(VaryByParam = “*”, Duration = 10)]). Now how can we make this fix available for others? Well, it turns out that the ASP.NET team accepts pull requests. What that means, if you’re not familiar, is that you can contribute back to the project. The instructions for doing so are quite good – I just performed these steps today for the first time myself.

![](/img/pull-request-stfu.png)

First, visit the [ASPNETWebStack project on Codeplex](http://aspnetwebstack.codeplex.com/). This is where all of the latest ASP.NET goodness is hosted. The source control is available in using git, and it’s pretty simple to grab the latest once you have Git installed (I recommend [Git for Windows](http://windows.github.com/)).

Next, if you’re looking for information on a particular feature request, issue, or bug, search for it in the [Issue Tracker](http://aspnetwebstack.codeplex.com/workitem/list/basic). In my case, the bug didn’t appear to exist previously, so I created [a new issue describing the issue with the OutputCacheAttribute](http://aspnetwebstack.codeplex.com/workitem/856). ( Since I actually did the fix before I created the bug, I referenced the pull request in the bug, but you don’t need to do that).

Now, assuming you are interested in and able to fix the bug, the next step is to create your own fork. You can do this from the [Source Code tab](http://aspnetwebstack.codeplex.com/SourceControl/changeset/view/971b17d51e5f). Click on the Fork link:

![](/img/asp-net.png)

Give the fork a name, and then clone it to your local machine. You can drag the folder with the resulting forked code into GitHub for Windows to start using GitHub for Windows to manage your commits, etc. Once you have the code, open it with Visual Studio. To run the tests, you will need to install [SkipStrongNames](http://aka.ms/skipsn) and run it with –e (at an elevated/administrator prompt):

![](/img/administrator-cmd.png)

If you don’t do this, you won’t be able to run the unit tests. Speaking of which, you’ll probably also need to install the Moq and Xunit packages via Package Manager Console, at least for System.Web.Mvc.Test:

![](/img/package-manager.png)

Once you have all of that, you should be able to successfully run tests (I’m using [JustCode’s test runner](http://www.telerik.com/products/justcode.aspx), which supports xunit along with the other usual testing frameworks):

![](/img/outputcache.png)

Once you have the bug fixed in your local build (with tests that prove it works – that’s how professional write code, you know), commit it (again, using git via command prompt or GitHub for windows) and then push/sync your changes back to your fork on CodePlex:

![](/img/codeplex.png)

Click on Send Pull Request to submit your pull request to the team, and you’re done! Well, almost. Be sure to review everything on the[Contributing section of the wiki](http://aspnetwebstack.codeplex.com/wikipage?title=Contributing), including this bit:

![](/img/cla.png)

You’ll need to send in this license agreement, but once that’s done, you’ll be free to contribute your own pull requests to the aspnetwebstack on CodePlex. Thanks a bunch to Eilon Lipton for his assistance with this issue! This was actually my first pull request, believe it or not (though I’d submitted SVN patches to other projects in the past), and the process was overall pretty painless. Hopefully this will help others feel more confident about submitting fixes themselves, perhaps in addition to just answering questions about the bug on Stackoverflow…