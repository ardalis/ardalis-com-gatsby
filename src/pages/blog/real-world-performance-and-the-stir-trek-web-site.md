---
templateKey: blog-post
title: Real World Performance and the Stir Trek Web Site
path: blog-post
date: 2011-04-10T01:54:00.000Z
description: I recently joined the board responsible for organizing the [Stir
  Trek conference](http://ardalis.com/stirtrek.com) in Columbus, Ohio. This is a
  great conference I’ve spoken at the last couple of years that’s held in a
  movie theater on opening day of a new great movie.
featuredpost: false
featuredimage: /img/digitization-5140055_1280.jpg
tags:
  - performance
  - Scalability
  - stir trek
  - tuning
category:
  - Software Development
comments: true
share: true
---
I recently joined the board responsible for organizing the [Stir Trek conference](http://ardalis.com/stirtrek.com) in Columbus, Ohio. This is a great conference I’ve spoken at the last couple of years that’s held in a movie theater on opening day of a new great movie. The first one, two years ago, was held for the opening day of Star Trek (hence the name), and last year was Iron Man II. This year’s movie is Thor, which looks to be pretty awesome. Here are some badges promoting the event:

[![image](<> "image")](http://stirtrek.com/)

[![image](<> "image")](http://stirtrek.com/)

You can find more [here](http://stirtrek.com/Extras).

The site opened for registration a few weeks ago and sold out very quickly. However, there were some issues with the web site that were troubling. The site basically died under the load – obviously not a great first impression. Fortunately the dev community is pretty awesome in Ohio, and after the initial spike in traffic when the “doors” opened for ticket sales, the site seemed to work fine. However, there was the nagging fear that it would have similar issues on the day of the event, which would of course be bad.

A few ideas were kicked around. Maybe it was the hosting provider – shared hosting is great and inexpensive (Stir Trek is a non-profit deal; it’s good to keep expenses in check), but maybe it just couldn’t handle the load. What about putting it up on Windows Azure? Surely that would be able to scale. Of course, now that the event has been sold out and the agenda and such finalized, there’s nothing much dynamic happening with the site – what if we just replace the dynamic pages with static versions?

It was around this point in the conversation that I found myself participating on the board, having just been added, and so those of you who know me can probably guess what my first thought was: *can’t we just throw some [caching](http://www.bing.com/search?q=steve+smith+cache+pattern&go=&form=QBRE&qs=n&sk=) at it?*

And so I did. I got some access to the source a couple of days ago and added some output caching to a few of the controller actions, and things did get better. Of course, I did this without doing any proper measuring or testing, mostly because I was doing it in the middle of a conference call with the board, on my laptop, in a hotel. Don’t do that when it’s real code you get paid to maintain.

Once I got back home, I did some proper testing and tuning and found the real issue. As usual, ***caching hides many sins***, and in this case I was able to essentially band-aid over the problem and improve page load times for the site significantly, but the underlying problem remained, and under any amount of load, it would still be problematic. How problematic? After a couple of minutes with 25 users accessing the site’s public pages during a load test (with small but non-zero think time, mind you), it would simply fall over with one of these:

![SNAGHTML352218e6](<> "SNAGHTML352218e6")

My first few load tests looked like this (page response time):

![image](<> "image")

![image](<> "image")

![image](<> "image")

But I’m getting ahead of myself. Let me back up a bit.

To generate these tests, I recorded a Web Performance Test that hit each of the public URLs for the site.

![image](<> "image")

I noticed pretty much immediately that just running these tests without any load at all was resulting in page times hovering around a second. That’s not awful for reports or pages that actually do something, but here we’re talking about essentially a static site. It’s not even tracking user sessions or displaying a “Hello, UserName” on it. These pages should be much faster.

To set up the load test, I simply added a Load Test using Visual Studio 2010. You can click through the wizard pretty easily. I recently wrote a post about [how to use visual studio 2010 for load testing (with unlimited virtual users now)](/visual-studio-2010-unlimited-load-test-virtual-users) if you want to learn more about that.

Once you have the load test, then it’s a matter of making small changes to the app. For instance, I tried the following variations, with some hand-written notes:

* No caching
* Just caching some of the Controller Actions (my initial attempt at fixing the problem – I missed a couple of actions)
* Caching all of the Controller Actions in my Web Test
* Adding data caching to some data fetched in the Controller’s constructor
* Replacing SessionFactory.Create() calls with SessionFactoryManager()
* Adding double-check locking to cache access pattern

The first three iterations are shown above. All of them still resulted in death of the application under a relatively short period of load with relatively few users. And they still didn’t account for why the pages were so slow even when there was no load. I ran the pages through Visual Studio’s profiler and the really cool Tier Interaction Profiler, which showed me this:

![image](<> "image")

Clearly, there were too many queries occurring per page request. I’m not an NHibernate expert, which is the ORM the site’s using, but I knew this could be fixed. I considered breaking out my copy of [NHProf](http://www.nhprof.com/) to address the way-too-many-queries issue, but figured there had to be an easier solution. I also considered implementing the Repository pattern and adding in some dependency injection and a container like StructureMap so that I could apply the [CachedRepository pattern](/introducing-the-cachedrepository-pattern) to the issue, which I’m a big fan of. But that ultimately proved unnecessary. Fortunately, I was able to identify the bottleneck that got the site to a point where it was performing well beyond where it needed to, and while there were no doubt additional performance tweaks I could make, **[beyond good enough is waste](http://aspadvice.com/blogs/ssmith/archive/2007/06/27/Beyond-Good-Enough-Is-Waste.aspx)**, especially for work you’re not getting paid to do.

Like I mentioned, I’m pretty much a novice when it comes to nHibernate. I’ve been using LLBLGen for most of my production apps for the last 5 years, and I’ve been picking up LINQ-to-SQL and Entity Framework along the way with side apps and demos. Somehow I’ve managed to avoid working on a real application that uses NH until this point. However, I was able to determine fairly quickly that calls to FluentNHibernate.Cfg.FluentConfiguration.BuildSessionFactory() were taking up a TON of time. 22% of the time in the profiler run I showed above:

![image](<> "image")

So I did some investigating online, and found that building these things is expensive. You probably don’t want to be doing it all that often if you can avoid it. Looking through the code, I determined that the SessionFactory was being created with every data access call. A bit more research led me to [this nice writeup that included some code for an NHibernate SessionFactory Manager which I borrowed](http://www.primaryobjects.com/CMS/Article119.aspx). Fortunately, the Stir Trek site was written in a pretty nice manner, using ASP.NET MVC 2 and separate projects for entities, data access, etc. Adjusting how the SessionFactory was created only required that I touch two files. With this change in place, the site death issues disappeared. In fact, between fixing the Session Factory creation logic and caching the calls to fetch data in the main Controller’s constructor, the site started running super-fast:

![SNAGHTML353a077d](<> "SNAGHTML353a077d")

So what was the main issue? In looking at the Repository<T> class, which was responsible for all data access, I found it was using this code (Note: don’t do this):

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Repository&lt;T&gt; <span style="color: #0000ff">where</span> T : EntityBase
{
 <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> ISessionFactory _sessionFactory;
&#160;

    <span style="color: #0000ff">public</span> Repository(<span style="color: #0000ff">string</span> connectionString)
   {

 _sessionFactory = SessionFactory.Create(connectionString);

    }

}
```

I replaced this code with calls to my new SessionFactoryManager class in all of the individual methods, essentially ensuring that the SessionFactory is created only once, rather than on every call to create a new Repository. Then just be sure I’d found the main culprit, I ran the tests one more time with the above code left in. Here’s what it looked like:

![image](<> "image")

As you can see, Page Response Time is quite erratic, with many spikes, even though the average is still pretty small (due to output caching still being in place). Looking at the performance counters for the system, you can see regular spikes in CPU when the output cache expires (every 60 seconds), and more importantly, the memory/resource leak that’s occurring now.

![image](<> "image")

By simply commenting out the code in the Repository<T> like so…

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Repository&lt;T&gt; <span style="color: #0000ff">where</span> T : EntityBase
{
<span style="color: #008000">//private readonly ISessionFactory _sessionFactory;</span>

&#160;
<span style="color: #0000ff">public</span> Repository(<span style="color: #0000ff">string</span> connectionString)
{

<span style="color: #008000">//_sessionFactory = SessionFactory.Create(connectionString);</span>

}

}
```

(recall I’d already refactored out any usage of the _sessionFactory in this class)

…the resulting graphs look like this:

![image](<> "image")

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/ebe92d5fd3b2_F962/image_31.png)

The red line is CPU – at this point the system is processor-bound and has no resource leaks, which is a good place to be.

**Summary**

I’m quite confident the website will now be able to handle any traffic that is thrown at it the day of the event. This is no longer based on hope, but rather on hard numbers, and this confidence is one of the key reasons for performance testing – so you know when to stop tuning and whether your application’s hardware is sufficient for its anticipated demand.

Performance testing and tuning is a science moreso than an art. There are certain tips and tricks that you can generally apply once you have some experience, caching being one of the easiest ones, but many times these will only mask the underlying problem. When it comes to tuning an application to eliminate performance bottlenecks, it’s important to measure a baseline, then form a hypothesis, make a configuration change, and then measure its effect. This is the scientific method in practice, and it generally works much more effectively than randomly applying hacks to your code in places you think (but don’t know, not having measured) will help. I’m working on [a course for PluralSight on performance tuning with Visual Studio 2010](http://www.pluralsight-training.net/microsoft/Find.aspx?f=Steve+Smith&olt=true&h=False) if you’re interested in learning more about how to apply these steps to your own apps. Thanks and I hope to see you at Stir Trek!