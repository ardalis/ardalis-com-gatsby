---
templateKey: blog-post
title: DogFoodCon Session on DDD with ASP.NET MVC
path: blog-post
date: 2014-09-30T14:40:00.000Z
description: "Yesterday I presented at DogFoodCon, giving a slightly modified
  version of a talk I gave a week earlier atFalafelCON in San Francisco.  "
featuredpost: false
featuredimage: /img/dogfood-logo-324x901.png
tags:
  - ddd
  - mvc
category:
  - Software Development
comments: true
share: true
---
Yesterday I presented at[DogFoodCon](http://www.dogfoodcon.com/), giving a slightly modified version of a talk I gave a week earlier at[FalafelCON](https://falafel.com/falafel-con-2014)in San Francisco. The session provides those with little knowledge of Domain-Driven Design with a rapid overview of some key concepts and patterns used in DDD, and wraps up with a brief demo of a simple Guestbook application that begins as a monolithic everything-in-the-controller MVC application but is improved using some DDD-based techniques. The slides are [available on Slideshare](https://www.slideshare.net/ardalis/add-some-ddd-to-your-aspnet-mvc-ok) and embedded here:

<iframe width="427" height="356" src="https://www.slideshare.net/slideshow/embed_code/39700232" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" allowfullscreen="" style="margin-bottom: 5px; max-width: 100%; border: #ccc 1px solid;"> </iframe>

**[Add Some DDD to Your ASP.NET MVC, OK?](https://www.slideshare.net/ardalis/add-some-ddd-to-your-aspnet-mvc-ok "Add Some DDD to Your ASP.NET MVC, OK?")** from **[Steven Smith](https://www.slideshare.net/ardalis)**

Both times I gave the talk, I ran out of time to show everything I wanted in the demo (sorry, it’s a big topic). One key area that I mention that you may want to follow up on is how to break the dependency between the UI/Web project and the Infrastructure project so that at compile time there are no direct references to implementation details in the UI layer. I recently covered [how to use types from an assembly without referencing it](http://blog.falafel.com/use-types-from-project-without-referencing/) in another article.

Of course, if you want to learn more about DDD at a much more reasonable pace than in this 60-minute overview, I recommend checking out the [Domain-Driven Design Fundamentals](http://bit.ly/PS-DDD) course that Julie Lerman and I published with Pluralsight.

Finally, if you’d like to check out the source for the [Guestbook sample I showed, it’s available on my Bitbucket account](https://bitbucket.org/ardalis/guestbook). The latest version wires up domain events to SignalR to show toast notifications whenever certain events occur in the domain. It’s still just proof-of-concept and would work better if the main button used an AJAX call rather than posting the full browser page, but it demonstrates the idea. There’s a better, more real-world demonstration of this same technique in the demo we build in the DDD Fundamentals course.