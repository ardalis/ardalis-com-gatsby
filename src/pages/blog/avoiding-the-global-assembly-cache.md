---
templateKey: blog-post
title: Avoiding the Global Assembly Cache
path: blog-post
date: 2004-03-29T13:05:00.000Z
description: "Chris Sells writes about reasons why we should avoid using the
  Global Assembly Cache, or GAC (pronounced “gack!”). I have to say that I
  definitely agree with his sentiments. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - global assembly cache
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Chris Sells writes about reasons why we should [avoid using the Global Assembly Cache](http://www.sellsbrothers.com/spout/#Avoid_the_GAC), or GAC (pronounced “gack!”). I have to say that I definitely agree with his sentiments. Ted Neward disagrees with some points [here](http://www.neward.net/ted/weblog/index.jsp?date=20040329#1080551172872). One counter-argument Ted makes against Chris’ original statement is this:

*First and foremost, I’ve never heard of the idea that the GAC is there to save hard drive space; anybody who’s ever believed that needs to take a long hard look in the mirror and slap themselves with a fish until they stop thinking that way. Chris’ 60GB hard drive is a puny beast compared to the pair of 120GB drives I dropped into my desktop machine a few months ago. You can’t write code fast enough to keep up with the growth of permanent storage these days. (OK, maybe if you’re really good with C++ templates, you might, but it’ll be a close race.) The GAC is not for space savings because there’s no need for you to save space.*

I think Ted’s missing the point, which is not so much that the **GAC** is in place to save hard drive space, but rather hard disk space was a consideration for its predecessors, and the idea of having shared libraries on the machine. Sure, there are lots of other reasons to have shared libraries for the OS, but at least one consideration when things moved from DOS “whatever is in the directory is all there is” to Windows “the registry knows where to find all the dependencies and we can share DLLs willy-nilly” was in fact disk space. I think that’s all Chris was alluding to — he wasn’t saying the GAC today provides any significant disk saving benefit (or even that others claim that it does).

Ted goes on to suggest that one of the key benefits of the GAC is its allowance for side-by-side versions of shared third-party libraries. He concludes by saying

*Chris, the GAC isn’t for making silent upgrades of libraries that apps depend on–it’s the side-by-side versioning story, first and foremost, that demands the GAC’s existence. Yes, I could go ahead and put those third-party libraries into my private application directory, but why? If I start looking to bundle everything I depend on as part of my application’s footprint, why not include certain key libraries like KERNEL32.DLL or USER32.DLL, as well?*

The answer to Ted’s question “but why?” is simple – it’s much easier to manage the individual applications if their dependent third-party libraries are distributed with it. To answer his second, pedantic, question about inicluding OS libraries with the application, I think it would be safe to say that you don’t need to include those because they’re part of the OS. That’s a pretty simple distinction in my mind — bundle everything your app requires above the OS (and for .NET, I’d say the .NET Framework as well, since it’s all but part of the OS) into your deployment package. If it needs .NET 1.1 or XP Pro, list these as system requirements and check for them at install time, but obviously don’t bundle them. I’m a big fan of ‘all things in moderation’ and I think the right place to ‘moderately’ share DLLs is if they’re part of the operating system or system level application framework (e.g. the .NET framework). Applications, third-party libraries, and user-coded dependencies all fall into the category of things that should be deployed with each application, thus ensuring optimum chances of xcopy deployment working and also reducing the odds of breaking things by updating shared libraries.

<!--EndFragment-->