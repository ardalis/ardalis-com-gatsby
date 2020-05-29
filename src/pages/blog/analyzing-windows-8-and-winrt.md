---
templateKey: blog-post
title: Analyzing Windows 8 and WinRT
path: blog-post
date: 2011-09-19T12:10:00.000Z
description: "Last week at BUILD, Microsoft introduced their vision for the next
  generation of Windows devices with announcements and previews of Windows 8,
  Metro style applications, and WinRT. "
featuredpost: false
featuredimage: /img/winrt.png
tags:
  - window RT
  - windows
category:
  - Software Development
comments: true
share: true
---
[](http://www.flickr.com/photos/guybarrette/6160248304)Last week at [BUILD](http://www.buildwindows.com/), Microsoft introduced their vision for the next generation of Windows devices with announcements and previews of Windows 8, Metro style applications, and WinRT. The BUILD conference was the most secretive event I’ve ever known Microsoft to hold, with very few leaks prior to the keynotes that began on Tuesday, September 13th. Now that the event has come and gone, you can [watch the sessions and keynote presentations for yourself here](http://www.buildwindows.com/). In this post, I am going to offer my own analysis of the event and its announcements, with what I view as some of the strengths and weaknesses of Microsoft’s strategy, and the threats and opportunities it creates. I’m also going to provide links to a large number of related resources, and I welcome you to post links to your own reaction or others you’ve found insightful in the comments below. A good place to get started is the [Building Windows 8 blog](http://blogs.msdn.com/b/b8), if you haven’t looked there yet.

## What Does Windows 8 Offer?

Some key messaging from Microsoft regarding Windows 8 are that it is a no-compromise operating system, and that one of the key elements of its design is to be “fast and fluid.” By no compromise, they mean you are not left with an OS that is only good as a tablet or only good on a desktop. You can install and use Windows 8 productively on your desktop system, and you can do so with a touch-friendly tablet or similar form factor. The experience when using the new start menu and Live Tiles is designed to be fast and fluid, and so far based on my usage of the developer preview device I received, it certainly accomplishes this. The new platform is built around supporting a new style of application development, dubbed Metro style applications. Jensen Harris, in an excellent session that **should be required viewing for any developer considering building apps for Windows 8**, describes the design principles behind these applications in his [8 Traits of Great Metro Style Apps talk](http://channel9.msdn.com/Events/BUILD/BUILD2011/BPS-1004) last Tuesday.

Windows 8 will also offer new opportunities for developers and consumers in the form of a greatly improved application distribution model. There will be a new Windows Store built into Windows 8, where consumers will be able to find, download, purchase, and install new apps for their Windows 8 PCs. The store itself is not yet available, but the early versions of the tools needed to create the distributable packages are available to developers now. These apps will be verified by Microsoft, but developers will be able to run many verification and validation checks against their app locally, eliminating some frustration when submitting apps. Apps will also run in a sandboxed environment, with increased security compared with standard Win32 applications today.

For some time, Windows has had a desktop that in my opinion has been largely underutilized. It’s a place to put some pretty pictures and maybe a few icons, but otherwise it’s fairly static and anything you want to do happens with the desktop in the background. It also doesn’t provide any up-to-date information, with the exception of add-ins like widgets and system tray notifications. With Windows 8 and the use of Live Tiles, this changes and the main view into Windows becomes a dynamic, information-rich display. Every application can provide Live Tile implementations that surface important details relevant to the application. An email app might show the number of unread messages, while a weather app might show the current weather. Users of Windows Phone 7 devices are familiar with Live Tiles and can already appreciate how much more quickly they allow information to be gleaned from the device, and their inclusion in Windows 8 is welcome, if not surprising (we saw them previewed months ago).

The new Metro design paradigm is clearly a big bet for Microsoft and one that is similar in scope to the announcements centered around .NET and the CLR ten years ago. The newly announced WinRT APIs that is used to build these Metro-style applications in Windows 8 run completely separate from the .NET framework and CLR used by “classic Windows” applications built on the Win32 library today. At least in for now, the focus of Metro-style applications is clearly on consumer scenarios such as games and fun social applications. Data-centric business applications and workhorse apps like Photoshop or Visual Studio will continue to live on as Win32 applications using the classic Windows desktop, it seems to me.

Developers can build Metro style applications built on the WinRT APIs in Windows using one of several options, as shown in this diagram. Note that this is not the diagram that Microsoft used during their keynotes, but rather a somewhat more accurate one from [Doug Seven](http://dougseven.com/) (former Microsoft employee) who clarified the original diagram last week. [Read his post](http://dougseven.com/2011/09/15/a-bad-picture-is-worth-a-thousand-long-discussions) on why the original diagram was so confusing

The green areas of the “boxology” diagram represent the new components of Metro style Apps. Developers can build these apps using HTML/CSS/JavaScript, just as they build web applications today. They can build them with C++ using DirectX or XAML. Or they can build them using managed languages like C# and VB, using the CLR and the .NET Framework (version 4.5). There was some confusion about how these various pieces all inter-relate, and Doug’s post helps to eliminate some of them but let me address them here briefly as well. A lot of the issue comes down to conflating different concepts, specifically languages, APIs, platforms, and products.

XAML, HTML, JavaScript, C# – these are all languages, and are separate from platforms and APIs. You can write XAML for WPF, XAML for Silverlight, or XAML that runs on Windows in the form of new Metro style Apps. Likewise HTML can run on a variety of platforms, of which each browser is essentially a platform. HTML/JavaScript applications can now target the Windows platform directly via WinRT APIs. It’s been possible to use HTML and JavaScript, together or separately, outside of browsers for a very long time now, and this is just one more example of where this can be done. You can also think of “Metro style” as a design language, with its own patterns and best practices, as described by Jensen Harris in his talk.

## Strengths

Obviously Microsoft has a huge existing install base with Windows, with nearly 450 million copies of Windows 7 sold and over 500 million people signing into Windows Live Services (per month, I think).

60; Microsoft has also committed to backward compatibility – every application that runs on Windows 7 will run on Windows 8. This is a huge strength, and it seems clear that a large number of Windows users will upgrade to Windows 8, at some point.

The new Metro style design is really beautiful. I honestly haven’t met a single person who doesn’t like it. I’ve shown it off in the last week to family, friends, coworkers, and strangers on airplanes and ferry boats. Everyone finds it easy to use, and is impressed by the responsiveness of the touch UI. This is a big strength. Here’s one comment from Twitter on the new UI

The forthcoming Windows Store, assuming it measures up to its promises, is also a big strength. Installing applications on Windows 7 today, compared with installing applications on my Windows Phone 7 (or iPad or iPhone), is much more difficult and time-consuming. In the first case, nothing from locating to purchasing to installing the application is consistent. In the second case, every bit of the process is consistent and stable. With the App store that will be available with Windows 8, I predict a new dawn for cool Windows Apps.

Finally, Microsoft’s development tools are far and away easier to use than Apple’s, and their developer market share is much larger (even given the huge numbers of iOS developers Apple has gained in the last few years). Assuming Microsoft continues to provide great tools with which to build Apps for its platform, both the tools themselves and the developers who use them will continue to be a strength for Microsoft. Here’s another thought from the Twitterverse

Windows 8 devices are full PCs. You can take them to class, a meeting, or while you travel just like other tablets, but still have full access to your PC’s capabilities. And when you’re at your desk, you can easily use the device as your primary computer by docking it with other, less portable hardware like external keyboard, mouse, and/or monitors. Given the choice between having to buy one computer for real work and a separate tablet for convenience use, versus only needing to buy a single device without compromising in this regard, I suspect a large share of the market will opt for the single device offering ([some analysts are predicting 15% tablet market share for Microsoft in 2014](http://business.financialpost.com/2011/09/14/microsoft-expected-to-have-15-of-tablet-market-by-2014) versus 1% in 2010).

Microsoft is also clearly hoping that by embracing standard languages like HTML, CSS, and JavaScript for building these Apps, it will lower the barrier for many developers to create Apps for Windows 8. Especially developers who might not consider themselves Microsoft or Windows developers today. There’s no question there are more Web developers than C++ or C# or VB developers, so there’s great potential here as well.

## Weaknesses

Time to market will be critical, of course. Microsoft is already late to the game, while the iPad continues to dominate the tablet market. The first iPad was launched on 3 April 2010. Microsoft has not yet released any dates for a Win8 launch, but I certainly don’t expect it to reach General Availability before 3 April 2012, so they will over 2 years behind the market leader. I also have no inside information on when the next iPad will ship, but given Apple’s nearly annual release cycle of the iPad and iPhone, it seems likely that an iPad 3 will be making its debut in 2012 as well. It’s likely that these 3rd generation devices, in addition to having 1st and 2nd generation customers eager to upgrade, will have already dealt with various rough edges that the first generation of Microsoft devices (from various vendors) will be just running into.

While its developers and their tools are one of its great assets, Microsoft is also looking for a great deal of new learning from its developer community. Whether you’re currently a C++, web, or .NET developer, you will have to learn new APIs and perhaps new languages in order to be productive with building Metro style Apps for Windows 8. Many developers may choose to stick with what they know.

Even if a large number of developers begin to develop new Metro style Apps, the same diversity of languages that offers Microsoft some strengths is also a disadvantage. Microsoft developers building applications with the .NET Framework have lived in a multi-lingual world from the start, but over time natural selection and market forces have lifted the C# language into dominance. With that dominance, .NET developers today find it much easier to locate books and online resources that they can readily use, and employers find it easy to locate developers who use the same tools they do. The risk with supporting 3 different ways to build Metro style Apps is that the same kind of “Tower of Babel” effect that plagued .NET developers will exist for Metro style App developers. How often will C#/XAML developers find solutions to their questions that are in HTML/JavaScript, and vice versa? And if you’re an ASP.NET/C# developer today, where do you invest your time while learning how to build Metro style Apps? Do you pick up XAML, which is completely foreign to ASP.NET, or do you go the somewhat familiar HTML/JS route, and give up your perhaps-beloved C# language? This classic [Paradox of Choice](http://en.wikipedia.org/wiki/The_Paradox_of_Choice) (more on this in [my post on which stack I would recommend for ASP.NET developers](/winrt-and-the-paradox-of-choice))may prove to be a hindrance to Metro style App development.

The story for Windows 8 that we’ve seen so far does not include much for the business/enterprise developer. Games and social apps seem to be the focus at this stage. It’s possible that as we get closer to a release, Microsoft will announce features that target businesses more so than consumers, but it’s also likely that such features may be pushed off until a later version of Windows. If that’s the case, it may be that many businesses don’t find a compelling reason to upgrade to Windows 8, and may wait and see what Windows 9 offers.

## Opportunities

Microsoft has a huge opportunity in the tablet space. Windows 8 is clearly well-poised to challenge the iPad in the rapidly-growing tablet market. Just as netbooks were huge a few years ago, tablets are huge today, and Microsoft is no doubt hoping they can capitalize on tablets just as they did on netbooks.

As more and more devices use the Metro style UI, Microsoft is likely to gain loyal customers who find the Live Tiles and general design appealing. Currently Windows Phone 7 and XBox Kinect share the same Metro design as Windows 8, and we have seen that even some Windows Server applications will be taking on more of a Metro style. Just as Apple is able to draw in and ke

ep customers with its many iWhatever devices, Microsoft has an opportunity to do the same thing through appropriate use of its Metro design across form factors.

There are also great opportunities for Windows developers who build Metro style Apps that are distributed through the Windows Store. I have no doubt there will be new companies made famous by as-yet-unseen apps that are built for this platform. Who will write an App that will become as popular on Windows 8 as Angry Birds is on iOS? Time will tell.

## Threats

The biggest thread to Microsoft’s Windows 8 strategy is clearly Apple. As the dominant player in the touch tablet market, Apple may challenge Microsoft in a number of ways. Already Apple has a large number of loyal customers, and this number will continue to grow. Apple also may have a price advantage, though historically Apple’s devices have sold at a premium relative to their competition and thus far we have no pricing on consumer Windows 8 devices (we do know the MSRP of the developer preview devices, but that would not be an apples-to-apples comparison). If nothing else, there are millions of used iPads that will likely be entering the secondary market as Windows Tablets are being launched, and these may provide a “good enough” tablet for many customers who might otherwise have opted for the more versatile Windows Tablet devices.

Other market players, such as Google, may also enter the market in earnest. We’re still quite a ways out from launch, so there’s time for other disruptors to jump in.

Longer term, it’s possible that Windows’ use of HTML and JavaScript may backfire, in that many Windows developers may learn these skills to build Windows Apps, but later move to other possibly non-Microsoft platforms that also make use of these languages, and which may offer greater reach.

Finally, with HTML/JS Apps, it’s possible to easily reference web resources, including things such as advertising scripts. As Google remains the largest advertising player in this space, it’s possible that many free Windows Apps will leverage Google for their advertising, providing Google with a potentially huge revenue stream and even greater access beyond the browser to Windows users. Microsoft would be wise to offer an App advertising model that keeps many developers using Microsoft’s advertising tools and keeps that revenue for itself, rather than Google.

## Questions and Answers

Q: Where should I go to learn more?\
A: The two best resources today are the [BUILD sessions](http://channel9.msdn.com/Events/BUILD/BUILD2011) and the [Building Windows 8 Blog](http://blogs.msdn.com/b/b8). There are other blogger and industry resources listed below, too.

Q: Where can I download Visual Studio 11 Developer Preview?\
A: [http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=27543](http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=27543 "http\://www.microsoft.com/download/en/details.aspx?displaylang=en&id=27543")

Q: Can I download a preview of the full VS11 Ultimate?\
A: Yes, if you have an [MSDN subscription](https://msdn.microsoft.com/en-us/subscriptions/securedownloads/default.aspx).

Q: Can I download the source code to the sample Metro style Apps shown at BUILD and installed on the developer tablet?\
A: Yes, here: [http://code.msdn.microsoft.com/Windows-Developer-Preview-6b53adbb](http://code.msdn.microsoft.com/Windows-Developer-Preview-6b53adbb "http\://code.msdn.microsoft.com/Windows-Developer-Preview-6b53adbb")

Q: What about the hands-on labs and virtual machines that were available during BUILD? Can I get those, too?\
A: Yes, even those. Here are the [VS11 ALM Virtual Machine and Hands-On-Labs instructions](http://blogs.msdn.com/b/briankel/archive/2011/09/16/visual-studio-11-application-lifecycle-management-virtual-machine-and-hands-on-labs-demo-scripts.aspx). (these relate to VS11, but not so much to Windows 8, WinRT, and Metro style Apps)

Q: What is WinRT?\
A: WinRT is a set of APIs that are used to build Metro style Apps. WinRT is strictly for building Metro style Apps in Windows 8 – you can’t build traditional Windows applications with WinRT, or server-side applications.

Q: When I work with WinRT from C#/VB, is there a CLR involved?\
A: Yes, the CLR is loaded just as with a standard .NET application.

Q: What if I’m using C++ or JavaScript – is the CLR involved then?\
A: No, these languages run in their own runtime environments.

Q: If I’m building an App using C#, can I only use WinRT libraries, or can I still use the .NET Framework libraries?\
A: You can use the new WinRT libraries, as well as a subset of the .NET Framework APIs. The exact set of things that exist in one or the other isn’t determine yet. In cases where you could do the same thing in either WinRT or .NET, the .NET approach is typically removed so there is a consistent interface. Also .NET APIs that block, as opposed to those that can be accessed asynchronously, will typically be removed and replaced with WinRT APIs. In terms of how this is exposed, it’s done via a profile in Visual Studio, similar to how Silverlight and Windows Phone as well as Windows Client profiles allow access to only portions of the framework today.

Q: If I’m building my App with (C++/C#/JavaScript), will my API calls look like standard functions in my language and with my object types, or will they use a different standard?\
A: The WinRT APIs have projections for C++_, JavaScript, and .NET. Each one is designed to make working with WinRT from that language consistent with the language’s type system, capitalization standards, etc. [Learn more about how this works here](http://tirania.org/blog/archive/2011/Sep-15.html).

## Resources

[WinRT and the Paradox of Choice](/winrt-and-the-paradox-of-choice) (my follow up to this analysis)

Former Microsoft employee [Doug Seven clarifies the Windows 8 Marketecture Diagram](http://dougseven.com/2011/09/15/a-bad-picture-is-worth-a-thousand-long-discussions)

Microsoft Watcher Mary-Jo Foley [further analyzes Microsoft’s Windows 8 architecture slide](http://www.zdnet.com/blog/microsoft/heres-the-one-microsoft-windows-8-slide-that-everyone-wants-to-redo/10736)

Microsoft RD Andrew Brust describes his reaction to the BUILD announcements in [A Tale of Two Windows](http://www.brustblog.com/archive/2011/09/16/a-tale-of-two-windows.aspx)

Microsoft RD [Rocky Lhotka describes how WinRT relates to .NET](http://www.lhotka.net/weblog/WinRTAndNET.aspx)

Microsoft RD [Scott Cate describes Metro](http://scottcate.nextslide.com/scott-cate-describes-metro) (4:13 minute video)

Microsoft RD [Vinod Unny’s take on the Windows 8 Dev Stack](http://vinodunny.com/blog/post/Windows-8-Dev-Stacke28093My-take-on-it.aspx)

Microsoft RD [Dan Wahlin explains Why He’s Excited About Windows 8](http://weblogs.asp.net/dwahlin/archive/2011/09/17/why-i-m-excited-about-windows-8.aspx)

Mono Founder [Miguel de Icaza Demystifies WinRT](http://tirania.org/blog/archive/2011/Sep-15.html)

Microsoft RD [Stephen Forte Describes His First Day Using the Windows 8 Developer Tablet as his only computer](http://www.stephenforte.net/PermaLink,guid,94d1645b-ceeb-4402-9daf-4f8dce249026.aspx)