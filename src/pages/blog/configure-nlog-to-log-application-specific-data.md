---
templateKey: blog-post
title: Configure NLog to Log Application-Specific Data
path: blog-post
date: 2016-02-24T13:04:00.000Z
description: NLog is one of my favorite .NET loggers. It has a bunch of great
  features, is easy to configure via a config file or programmatically, and is
  very extensible. Recently I had a customer who wanted to improve the logging
  in their web-based application.
featuredpost: false
featuredimage: /img/custom-logger.jpg
tags:
  - .net
  - asp.net
  - logging
  - nlog
category:
  - Software Development
comments: true
share: true
---
[NLog](http://nlog-project.org/) is one of my favorite .NET loggers. It has a bunch of great features, is easy to configure via a config file or programmatically, and is very extensible. Recently I had a customer who wanted to improve the logging in their web-based application. They wanted to log to a database, since that was what they had been doing successfully, and they wanted to be able to easily store the associated customer with the log data. But they didn’t want to have to add it to every message, or rewrite the logging interface to accept a customer id parameter. What’s more, the customer id wasn’t stored in any central location for a given thread or web request, so in this case we couldn’t take advantage of [NLog’s support for grabbing fields from ASP.NET containers](https://github.com/NLog/NLog.Web) (session, cookie, HttpContext, etc.). We were able to get what we needed working quickly, using the steps shown below.

## Create a Custom Logger

Since we didn’t want to have to pass the customer id with every log message, and we couldn’t store it somewhere centrally where NLog could access it, we opted to subclass Logger and add the value to the MappedDiagnosticsContext, which exists for this purpose:

`public class CustomLogger : Logger {
    public void SetCustomerId(int CustomerId)
    {
        // https://github.com/nlog/NLog/wiki/Mdc-Layout-Renderer
        MappedDiagnosticsContext.Set("CustomerId", CustomerId);
    }
}`

## Use the Custom Logger in the Application

Next, we needed to access the custom logger anywhere in the application where we would be performing logging. We wanted to keep NLog’s default convention of using a named logger per class, which would allow us to easily query the log output for information related to a particular class. Below is a sample class showing how to get the logger, set its customer ID (used by all subsequent log methods), and log a message:

```
public class Greeting
{
    private readonly CustomLogger _logger = (CustomLogger)LogManager.GetCurrentClassLogger(typeof(CustomLogger));
 
    public Greeting()
    {
            _logger.SetCustomerId(123);
    }
 
    public string SayHello(string name)
    {
        _logger.Info("{0} started.", nameof(SayHello));
        return $"Hello {name}!";
    }
}
```

## Configuring NLog in Code

NLog supports both config-file based configuration as well as code-based configuration. You can use whichever you prefer. In this case, I opted for code-based, since it provides a little greater transparency and error-catching than XML does, in my experience. The NLog docs don’t show an example of API-based configuration of a database target, so here is what that looks like if you need it. Note that the custom field we’re capturing, customerId, is mapped in targets using the ${mdc:item=KEY} syntax. You can see this used in both the consoleTarget and the databaseTarget shown below:

```
private static void ConfigureLogging()
{
    var logConfig = new LoggingConfiguration();
 
    // add targets
    var consoleTarget = new ColoredConsoleTarget();
    consoleTarget.Layout = consoleTarget.Layout = @"${date:format=HH\:mm\:ss} ${logger} ${message} ${mdc:item=CustomerId}";
    logConfig.AddTarget("console", consoleTarget);
 
    var dbTarget = new DatabaseTarget();
    dbTarget.ConnectionStringName = "NLog";
    dbTarget.CommandText = @"
    INSERT INTO [dbo].[NLog]
    ([MachineName]
    ,[SiteName]
    ,[Logged]
    ,[Level]
    ,[UserName]
    ,[Message]
    ,[Logger]
    ,[Properties]
    ,[ServerName]
    ,[Port]
    ,[Url]
    ,[Https]
    ,[ServerAddress]
    ,[RemoteAddress]
    ,[Callsite]
    ,[CustomerId]
    ,[Exception])
        VALUES (
    @machineName,
    @siteName,
    @logged,
    @level,
    @userName,
    @message,
    @logger,
    @properties,
    @serverName,
    @port,
    @url,
    @https,
    @serverAddress,
    @remoteAddress,
    @callSite,
    @CustomerId,
    @exception
    )
";
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@MachineName", "${machinename}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@SiteName", "n/a"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Logged", "${date}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Level", "${level}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Username", "${identity}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Message", "${message}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Logger", "${logger}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Properties", "${all-event-properties:separator=|}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@ServerName", "n/a"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Port", "n/a"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Url", "n/a"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Https", "0"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@ServerAddress", "n/a"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@RemoteAddress", "n/a"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@CallSite", "${callsite}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@CustomerId", "${mdc:item=CustomerId}"));
    dbTarget.Parameters.Add(new DatabaseParameterInfo("@Exception", "${exception:tostring"));
 
 
    // add rules
    var rule1 = new LoggingRule("*", LogLevel.Debug, consoleTarget);
    logConfig.LoggingRules.Add(rule1);
 
    var rule2 = new LoggingRule("*", LogLevel.Debug, dbTarget);
    logConfig.LoggingRules.Add(rule2);
 
    LogManager.Configuration = logConfig;
}
```

## Bringing it all Together

All that’s left is to create the table and add the connection string (named “NLog” in the example above) to your application’s config file. You’ll find the complete, runnable sample, including the script to create the database table, on[GitHub](https://github.com/ardalis/ConsoleLoggingSample). Here’s an example of what the output looks like, including the application-specific column:

![](/img/sampledata.png)

**Next**: [Configure NLog Using StructureMap](http://ardalis.com/configure-nlog-with-structuremap) (without losing access to the richness of its API)