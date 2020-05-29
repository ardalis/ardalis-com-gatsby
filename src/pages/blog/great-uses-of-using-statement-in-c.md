---
templateKey: blog-post
title: Great Uses of Using Statement in C#
path: blog-post
date: 2010-06-18T15:04:00.000Z
description: "In my last post about [testing emails in
  .NET](https://ardalis.com/testing-email-sending), I noted the use of the using
  statement to ensure safe usage of the IDisposable SmtpClient and MailMessage
  objects. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
category:
  - Software Development
comments: true
share: true
---
In my last post about [testing emails in .NET](https://ardalis.com/testing-email-sending), I noted the use of the using statement to ensure safe usage of the IDisposable SmtpClient and MailMessage objects. This is the typical usage of the using statement, but you can take advantage of this statement’s behavior for other scenarios as well, resulting in cleaner code.

Consider the scenario where you want to perform some kind of pre- and post- processing around an arbitrary block of code. The simplest scenario I know of is when you want to time some code, using the stopwatch class. If you want to perform basic stopwatch usage, you can write some code like this (borrowed from the stopwatch MSDN docs):

```csharp
public   static   void  BasicStopWatchUsage() 
{ 
    Console.WriteLine( "Basic StopWatch Used: " ); 
    var stopWatch =  Stopwatch.StartNew(); 
    Thread.Sleep(3000); 
    stopWatch.Stop(); 
    TimeSpan ts = stopWatch.Elapsed; 
 
    string  elapsedTime = String.Format( "{0:00}:{1:00}:{2:00}.{3:00}" , 
                                        ts.Hours, ts.Minutes, ts.Seconds, 
                                        ts.Milliseconds/10); 
    Console.WriteLine(elapsedTime,  "RunTime" ); 
}
```

This works, and of course the Thread.Sleep(3000); is where our actual work would go. If our actual work is a relatively small amount of code, it can easily be lost in the clutter that comprises our stopwatch profiling code. We can rewrite the above code like so if we move our profiling code into an IDisposable class:

```
private static void UsingStopWatchUsage() 
{ 
  Console.WriteLine( "ConsoleAutoStopWatch Used: " ); 
  using  ( new  ConsoleAutoStopWatch()) 
  {
    Thread.Sleep(3000);
  }
}
```

And of course, even the Console.WriteLine could be moved into the ConsoleAutoStopWatch class’s constructor if we wished to do so. The ConsoleAutoStopWatch, so named because it’s coupled to the Console (you could easily create similar implementations that use your favorite logging component, or dependency-inject the outputter for the class), is shown here:

```
public class ConsoleAutoStopWatch : IDisposable
{
  private readonly Stopwatch _stopWatch;
  public ConsoleAutoStopWatch()
  {
    _stopWatch = new Stopwatch();
    _stopWatch.Start();
  }

  public void Dispose()
  {
    _stopWatch.Stop();
    TimeSpan ts = _stopWatch.Elapsed;
    string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                                        ts.Hours, ts.Minutes, ts.Seconds,
                                        ts.Milliseconds / 10);
    Console.WriteLine(elapsedTime, "RunTime");
  }
}
```

Now anywhere you need to profile a small block of code or a method call, you can simply wrap it in a using(new ConsoleAutoStopWatch()) {…} block. Note also that since our code doesn’t require any reference to the ConsoleAutoStopWatch class, we don’t even set it to a variable instance. It’s sufficient to simply new it up within the using().

You can imagine other scenarios where you may have some pre- and post- processing you need to do that is independent of the work being done. In these scenarios, you can clean up your code and separate your concerns effectively through this kind of usage of the IDisposable pattern and the using() statement.

*[Subscribe to Steve’s blog here](http://feeds.feedburner.com/StevenSmith); follow Steve at <http://twitter.com/ardalis>.*