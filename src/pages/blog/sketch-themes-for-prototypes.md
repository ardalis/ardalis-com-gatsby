---
templateKey: blog-post
title: Sketch Themes for Prototypes
date: 2019-10-30
path: /sketch-themes-for-prototypes
featuredpost: false
featuredimage: /img/image-7-715x360.png
tags:
  - demo
  - mvp
  - prototyping
  - spike
  - wireframes
category:
  - Software Development
comments: true
share: true
---

Last week during one of my [devBetter coaching sessions](https://devbetter.com/), the conversation turned to spikes and Minimum Viable Products (and even not-so-viable products). Sometimes, in order to get rapid feedback, it's useful to throw together a prototype that has literally nothing going on in the backend, but lets the user get a sense of how the application would flow. The problem, of course, is that once users see such a thing, they can't always tell the difference between smoke and mirrors and the real thing. Thus, it's useful to provide them with visual cues indicating that the thing they're working with isn't really a finished product, but just a draft.

Tools like [Balsamiq](https://balsamiq.com/wireframes/) are great for actually sketching mock-ups of screens for web and mobile apps, but if you're actually prototyping a real app, perhaps using some code generation, you need different tools. That's where something like [Sketchy](https://bootswatch.com/sketchy/) comes in. It's a Bootswatch theme that can be applied to any web app that uses Bootstrap, which is quite a large number especially in the ASP.NET world where the default app templates have included Bootstrap for years.

Here's a sample of what the [eShopOnWeb](https://github.com/dotnet-architecture/eShopOnWeb) reference app's login screen looks like after applying Sketchy:

![](/img/image-6-1024x621.png)

Sketchy eShopOnWeb Login Screen

For this particular application, it doesn't handle \*everything\* - for instance the logo text isn't affected since it's an image - but it does help, and seeing it consistently applied throughout the application could help inform users that this is an unfinished product. I'm only using this application to demonstrate how easy it was to add the Sketchy theme to an existing application.

All I had to do was download the bootstrap.css file and copy it into the site's /lib/bootstrap/dist/css folder (replacing the existing file). That was literally all that was required. I was going to do a step-by-step article showing how to do it, but this paragraph is it. :)

Of course you can see more of what the various Bootstrap UI elements look like with Sketchy by going to the [Bootswatch theme site](https://bootswatch.com/sketchy/). Here's another quick sample to save you from having to tap/click:

![](/img/image-7-sketch.png)

The Sketchy Bootswatch Theme

Thanks to devBetter member [Joe LaRue](https://twitter.com/JLaRueBoston) for this tip, which I'm now sharing with you. If you found it helpful, consider sharing it with others as well (and let Joe know - he'll appreciate it!).
