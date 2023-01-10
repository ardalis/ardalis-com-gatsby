---
templateKey: blog-post
title: Monitor Sites with Uptime Robot or Your Own Process
date: 2023-01-10
description: If you have your own web sites or apps that you maintain, it's helpful to know when they're not working. One tool I've been using for a long time is a site called Uptime Robot. Of course, with just a little bit of code you can easily write your own small application that can periodically check the status of one or more sites and alert you to a problem.
path: blog-post
featuredpost: false
featuredimage: /img/monitor-sites-with-uptime-robot-or-your-own-process.png
tags:
  - dotnet
  - monitoring
  - health checks
category:
  - Software Development
comments: true
share: true
---

If you have your own web sites or apps that you maintain, it's helpful to know when they're not working. One tool I've been using for a long time is a site called Uptime Robot. Of course, with just a little bit of code you can easily write your own small application that can periodically check the status of one or more sites and alert you to a problem.

## The Problem

I run a number of sites, including [this site](https://ardalis.com), [DevIQ](https://deviq.com), [DevBetter](https://devBetter.com), and [NimblePros](https://nimblepros.com). These are hosted in various locations and run on a variety of web stacks. Some are .NET applications, some are static websites, and some are managed by third party CMS tools. While there are built-in ways of performing health checks in ASP.NET Core, I really wanted a solution that required less code and worked for an arbitrary number of sites, and would simply notify me when the site was unavailable, and again when it came back online. My current favorite solution for this is [UptimeRobot](https://uptimerobot.com/).

## UptimeRobot

I've been using [UptimeRobot](https://uptimerobot.com/) for a long time - probably around 10 years or so. The service is free for up to 50 monitors assuming you're OK with a 5 minute interval between checks. That's more than enough for my needs. They also offer paid plans which include more monitors, SSL features, team dashboards, and more. I have no business relationship with them; I'm just a happy user.

Getting started is pretty simple. You create an account and then set up your first monitor.

![UptimeRobot create monitor](/img/uptime-robot-create-monitor-1.png)

Since I'm mostly using this to check websites, I use the keyword option. I don't just want to know the server responded with some success code, I want to know that the actual content of the page came back. Or at least some known good part of it.

Each monitor can also notify one or more team members by email when it's down or comes back up.

![UptimeRobot create keyword monitor](/img/uptime-robot-create-monitor-2.png)

Assuming you chose a keyword monitor, you'll get an expanded form with additional options. You need to provide a nickname for the monitor, a URL to check, a string to check for, and adjust the interval. The interval needs to be at least 5 minutes for the free plan.

After saving the monitor, it should show up in your list on your dashboard. Within a few minutes, you should see the status of the monitor.

![UptimeRobot main dashboard](/img/uptime-robot-dashboard-1.png)

If you want to put the status of your team's sites up on a TV screen somewhere, there's built-in support for "TV Mode" even on the free plan:

![UptimeRobot tv mode dashboard](/img/uptime-robot-dashboard-2.png)

So that's it! For the low price of FREE you can monitor up to 50 websites and get an email notification within 5 minutes of any outage (and, when the outage ends, another email saying it's back up). Hope you find this useful!

But what if you just **really** want to write some code for this? Read on!

## Writing a Web Monitor Service in .NET Core

If you just want to check whether a particular site is up, you can use the `HttpClient` class to make a request, and then just check that you received a success status code. If you want to emulate the other features UptimeRobot gives you for free above, you'd also want to repeat the check periodically, send notifications when status changes, and store results for each check (as well as check for keyword strings if you're going to support that).

As it turns out, my solution template for creating a .NET Worker Service using Clean Architecture already has most of these features baked in, just as its placeholder functionality (that you would normally rip out and replace with your actual logic). So, all you need to do to get 90% of the way there is grab my template from [github.com/ardalis/CleanArchitecture.WorkerService](https://github.com/ardalis/CleanArchitecture.WorkerService) and make a few minor changes to it. If you don't want to bother cloning the code locally, you can just hit '.' while in the browser to open up [GitHub's web editor (or click here)](https://github.dev/ardalis/CleanArchitecture.WorkerService), which provides a pretty nice in browser viewing experience.

The Worker service in Worker.cs is configured in Program.cs in the CleanArchitecture.Worker project. The Worker class is pretty minimal and just loops continuously, calling the entry point service from the Core project (in order to minimize logic in the Worker project). You don't need to change this code at all, as long as you remember that any delay interval will need to be specified in the entry point service.

The entrypoint service is shown below:

![WorkerService's EntryPointService](/img/workerservice-entrypointservice.png)

Currently it runs in a very tight loop looking for messages in a configured message queue. For a web site monitor you'd want to remove the queue stuff and instead just sleep or delay for X minutes between checks.

Checking each URL just uses some simple code like this, which returns a status history object with the results of the check:

```csharp
/// <summary>
/// A simple service that fetches a URL and returns a UrlStatusHistory instance with the result
/// </summary>
public class UrlStatusChecker : IUrlStatusChecker
{
  private readonly IHttpService _httpService;

  public UrlStatusChecker(IHttpService httpService)
  {
    _httpService = httpService;
  }

  public async Task<UrlStatusHistory> CheckUrlAsync(string url, string requestId)
  {
    Guard.Against.NullOrWhiteSpace(url, nameof(url));

    var statusCode = await _httpService.GetUrlResponseStatusCodeAsync(url);

    return new UrlStatusHistory
    {
      RequestId = requestId,
      StatusCode = statusCode,
      Uri = url
    };
  }
}
```

The actual work of checking a URL is pretty trivial:

```csharp
/// <summary>
/// An implementation of IHttpService using HttpClient
/// </summary>
public class HttpService : IHttpService
{
  public async Task<int> GetUrlResponseStatusCodeAsync(string url)
  {
    using (var client = new HttpClient())
    {
      var result = await client.GetAsync(url);

      return (int)result.StatusCode;
    }
  }
}
```
