---
templateKey: blog-post
title: "An Active Local NuGet Server"
date: 2024-02-22
description: "As I'm writing this the Internet is out. When that happens, it makes it very difficult to work on development projects that have NuGet dependencies, especially when it comes to adding anything new to a project. A local NuGet server that kept up-to-date with my commonly used packages would be helpful right now."
path: blog-post
featuredpost: false
featuredimage: /img/active-local-nuget-server.png
tags:
  - NuGet
  - Offline
category:
  - Software Development
comments: true
share: true
---

As I'm writing this the Internet is out. When that happens, it makes it very difficult to work on development projects that have NuGet dependencies, especially when it comes to adding anything new to a project. A local NuGet server that kept up-to-date with my commonly used packages would be helpful right now.

NuGet already has a local NuGet cache. You'll find it in your user profile folder. Here's mine:

![local nuget cache folder screenshot](/img/local-nuget-cache.png)

But even with that, working offline is difficult. Here, I just launched powershell, and it took over 30 seconds just to come up, no doubt because of some check for updates or something it does upon launch, and then when it finally did come up, I tried installing my [Clean Architecture template](https://nuget.org/Ardalis.CleanArchitecture) as a test, something I've done many times on this machine, and that, too, took over 30 seconds to complete and resulted in an error (though it did produce the files):

![slow powershell and error with nuget template](slow-offline-powershell-broken-nuget-template.png)

"What's the big deal, you still got your template created..."

Ok, so let's build it. Remember this is something I've installed on this machine many times before in the recent past. That NuGet cache should, you would think, handle this offline scenario. But...

![Unable to load the service index for the source](/img/nuget-unable-to-load-service-index.png)

Since `dotnet restore` cannot resolve `api.nuget.org:443` the whole thing fails, rather than falling back to the cache or using a read through cache pattern (like I demonstrated in my Modular Monolith course that just dropped this week at Dometrain.com).

Clearly the passive .nuget folder cache is insufficient for offline development scenarios. Or I'm just using it wrong. Which is always possible. But I'm using it the way Visual Studio and the .NET SDK installed it, so if I'm using it wrong, the defaults are wrong, too.

## An Active Local NuGet Server

Here's what I think would solve this problem, and could help developers everywhere who work in a frequently disconnected manner.

I've written before about how easy it is to set up your own local NuGet server. But this, too, is not an ideal solution because it requires a lot of manual updating. What if instead of just using a folder, there were instead an actual service running locally that would have the following features:

1. Respond to requests for packages. This is its primary function.
1. Maintain a manifest of all packages that have been requested (in a data store or just by looking at its folder structure).
1. Periodically (1/day by default I think) go out to a source server (nuget.org by default but configurable to your IT department's feed, etc.) and pull down the latest version of each package in the manifest.

That's basically it.

Now, to make this work, you would just point your NuGet source at `nuget.local` (which would be mapped to localhost:xxx) and voila! You can (mostly) work offline as long as you don't need a truly novel package.

So, does this already exist? If not, who wants to build it?

I'd consider building it now, but I can't since my Internet is down!

### Update

Ok, some folks have let me know that this *does* exist already, in a few forms. The most popular/suggested one appears to be [BaGet](https://loic-sharma.github.io/BaGet/). I'll try to check it out and will probably post a follow up article or YouTube.

## Keep Up With Me

If you're looking for more content from me in your inbox [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
