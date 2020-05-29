---
templateKey: blog-post
title: WinRT and the Paradox of Choice
path: blog-post
date: 2011-09-22T05:22:00.000Z
description: "In my recent analysis of the Windows 8 / WinRT options for
  building Metro style Apps, I mentioned the many choices Microsoft is offering
  for building these applications. "
featuredpost: false
featuredimage: /img/winrt.png
tags:
  - design
  - editorial
  - windows
  - winRT
category:
  - Software Development
comments: true
share: true
---
In my recent [analysis of the Windows 8 / WinRT](/analyzing-windows-8-and-winrt) options for building Metro style Apps, I mentioned the many choices Microsoft is offering for building these applications. While I agree with Microsoft’s decision to support C++, .NET, and HTML5/JS developers when building these applications, it does still represent a [Paradox of Choice](http://en.wikipedia.org/wiki/The_Paradox_of_Choice) for many developers, myself included. If we consider only native apps for the iPad, there are far fewer choices involved when it comes to programming language and platform (effectively there is only one choice, or as my daughter Ilyana likes to tell me “One choice is not a choice!”). Recently, a fair number of high profile companies (such as Amazon with their Kindle) have been shifting from native iOS apps to HTML5 implementations to bypass Apple’s draconian in-app purchase requirements, so at this point there is also a choice between native and HTML5 on the iOS as well (which is good for Microsoft, as having to make these choices is a bad thing). For [example](http://www.abc.net.au/technology/articles/2011/09/22/3323699.htm):

> *Amazon created Kindle Cloud Reader because Apple rewrote its licensing agreements to demand a 30% cut of any sales made through an iPhone or iPad app. Whatever, Amazon said, we don’t need Apple’s expensive platform, we’ll do it through the Web, and leave Apple high and dry.*

## Why So Many Choices?

Windows 8 and its new WinRT native libraries can be targeted by C/C++ developers just as the age-old Win32 libraries could be. This hasn’t really changed and there are certainly many applications that require the kind of low level control that C/C++ offer (complex games, device drivers, etc.). However, for 99% of developers out there building simple games, social media apps, productivity tools, and business apps, C++ is not the answer in Win8 any more than it has been for the last 10 years. If we remove C/C++ from the equation, we are left with two choices when building Metro style Apps for Windows 8:

1. XAML markup with C# or VB.NET code, on the CLR, with a subset of the .NET framework available
2. HTML5 markup plus CSS with Javascript code, using the WinJS library that provides access to WinRT.

In my opinion, the first choice has to be provided in order to give the vast majority of Microsoft developers a way forward. The Silverlight/WPF community can bring their skills (mostly) forward if they take the first choice, though they will need to learn new controls and new APIs for working with WinRT as opposed to WPF/SL. General .NET developers who haven’t yet done anything with XAML will have a somewhat larger learning curve, but XAML itself is a very mature UI platform at this point, so it should be pretty easy for these developers to find the resources they need to quickly get up to speed with this.

Web developers, on the other hand, will likely find the HTML5+CSS+JS option attractive. And there are a LOT of web developers, many of whom do not currently use the Microsoft stack for their web applications. Microsoft is no doubt hoping that some percentage of these PHP/Ruby/Python/etc developers will see the opportunity to write cool apps that run natively on Windows without having to learn a new language, and will join the Windows developer ecosystem. There are also many Microsoft web developers, who build applications today using ASP.NET and C# (or perhaps VB) on the server, but who must also know CSS and JavaScript and HTML for the client work. Many of these developers will likely opt to go the HTML5+CSS+JS route rather than the XAML route.

## Why Is Having Choice Not Just a Good Thing?

The problem with choice is that it requires us to make decisions. And usually it requires us to make decisions without as much information as we might like. For instance, ten years ago many Microsoft developers (and entire companies) had to make a choice about which language to standardize on for their .NET development. At the time, there were millions of VB developers and there was also this new language, C#, that was getting some attention. Nobody could know whether both languages would continue to exist for years to come or whether one or the other would go the route of FoxPro or J++. Of course we can look back today and see that C# became the dominant player for .NET development, but that both languages continue to be fully supported, and in fact they are nearly 100% functionally equivalent since for many years there has been a single team maintaining them at Microsoft.

Still, I know many developers and companies who bet on VB and now regret that decision. Finding VB resources, whether they be books, samples (even from Microsoft), or developers themselves has grown increasingly difficult, while the opposite has been true for C#. There is a potential cost to choosing the wrong horse to back.

## Which Should You Choose?

Assuming, of course, that you are inclined to write a Windows Metro style App at all, you are faced with a choice. For certain applications, C++ remains the obvious choice. However, for the kinds of apps that we have seen at BUILD and on the developer preview slate, C++ isn’t really a contender (source: [Justin Angel’s Blog](http://justinangel.net/ReverseEngineerWin8Apps))

As I already mentioned, if you’re a XAML/C# developer today with WPF/SL, then your easiest way forward is with XAML/C# in Win8. That doesn’t mean it’s the optimal choice – it might be that the breakdown shown above is still the norm a year after Win8 ships, in which case it’s likely that XAML Apps will go the way of VB .NET Apps in the long term. But it’s far too early to predict that. I am confident in predicting that HTML and Javascript aren’t going anywhere for a while, though (in general, not necessarily on Windows).

If you’re an ASPNET/C# developer today, then you have a somewhat tougher choice, since you either give up C# or you’re forced to learn XAML. I tend to consider myself to be a member of this category, and I believe the optimal choice is to go the HTML+JS route. I prefer C# as a language, but I know that any improvements I make in my skill with HTML, CSS, and JavaScript will translate into better ability to build ASP.NET applications (and I certainly plan on continuing to do so). I’ve never been terribly happy working in the XAML world when I have done so, and the fact that we’re now up to our 3rd XAML UI stack from Microsoft (each incompatible with the last) makes me hesitant to jump on board now.

Of course**it’s rather early to be making these kinds of decisions**, and to be sure any major decisions relating to companies or products that I’m involved in will be delayed until the *last responsible moment*. But right now, as things stand today, I’m feeling like the right wa

y for ASP.NET developers to go if they choose to build Metro style Apps for Win8 is the HTML+JS route. It hurts to give up C#, especially with some of the new features coming in the next version, but I’m sure I’ll still be using it on the server (unless node.js takes over…).

Anyone who wants to build a Win8 Metro style App will have to make this language decision (for each App) – which one do you think is the best and why?