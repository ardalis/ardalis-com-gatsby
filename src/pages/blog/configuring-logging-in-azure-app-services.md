---
templateKey: blog-post
title: Configuring Logging in Azure App Services
date: 2020-04-19
path: /configuring-logging-in-azure-app-services
featuredpost: false
featuredimage: /img/configuring-logging-in-azure-app-service.png
tags:
  - asp.net
  - asp.net core
  - cloud
  - logging
category:
  - Software Development
comments: true
share: true
---

Azure App Services are a very easy and economical way to quickly deploy your ASP.NET/ASP.NET Core apps to the cloud. You can get started for free if you just want to try out something you're developing (without uptime considerations) and entry-level plans are pretty affordable:

![](/img/image-3-1536x528.png)

The [docs for publishing to an Azure App Service](https://docs.microsoft.com/en-us/aspnet/core/tutorials/publish-to-azure-webapp-using-vs?view=aspnetcore-3.1) are pretty good so I won't get into that here. I recommend configuring this through a CI build using GitHub Actions or Azure DevOps, rather than going through Visual Studio. You can see how I've configured my [devBetter.com private career coaching](https://devbetter.com/) program [using GitHub Actions here](https://github.com/ardalis/DevBetterWeb/actions?query=workflow%3Apublish).

Ok, so now you're publishing to an Azure App Service. But something's not working quite right. How do you troubleshoot it? There are a variety of options. You can [remote debug](https://devblogs.microsoft.com/premier-developer/remote-debugging-azure-app-services/), but not at the lower-end shared hosting tiers shown above.

You can configure logging, which is built-in with ASP.NET Core and should be pretty straightforward (but there is one thing you need to know to get it to work). I'll talk more about this in a sec.

You can send an email, SMS, or other message (for instance, post a message to Discord using web hooks). I actually wrote about [integrating ASP.NET Core apps with Discord](https://ardalis.com/add-discord-notifications-to-asp-net-core-apps) and the initial reason for it was so that I could better see what was happening in my application at runtime in production. It's a valid option for a small site with little traffic (or for infrequent events). Another similar approach might be to [use Application Insights to record when certain things occur](https://docs.microsoft.com/en-us/azure/azure-monitor/app/api-custom-events-metrics).

## Configuring Logging to work with Azure App Service

If you're like me, you might have thought that the built-in console logger in ASP.NET Core would work fine when deployed to an Azure App Service, because it would just run the Kestrel web server and dump the output to the Azure Log Viewer. You (like me) would be mistaken for a couple of reasons.

First, Azure App Services don't run Kestrel directly by default - they actually run IIS. This actually bit me for a different reason because I had a setting in my web.config that was overriding my Azure environment variables and making the site run in Development, not Production mode. I may write that up separately but for now just bear in mind your app is running under IIS.

And two, probably related to this, you can't just rely on an existing logger to integrate with Azure's log viewer. You actually need to install a separate NuGet package and configure it in your application's Program.cs.

## Install and Configure Azure Logging Package

The package you need is [Microsoft.Extensions.Logging.AzureAppServices](https://www.nuget.org/packages/Microsoft.Extensions.Logging.AzureAppServices). Add it to your web project.

Now open your Program.cs and configure the logger as follows, adding any other loggers you might want beyond Console and AzureWebAppDiagnostics.

```csharp
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder
                    .UseStartup<Startup>()
                    .ConfigureLogging(logging =>
                    {
                        logging.ClearProviders();
                        logging.AddConsole();
                        logging.AddAzureWebAppDiagnostics();
                    });
                });
```

## View Live Logs in Azure App Service

Once you have this configured, deploy your app to Azure App Service and you should be able to configure the log viewer to work. First, scroll down and click on 'App Service logs' and you should see something like this:

![](/img/image-4-927x1024.png)

Configure Logging in Azure App Service

Next, on the right, toggle Application Logging (Filesystem) to enable it. This setting lasts for 12 hours and then automatically resets, to avoid filling your app's hard drive. If you want more persistent logging, configure a Blob storage account to hold the logs.

When you enable logs, you'll be able to set how verbose of messages you want to capture. If this is your first test, I recommend using Information so you'll see all traffic to your site. Later, you might want to only look at Warnings or Errors. Be sure to Save your selection.

![](/img/image-5-configure.png)

Choose Log Level.

Now click on Log stream on the left to attach to your application's logs. Navigate to your site and you should see log messages corresponding to the requests you're making to the application.

![](/img/image-6-1536x699.png)

View your Azure App Service live log stream.

And that's it. If everything worked you should see live log output for your Azure App Service hosting your ASP.NET Core application. The thing that I tend to forget, and which this post is meant to remind me of, is the need for the [AzureAppServices logging extension nuget package](https://www.nuget.org/packages/Microsoft.Extensions.Logging.AzureAppServices/). Remember that, and everything else should just work.

_P.S. If you'd like to be able to ask for advice on your career or technical questions from me as well as a curated list of fellow developers, take a look at [devBetter.com](https://devbetter.com/)._
