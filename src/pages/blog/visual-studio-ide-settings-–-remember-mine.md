---
templateKey: blog-post
title: Visual Studio IDE Settings – Remember Mine!
path: blog-post
date: 2004-04-02T12:56:00.000Z
description: "[TimSull] writes about a new feature coming in Whidbey/VS2K5 that
  will [allow developers to export and import their Visual Studio customization
  settings to and from files]. This is a feature I’ve had an interest in for
  some time, but I want to take it a step further."
featuredpost: false
featuredimage: /img/vscode-760x360.png
tags:
  - Visual Studio IDE settings
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

[TimSull](http://blogs.msdn.com/timsull) writes about a new feature coming in Whidbey/VS2K5 that will [allow developers to export and import their Visual Studio customization settings to and from files](http://blogs.msdn.com/timsull/archive/2004/04/01/105959.aspx). This is a feature I’ve had an interest in for some time, but I want to take it a step further. I’ve mentioned this on several occasions to members of the VS.NET team, but I don’t think they’re going for it, so please comment on this post if you think my idea makes sense (or not – just be heard).

Basically, the solution they’re coming up with is good. It will let you save and retrieve settings from the file system. Great. Fine. I like it. However, I work remotely quite a bit as a consultant. I’m lucky enough to own a laptop now, but I remember in years past when that wasn’t the case, and what a hassle it was to try and configure environments at different clients. Or at training classes. I suppose with these new USB drives this isn’t such an issue – I \*could\* just carry around my VSSettings file with me on my keychain. But I think there’s a better way (and that wouldn’t allow me to take advantage of the auto-synching feature TimSull described). See, there’s this other place to store stuff where it’s almost universally available. That’s right, I’m talking about the Internet.

First off, I would want to see the import settings wizard modified so that it would accept a URL as a viable location for a VSSettings file. Secondly, I’d like the auto-synch feature to support URL-based settings files, by using a hash of the file and checking to see if the hash changes rather than a timestamp (at least, that’s how I would do it — I’ll leave the implementation up to the experts, though. I just want it to work). This would be a big step in the right direction.

But wait, not everybody has a website (or a USB keychain drive) – what about these sad souls? Well, let me get back to that in just a moment. First I’d like to talk about how great it is that so many members of the Microsoft dev teams are soliciting feedback from the developer community on various VS features. I mean that sincerely. They’re curious what resolution we use. They’re wondering what default settings we prefer. They have a lot of very good questions, and answering these questions is to our (developers’) benefit since hopefully it will mean better tools in our future. What if they could get this information, and much more, in an automated fashion from at least tens of thousands of developers, instead of the dozens who respond to blog posts? Wouldn’t that dramatically improve the accuracy of their perception of what we developers want and how we work with Visual Studio? What if Microsoft offered a built-in feature of VS.NET that allowed developers to store their custom settings (buttons, fonts, which menu shows up where — we’re not talking about your medical history or credit card number here) on the Internet, in a Microsoft-controlled datastore? And of course, you could retrieve your personal settings file from this repository from anywhere on the Internet as well. This would solve the problem of what to do about people without websites or USB drives. It would also provide MS developers with a TON more valuable information than they could hope to get from straw polls on blogs about user preferences.

The argument I’ve heard against this is “privacy fears”. What is so private about my development environment? And even if I’m eccentric enough to think that my personal settings are not something I want strangers to aggregate and learn from, I don’t \*have\* to use the service. Put in a nice disclaimer explaining how (or if — the data analysis could be done on an opt-in or opt-out basis, rather than for all users of the service) the data analysis is done and require the user to agree to it before they can sign up for the service (which would ideally work via passport). Voila! Several birds, one stone. And really how expensive can it be to host a bunch of VSSettings files? Do you know how many of those will fit on a couple of 160GB drives? The information value would far outweigh the hosting and admin costs of the service.

So, again, if you agree with me, please comment. If not, please comment and say why. I’d love to see this feature added to VS2K5 (or, I suppose, a later release), and I don’t see any viable reason why it shouldn’t be.

<!--EndFragment-->