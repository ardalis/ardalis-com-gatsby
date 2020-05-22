---
templateKey: blog-post
title: Better Performance from Async Operations
path: blog-post
date: 2017-09-25T21:03:00.000Z
description: The C# language has had support for the async and await keywords
  (and yet another new way to perform asynchronous operations) for a while now.
featuredpost: false
featuredimage: /img/better-performance-from-async-operations.png
tags:
  - C#
  - dotnet
  - performance
category:
  - Software Development
comments: true
share: true
---
The C# language has had support for the async and await keywords (and yet another new way to perform asynchronous operations) for [a while now](https://stackoverflow.com/questions/13179923/which-net-version-for-c-sharp-5-async-features). They’re still confusing to many developers (including me sometimes!) and can be a source of many pitfalls. I mostly work in ASP.NET projects, and the default project templates have all been using async for some time. New developers often assume this is because async is “faster”. They don’t necessarily realize that the reason these methods are async is not so that the method in question returns more quickly, but so **all the other requests being handled by the server are not blocked.** It’s (usually) more of a scalability benefit than a direct performance benefit. However, there are situations in which it can be beneficial to use async, such as when tasks can be performed in parallel.

We had the [TPL](https://msdn.microsoft.com/en-us/library/dd537609(v=vs.100).aspx) for some time and could use that to perform tasks in parallel, but if you’re already working with async method calls there’s no reason (that I know of) not to use Task.WhenAll to achieve parallel processing. Let’s look at an example. Imagine you’re planning a party, and you need to send out invites, purchase food, and clean the house. Each of these tasks involves a lot of out-of-process I/O, so naturally you design them for asynchronous use. In this example, we’ll model each of these activities as their own method which takes some time to complete (2000ms):

```
public static async Task<int> SendInvites()
{
    await Task.Delay(2000);
 
    return 100;
}
public static async Task<decimal> OrderFood()
{
    await Task.Delay(2000);
 
    return 123.23m;
}
public static async Task<bool> CleanHouse()
{
    await Task.Delay(2000);
 
    return true;
}
```

Ok, so we have a few tasks we need to accomplish, and each one returns something different. We’ll tackle that detail in a bit. But first, let’s look at the simplest way to call these methods and spit out the time it took to do the work:

```
var partyStatus = new PartyStatus();
 
var timer = Stopwatch.StartNew();
 
partyStatus.InvitesSent = await SendInvites();
partyStatus.FoodCost = await OrderFood();
partyStatus.IsHouseClean = await CleanHouse();
 
Console.WriteLine($"Elapsed time: {timer.ElapsedMilliseconds}ms");
```

In the above code, you can see that our PartyStatus instance has three properties, each of which is being set to the result of one of the party-prep activities. If you run this code, you will see that the elapsed time is **about 6000ms**.

Now, to execute these tasks in parallel, but still assign their results just as we have done here, we need to take two steps:

1. Assign (without awaiting) the methods to local variables.
2. Call (with await) Task.WhenAll on the local variables.

Once we’ve done these two steps, we can then await on the variables to pull out their results. They will already have completed, but this await is needed to convert the Task into its result. Here’s the code:

```
timer = Stopwatch.StartNew();
 
var sendInvites = SendInvites();
var orderFood = OrderFood();
var cleanHouse = CleanHouse();
 
await Task.WhenAll(sendInvites, orderFood, cleanHouse);
partyStatus.InvitesSent = await sendInvites;
partyStatus.FoodCost = await orderFood;
partyStatus.IsHouseClean = await cleanHouse;
 
Console.WriteLine($"Elapsed time: {timer.ElapsedMilliseconds}ms");
```

If you run the above code, you will see that the elapsed time is **about 2000ms**. The power of parallelism at work (and a reason to find a few friends to help you prep for your next party!).

Thanks to Stephen Cleary for his [StackOverflow answer](https://stackoverflow.com/a/17197786/13729) that this is based on.

### But wait, there’s more!

I created a simple console application to demonstrate this. [You can grab the source from GitHub](https://github.com/ardalis/WhenAllTest). A fairly common question about console applications is, how can you call an async method from public static void main? Once again, Stephen Cleary has [a great answer on StackOverflow](https://stackoverflow.com/a/9212343/13729) that I used for this sample (in fact he describes a few different options – I used the simplest one). My code:

```
static void Main(string[] args)
{
    MainAsync(args).GetAwaiter().GetResult();
}
 
static async Task MainAsync(string[] args)
{
  // all of my async code and await calls go here
}
```

That’s all you need to go from your synchronous main method to an async task, and from there you can go async all the way down (as one does).

### Update for C# 7.1

As Michal points out in the comments, [C# 7.1 supports async main natively](https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-7-1). You can use C# 7.1 if you’re running VS2017 15.3 or later, or the .NET Core SDK 2.0. However, the features are off by default, so to enable them you must change the language version setting in your .csproj file:

```
<PropertyGroup>
  <LangVersion>latest</LangVersion>
</PropertyGroup>
```

(if you use VS to update the file, you may have multiple conditional sections for this setting, based on build configurations)

Once you’re able to run C# 7.1, you can write code like this:

```
static async Task<int> Main()
{
    // This could also be replaced with the body
    // DoAsyncWork, including its await expressions:
    return await DoAsyncWork();
}
 
// or
 
static async Task Main()
{
    await SomeAsyncMethod();
}
```

> Check out my podcast, [Weekly Dev Tips](http://www.weeklydevtips.com/), to hear a new developer productivity tip every week. You can also [join my mailing list](https://ardalis.com/tips) for similar tips in your inbox every Wednesday!