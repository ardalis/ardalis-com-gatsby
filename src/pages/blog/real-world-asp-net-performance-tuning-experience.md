---
templateKey: blog-post
title: Real World ASP.NET Performance Tuning Experience
path: blog-post
date: 2007-08-03T11:59:04.704Z
description: "I'm in the midst of wrapping up a multi-year long project to
  replace the advertising engine used to host sponsored ads on a few dozen .NET
  web sites. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - C#
  - Caching
  - performance
  - Scalability
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I'm in the midst of wrapping up a multi-year long project to replace the advertising engine used to host sponsored ads on [a few dozen .NET web sites](http://lakequincy.com/). This system traces its "lineage" back to an old ASP application written in 2001 (it served its first 207 impressions on 31 March 2001), and has since been upgraded to ASP.NET 1.0 and 2.0 both as incremental ports, not full revisions (for instance, the database remained constant between these ports, and there was never any decent UI for managing the ads (basically direct table access). Anyway, the system has grown and grown and now serves about 100M impressions per month, which if you do the math works out to an average of almost 40 requests/sec. Of course that's not constant – it's much busier on weekdays than on weekends, and it's busiest in the afternoon hours of US EST time. So, at its peak it's running about double that, or 80 requests/sec.

Currently the system is hosted on a shared web farm at [ORCSWeb, my web host](http://orcsweb.com/). Incidentally, I worked with several other web hosting companies (most of which have since been bought or otherwise disappeared) before switching to ORCSWeb many years ago, and I've never looked back. They are the best.

Anyway, after much effort and of course long past when it was scheduled to launch, I flipped the switch and upgraded the system to use the new ad engine on Wednesday, 1 August 2007, in the wee morning hours. Everything seemed to work, which shocked me as it would any developer (but in a nice way), so I went to bed happy, but still with that lingering unease that somehow that seemed a bit too easy.

Wednesday during the day rolls around and ORCSWeb wants to chat with me. It seems the ad engine process is using up a bit more than its usual share of CPU on the web farm. We rolled back the engine to use the old logic, **which fortunately was easy because I'd made it just a configuration switch\[GOOD]**, so that we could investigate the problem. I suspected a bit of code I'd written to filter out ads based on certain conditions was the main suspect, so **(before profiling or doing any scientific work\[BAD])** we quickly optimized that bit of code and verified that **our unit tests still worked (so we were confident the engine still performed correctly) \[GOOD]**.

I rolled out the changes with our server admins watching the CPU on the boxes and it did help a fair bit, but we were still heavier on the CPU than was acceptable. At this point, we'd already nailed the low hanging fruit that I could easily identify, so it was time* to do some proper investigation with the right tools.

\* Sadly, this is when most organizations decide it's time to bring in the performance consultants or to think about buying profiling and load testing tools. It's **\[BAD]** but not at all uncommon, and it wasn't lost on me that this was the exact scenario I've often spoken on as being a bad practice, yet here I found myself.

Thankfully I hadn't been a total **noob** on the performance testing front. I had the right tools. I had a load test server set up with the site and a 10-day-old copy of the production database. Within a couple of hours I was able to run some tests with a few different variables and see what had the biggest impact on my requests/sec relative to my server's CPU. At the same time, I was also firing up a profiler and running through the code in the profiler to try and determine which specific function(s) were taking the most time. One reality of load testing is that most of the time you're waiting on the tests, so there's plenty of opportunity to multi-task. (**If you're hiring consultants to load test, give them something else to do while they're waiting on tests\[GOOD]**).

For the load testing I used a .loadtest calling a .webtest in [Visual Studio Team Suite](http://msdn2.microsoft.com/en-us/teamsystem/default.aspx). This worked great for my needs, and I was easily able to monitor various performance counters as the tests ran. It was clear from the initial run that CPU and Requests/Sec were tightly bound to one another, for instance, and I was only able to achieve 80 requests/second before the CPU was pegged. Since the DB and Webserver and Test Client were all on the same box for this test (not ideal, but it worked), I also checked to see if the CPU was being consumed by the database, the webserver, or the test apparatus. Almost all of it (and the part that was increasing with load) was coming from the webserver. So I knew I wasn't going to achieve anything by trying to optimize the database (which [Mike](http://sqladvice.com/blogs/repeatableread) and [Gregg](http://sqladvice.com/blogs/gstark) have already helped me optimize).

For my profiling needs, I was using [Red Gate ANTS Profiler](http://www.red-gate.com/products/ants_profiler/index.htm). I've used this product for several years and although it didn't work for me briefly earlier this year on Vista, the latest version runs on Vista without any issues. This tool is great (and very reasonably priced). It occurred to me earlier this week that I was using all kinds of Red Gate tools, since I registered/activated three different tools from them within a couple of days (the other two were [SQL Prompt](http://www.red-gate.com/products/SQL_Prompt/index.htm) and [SQL Refactor](http://www.red-gate.com/products/SQL_Refactor/index.htm), both of which are seeing heavy use by me as well and are worth an evaluation if nothing else).

**Profiling my code showed me something I hadn't really expected, which is exactly what I expected.**

**92.3%** of the time (I might have made up this statistic), the real bottleneck that the profiler reveals is not the bottleneck you thought it would find. Knowing this, it did not surprise me that what it found to be the problem came as a total surprise. In this case, it was an HTTP Module that was the culprit, and ironically enough, it was barely doing \*anything\*.

**For optimimum performance, you should remove any HTTP Modules that you are not using\[GOOD].** This includes many of the built in modules, such as Session or PassportAuthentication. In fact, I was already following this advice, and had removed several ASP.NET modules which I did not need. However, earlier this year I'd added a [URL rewriting module](http://blog.ewal.net/2004/04/14/a-url-redirecting-url-rewriting-httpmodule) in order to change the URL of my [ELMAH](http://code.google.com/p/elmah) error listing. It's been running just fine in production **for months**. So, why did it cause such issues with the new ad engine?

Well, I suspected that it was actually causing issues all along, so the next load test I ran was with it disabled. Let me just say, there are few things more satisfying to me as a professional developer and self-styled performance and scalability guy than to be able to remove a bottleneck and watch requests/sec go through the roof. **Upon removing the module, my load test went from a peak load of 80 requests/sec to 550 requests/sec \[GOOD]. That's a 587% improvement.**

The module was actually a problem in production even before I flipped the switch to use the new ad engine, but the CPU load generated wasn't too much for the hardware. My code to support moving to the new ad engine used 302 redirects from the old engine's tags to the new tags, resulting in double the number of requests coming into the server, and thus doubling the number of times the Module was invoked. I had ORCSWeb watch the servers while I disabled the module while the old ad engine was running (I don't have direct access to these servers). Their next words: "wow.&quo

t; The CPU which had been running between 25 and 50% dropped to 2-6%. I flipped on the new ad engine. CPU moved to around 5-10%. The problem had been solved within hours because of the right tools: a load test environment (VSTS in my case) and a code profiler (Red Gate ANTS Profiler in my case). Without using the proper tools to scientifically detect the problem, I would never have thought to look at that module, because a) it hadn't changed b) it worked fine in production and c) it was doing a seemingly trivial amount of work. There was no reason to suspect the Module going into the testing, but as usually happens, the testing revealed something unexpected. **That's why it's important to scientifically test\[GOOD], rather than start tuning based on your gut\[BAD]. Your gut is almost always wrong**.

Further examination of the URL Rewrite Module revealed that while it's very elegantly written and very flexible (and very fast – on average it takes about .02 seconds to run), it also could benefit from some caching, especially of its compiled regular expressions. I haven't had time to properly optimize it for high performance (and it works fine for your typical website that only gets a few million page views per month or less), but if I do I'll be sure to publish it. At the moment I don't really need it for my app.

At the end of the day, the following old lessons and best practices had been beaten into me with the added harshness of my having known better:

1) As hard as it is, try not to cut out load testing and profiling even if the delivery date slips.

2) When performance problems arise, try not to jump immediately into "fix it" mode before doing any diagnosis. This is the equivalent of doing surgery before doing XRays, and it's usually detrimental to the patient.

3) Have a load test environment set up using the latest build of the application and (if this is a production app) a recent copy of your production data. Test data is never as good as real data for load testing. Even a single machine or a VPC can serve as a load test environment, since you're trying to find things that improve throughput relative to a baseline throughput in the test environment. Obviously the close your test hardware is to your production hardware the better, but something is better than nothing, and your development PC can serve as your load test lab if that's all you have budget for.

4) Use the right tools to find the real bottleneck in your code. Code profilers, unit tests, and load tests all help give you insight into where your code is spending the most time and how different configurations affect overall performance and throughput.

5) When deploying a new version of an existing application, have an easy way to roll back and roll forward your changes. "Undo" functionality is almost always worth building into anything you write.

Have your own tips? Add them in the comments. I hope this helps some folks and doesn't just show that I can't even follow my own advice :).

<!--EndFragment-->