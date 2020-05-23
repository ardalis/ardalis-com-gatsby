---
templateKey: blog-post
title: Ultimate Developer Rig 2019
date: 2019-04-30
path: /ultimate-developer-rig-2019
featuredpost: false
featuredimage: /img/dev-machine-2019-buildout-760x360.png
tags:
  - benchmark
  - computer
  - developers
  - hardware
  - pc
  - performance
category:
  - Productivity
  - Software Development
comments: true
share: true
---

I recently upgraded my desktop developer machine. My goal was to support more docker-based application development including ones that run multiple microservices at the same time, like the [eShopOnContainers sample](https://github.com/dotnet-architecture/eShopOnContainers) that I assist with (see also my own [eShopOnWeb sample and eBook](https://github.com/dotnet-architecture/eShopOnWeb)).

My friend Bill Henning (of [Actipro Software](https://www.actiprosoftware.com/) fame) came up with the initial parts list for his machine back in November 2018 (when all this started - prices are updated to April 2019 though): 

![](/img/dev-machine-2019-buildout-1024x686.png)

Bill's initial spec list - prices as of April 2019.

My [build](https://pcpartpicker.com/list/Ffjm9J) is similar:

![](/img/ultimate-developer-rig-2019-1024x653.png)

My build - leaves out a few expensive items like huge SSDs and gaming monitor.

[You can review the parts list here.](https://pcpartpicker.com/list/Ffjm9J)

Also see my [complete list of tools I use here](https://ardalis.com/tools-used).

I also saved some money by getting a refurbished power supply from NewEgg for substantially less than the price listed above ($105). I already have a pair of decent monitors so I was all set there. It is a pretty case with fancy RGB lights. Since I expect to spend many nights up late with this thing, I decided to name it [NightKing](https://gameofthrones.fandom.com/wiki/Night_King). Here's a pic of it today:

![](/img/NightKing-UltimateDevRigh2019-1024x768.jpg)

Pretty colors... No, the case isn't open - it's very clear tempered glass.

The [case came with 3 RGB LED fans](https://amzn.to/2Wh4VyD) (shown here top-mounted - Bill really prefers them in the front). The [Corsair H115i liquid CPU cooler](https://amzn.to/2WcDCW2) includes a radiator with 2 larger LED RGB fans, which I have front-mounted. The Corsair iCUE software actually does a nice job of letting you configure light effects.

So, how does it do?

## Benchmarks - Dev

This is a machine I intend to use for both gaming and development. Let's start by building [Orchard Core](https://github.com/OrchardCMS/OrchardCore), a large .NET CMS application. I'm using this [specific commit](https://github.com/OrchardCMS/OrchardCore/commit/47227488a5f21d7f1e3b2d62fb7d403173ea94c1) if anyone wants to compare.

I did a `dotnet restore` first, then ran `measure-command { dotnet build }`, twice. I haven't done any overclocking of the machine so this is with stock clock speed:

![](/img/orchard-run-2-1024x500.png)

The first run seemed to do a bunch of network I/O.

First one ran in 28 seconds; second one in 8 seconds.

## Benchmarks - Passmark

I ran the Passmark PerformanceTest 9.0 benchmark on the machine today and here's the result:

![](/img/ultimate-developer-rig-2019-passmark.png)

Not bad for no overclocking and no 4K display...

The 2D graphics aren't as high as they might be because I didn't have a larger display, so some of the bigger tests didn't run. Overall, though, it's a very fast machine, especially considering that it's now almost 6 months old (remember, the parts were bought in November 2018).

By comparison, [Scott Hanselman's dev machine built in late 2018](https://www.hanselman.com/blog/BuildingTheUltimateDeveloperPC30ThePartsListForMyNewComputerIronHeart.aspx) scored 6075 base, and he got it up to 7285 with some tuning and overclocking (which I haven't done, yet, and probably won't honestly).

## Benchmark - Gaming

My main game at the moment is [PlayerUnknown:Battlegrounds (PUBG)](https://www.pubg.com/). Running it on this machine with all graphics maxed out, it gets around 120+ FPS most of the time. This machine will probably handle my dev and gaming needs/wishes for a while to come.

![](/img/image.png)

FPS shown top left is 129.

## Initial Troubles

Read this section if you want to hear about the frustrations of trying to get a custom PC built. If that bores you, you're done here, move along.

Bill and I spent several hours building our two machines in early December. Within the first week, his stopped being able to POST, so he RMA'd his motherboard back to the manufacturer. He got a replacement about 2 weeks later and then he was good to go after that.

Mine was working fine and I was happy for most of December, and then mine started having weird issues. It would just click off. I'd try to turn it on, and you'd hear and see the fans spin up for half a second, and then an audible click and it was off again. I could sometimes mess with the power cable connections to the power supply to get it to stop this behavior, at which point it would run for a good while before the issue occurred again. This was rather frustrating as you can imagine.

This really seems like a power issue. Checking NewEgg's site, I noticed some folks had rated my (refurbished) power supply poorly and cited similar behavior. OK, I decided to RMA the power supply. So in early January, I sent the power supply back, waited a couple of weeks, and got a new one. I installed it, expecting all to be good. Nope. Same behavior. ?

Ok, if it wasn't the power supply, it was probably the motherboard. By now it's early February (I traveled a lot in January so I didn't spend a ton of time troubleshooting). I took the machine to the local PC repair shop, explained the issue. They agreed, motherboard. So we RMA'd the motherboard. Two weeks go by. They send back the motherboard, claiming they tested it and it's fine. Meanwhile, the PC shop tested the power supply, the RAM, the video card and all of it checked out, too. But the behavior persisted.

Not believing the manufacturer and still thinking it must be the motherboard, we swapped out the motherboard with a new one. Same behavior. WTF??? ?

At this point, the PC shop is at their wit's end and is ready to just give up. I convince them they're much more likely than I am to figure this out. We've swapped out every component except the case, some LED lighting controllers, and the CPU. The CPU is expensive, and the LED light stuff is easy to disconnect (same behavior), so we get a new exact same model case, and it still does the same thing!

Now the PC shop decides to experiment with something different and they start using a separate power supply along with mine, with some of the power coming from each. In so doing, they swap around some of the cables being used to power components inside the case. You see, when I swapped out power supplies, I didn't send back all of the power cables that came with the original one. So, one thing we hadn't, to this point, swapped out was the power cables themselves. Do you see where this is going?

It turns out that one of the SATA power connectors that came with the original power supply was the culprit. These things are under $10 but a bad one had cost me months of trying to troubleshoot my custom PC build. Also, I was very pleasantly surprised by how inexpensive the local PC shop was and what a good job they did with putting my system back together much more neatly than I ever could have done. So, next time, if I don't just break down and buy an off-the-shelf system (which won't have this kind of performance), I'll definitely just buy the parts and let the shop build out (and test!) the system for me.
