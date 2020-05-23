---
templateKey: blog-post
title: Domain-Driven Design with ASP.NET Core Workshop
date: 2019-11-27
path: /domain-driven-design-with-asp-net-core-workshop
featuredpost: false
featuredimage: /img/domain-driven-design-aspnet-core-workshop.png
tags:
  - asp.net
  - asp.net core
  - asp.net mvc
  - clean architecture
  - conference
  - ddd
  - domain driven design
  - domain events
  - repository
  - session
  - speaking
  - specification
  - workshop
category:
  - Software Development
comments: true
share: true
---

I first learned about Domain-Driven Design, or DDD, over ten years ago. Since then, I've given more workshops on the topic, both public and private on sites, than I can remember. Julie Lerman and I also published a very popular course, [DDD Fundamentals, on Pluralsight](https://www.pluralsight.com/courses/domain-driven-design-fundamentals), which I expect we will refresh in the coming year. _(By the way, there's a 40% off sale for Black Friday going on now (as I write this in Nov 2019) - if you're not a Pluralsight subscriber, now might be a great time to pick up a subscription)._

My most recent experience with this workshop was last week at [DevIntersection](https://devintersection.com/#!/?track=dev) in Las Vegas, and it was one of the best yet, so I thought I'd share some of the experience here this week.

When I first put this workshop together, ASP.NET Core was still very new. In fact, it hadn't even been released yet. But many developers knew that this was the future direction of Microsoft and the .NET team, so they wanted to jump into it early. Things were sometimes a little rough in the early days, when the only tools that might work were preview builds of Visual Studio, and as a result I planned on spending at least half a day on introducing .NET Core, ASP.NET Core, and getting the SDKs and tools installed. Things have changed a bit in the last few years, though.

Last week, I started the workshop asking how many in attendance were already using .NET Core at work. Virtually every person in the full room, a little over 40 in all, raised a hand. I no longer need to spend hours explaining how ASP.NET Core differs from its predecessor, nor do I need to worry overmuch about developers having the right tools. I do still spend a little time mostly covering how ASP.NET Core apps start up, because much of this is hidden from developers in the default templates these days, and I think it's useful to have a firm understanding of these bits. The very start of the day is also spent briefly ensuring that all students can complete "lab 0" which simply ensures they have all the necessary bits to complete the rest of the hands-on labs. I conduct these public workshops with as many as 80 students so I need to be sure my hands-on labs are streamlined. Having a lab 0 ahead of time helps tremendously.

Once I know everyone has a baseline understanding of ASP.NET Core, we dive into DDD topics, interspersed with hands-on labs. In a typical past 2-day workshop, I've had students get through 4 or 5 of the labs. Each lab takes 30-60 minutes depending on a variety of factors, and most of them focus on DDD design patterns. This particular workshop doesn't focus as much on non-coding aspects of DDD, though of course these are also important. The labs demonstrate how to work with DDD design patterns like Entities, Aggregates, Repositories and persistence, Domain Events, and Specifications. They also show how to write functional tests for ASP.NET Core applications and how to refactor repetitive logic from controllers into filters.

Another topic I spend time on early in the workshop is [clean architecture](https://github.com/ardalis/CleanArchitecture), which ties in closely with DDD and ASP.NET Core. Many of the benefits of DDD and ASP.NET Core are only realized when a loosely-coupled approach to building applications is taken. Clean architecture is a way of structuring your solution and code so that it remains loosely-coupled and your most important logic remains free of dependencies and easy to [unit test](https://ardalis.com/unit-test-or-integration-test-and-why-you-should-care). I actually did a regular DevIntersection conference session on Clean Architecture with ASP.NET Core, too, which was standing room only. It's a very important topic that I'm happy to share as widely as possible.

Because most of the developers were already up to speed on ASP.NET Core and many were well-versed in writing tests as well, I was able to cover more ground in this workshop. That's why I think it was one of the best yet, because the labs worked well (with one minor glitch), we had some great conversations and questions, and we covered more ground than any class before. In addition to the labs described above, we also learned how to incorporate MediatR (which [I wrote about last week](https://ardalis.com/moving-from-controllers-and-actions-to-endpoints-with-mediatr)) into the solution to see how it could help improve the design of our MVC application.

## Student Feedback

I asked students to provide feedback toward the end of day 2. About 14 did so. Here's what they had to say:

![](/img/image-domain.png)

General feedback

**What did you like best?**

- "I like the pattern demonstration. I find learning about the patterns to be the most useful part"
- "**The explanations of the various concepts were clear, and each one built on the last.**"
- "The lectures, explanations, and fielding of questions"
- "I really like the specification pattern. I think that could save us a fair amount of code like getting rid of a bunch of where methods."
- "Project structure Is Real clean"
- "The things that are reviewed \[are\] like a large collection of best-practice implementations. They are all mutually-supportive and build on Clean Architecture, but for the most part don't require an "all-in" approach which means we can wade in with our existing code-base."
- "Labs"
- "Q&A"
- "Labs reinforced presented material; **really good follow-on to online classes that only gave an introduction to the concepts**"
- "I am the software engineering manager here with my solutions architect and **even though I have not coded regularly for a few years since management I was still able to easily follow along with the concepts**."
- "**Detailed examples of how to implement DDD in brownstone and greenfield projects** without going all out and implementing Event Sourcing systems like queues."
- "Steve is an excellent speaker with a clear voice and obvious knowledge depth with the subject matter. I loved having the lab worksheets in advance so I could better formulate my questions and address any tactical issues ahead of time without slowing down the pace of the training. **For me, the content was timely and relevant, giving me some new options to take back to my team for our current project.**"
- "Nice explanation of concept with example"

**What could have been better?**

- "nothing"
- "I think having the ef migrations test as a prereq so that I could make sure it's working before the workshop. Sounds like the docker container idea might make that obsolete though too."
- "The labs didn't really add much - it was basically glorified copy and pasting and took time from the learning portions"
- "While I realize that Git has all of the tags available and you can "easily" switch back and forth between them, I think it would have been less of an issue to overcome obstacles if ALL of the labels were created as a different folder, and provided as a zip download. I was frustrated by having to re-download code every time I hit a hurdle. Also, I think it would be useful to include the full implementation of the BaseEntity where its id is of type T. You talked about how to do this, but when I attempted to do it, I hit a roadblock. I don't recall exactly what the roadblock was, but if you like, I can probably figure out how to recreate."
- "DDD approach More non Vendor for architects attendees"
- "I expected more in-depth theory on Clean Architecture. I think there was more in the session I saw last fall than in the workshop."
- "Remove some of the outdated references in the lab book (pre-.NET Core 3 and EF Core 3 notes and/or limitations)"
- "I'm hard-pressed to give one. I'm new to this area so all of the presentation was helpful."
- "Free month of [Devbetter](https://devbetter.com/) coaching ;)"
- "Hit list page that includes links to examples of what was discussed. Not necessarily the trainers content but what was brought up during discussions."
- "Omg! Power outlets for hands-on labs! This shouldn't even be an issue."
- "Breaks after 1 hour or so"

I'm being pretty transparent here showing both the good and the bad. Some things are out of my control, like availability of power outlets (the venue charges a crazy amount to run them to the tables, but you can charge at the walls as needed). I don't spend as much time on Clean Architecture theory in the workshop as I do in the session because you're getting to actually use it (as opposed to the session where you only see it), and because I figured some workshop attendees might attend the session as well. And the labs were recently updated to ASP.NET 3.0 but there were still some references to older versions that I've noted for next time. As for the "glorified copy paste", the labs do include the code you would need to complete most of them at the end of each lab, but students are of course encouraged to try and work through the labs themselves rather than just typing or copying the code in from the solutions.

I also asked "**What set this workshop apart from other learning opportunities (books, online courses, blogs, etc)?**" Here are a selection of those answers:

- "**I have gone through several Pluralsight courses and read several books on DDD and the path I needed to follow for our project was not fully clear until after this class.** Partly because of the lack of available DDD content using ASP.NET Core 3.x / EF 3.x. The CleanArchitecture framework Steve provided was a big help."
- "It forces me to ignore the other distractions"
- "The real-time question-and-answer feedback loop"
- "2-Days was long enough to mentally get comfortable with some of the changes."
- "It's the spontaneous, interactive nature that sets it apart as well as the fact that the content is kept as up-to-date as possible"
- "My team does a lot of reading, pluralsight etc... and to see the hands on practical use of DDD in Core really solidified the concepts that were not as clear via the other learning mediums."
- "hands on labs are definately cool. the git branches for each lab was also cool."
- "Decent dedicated time with good hands on"

Some good stuff there - thanks to those of you who took the time to provide me with your feedback! This was my favorite comment:

"Great opportunity to see the DDD applied in the newest Core. Lecture did not drone and was very easy to follow. Also, Julie Lerman is a rockstar so by proxy you are too. :)"

LOL. Julie and I got a laugh out of that.

## Upcoming Workshops

I'm booking private on-site workshops covering these and other topics (testing, SOLID, refactoring, code quality, migrating legacy code, etc.) into the next several months. Usually we follow up the workshop with remote mentoring to help cement new concepts with the team and provide an opportunity for teams to ask specific questions about how to apply concepts to their company's code.

Publicly, I'm going to be offering my DDD with ASP.NET Core workshop next at [NDC London, 27-28 January 2020](https://ndc-london.com/workshop/building-domain-driven-applications-with-asp-net-core/). Tickets are still available so if you're interested I hope to see you there. I'll most likely be offering it at DevIntersection's spring show in Orlando as well (approximately April 7-9 2020).

## More references

[Another write-up I did of a 4-day workshop a year ago](https://ardalis.com/clean-architecture-with-aspnet-core)  
[DDD Fundamentals on Pluralsight  
](https://www.pluralsight.com/courses/domain-driven-design-fundamentals)[SOLID Principles for C# Developers on Pluralsight  
](https://www.pluralsight.com/courses/csharp-solid-principles)[Clean Architecture on Fritz and Friends Stream (July 2018) via YouTube](https://www.youtube.com/watch?v=k8cZUW4MS3I)  
[Creating a Clean Architecture Worker Service Template](https://www.youtube.com/watch?v=_jfnnAMNb94) (stream - YouTube)
