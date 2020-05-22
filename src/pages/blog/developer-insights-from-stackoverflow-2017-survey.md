---
templateKey: blog-post
title: Developer Insights from StackOverflow 2017 Survey
path: blog-post
date: 2017-05-15T02:44:00.000Z
description: StackOverflow published the results of their 2017 Developer Survey.
  They been conducting this survey for some time now, and they obviously have
  access to a lot of data and developer demographics. 64,000 people took the
  survey, which makes it pretty accurate, statistically speaking.
featuredpost: false
featuredimage: /img/screenshot-2017-05-15-22.03.11.png
tags:
  - stackoverflow
  - survey
category:
  - Software Development
comments: true
share: true
---
![](/img/so-logo.png)

StackOverflow published the results of their [2017 Developer Survey](https://insights.stackoverflow.com/survey/2017). They been conducting this survey for some time now, and they obviously have access to a lot of data and developer demographics. 64,000 people took the survey, which makes it pretty accurate, statistically speaking.

Here are a few insights I found interesting and worth sharing.

## Exponential Growth

If you look at the section, Years Coding Professionally, you can see a year-by-year breakdown of how long respondents have been employed to write code. A figure that’s been cited for the last 10-20 years is that the software development profession has been doubling in size about every 5 years. For that to be true, that would mean that approximately half of all developers today would have no more than 5 years of experience. Consider this screenshot:

![](/img/screenshot-2017-05-15-22.03.11.png)

**The sum these is 50.1%**. Now, this can also be explained a bit as survivorship bias, rather than exponential growth. Certainly the proportion of developers with less than 5 years of experience might be explained by a lot of people with more experience leaving the industry. This survey doesn’t have data to answer this question, specifically (though it did ask those who used to program professionally but no longer do so, how long they did). But the numbers it does have seem to support at least the possibility that our industry is continuing to grow, very rapidly.

## How We Prefer to Learn

Less than half of respondents felt their formal education was “Important” or “Very Important” (41%). This is how most software developers learn(ed) the skills they use professionally:

![](/img/screenshot-2017-05-15-22.19.40.png)

Self-taught is further broken down and includes resources like official docs and technical books – it’s not like it’s done completely in a vacuum. But for those with the means, online courses are the top choice for learning to be a better developer. This doesn’t come as a huge surprise, considering the popularity of businesses like [Pluralsight](https://www.pluralsight.com/authors/steve-smith) and [DevIQ](http://app.deviq.com/), among others. If you’re looking to [learn ASP.NET Core](http://learnaspnetcore.com/), I recently published an [ASP.NET Core Quick Start course](http://aspnetcorequickstart.com/) (read a [review](https://medium.com/@ZombieCodeKill/asp-net-core-quick-start-review-b08387a4114e)).

Of course, on-the-job training is a great source, but depending on your organization you may not really be getting much better. Are you learning new things? Are you gaining new experience? If you’ve been there for a few years, do you have a few years’ worth of new experiences, or do you have one year of experience, repeated a few times? Spending time outside of work is important in order to continue to improve for *most* software developers, though some are lucky enough to work where they’re constantly learning and challenged.

### Boot Camps

It’s worth noting that software boot camps are now up to 9%. This is a growing trend as well, and I know several boot camp graduates and instructors. It can be a great way to break into this amazing industry. (Honestly, I wonder if in 10 years people will want to spend $100k+ (in future dollars, let’s say) and 4 years for a bachelor’s degree instead of a fraction of that time and money on a boot camp. But that’s a topic for another day).

So, if you didn’t already have a developer job when you started a boot camp, how likely was it that you’d get one? About 63% of respondents were able to find a job within 3 months of completing the boot camp. The results included 8.1% who hadn’t yet gotten a job, but there’s no indication of how long ago they completed a boot camp, so that throws off the numbers a bit. Limiting the results to developers who actually found jobs after starting their boot camp, the 63% figure goes up another few points. Many boot camps claim very high placement rates (over 90%), though of course some of this is achieved through some selectivity in the applicants they accept.

## More on Learning

Just to drive the point home further, SO asks a separate question on how developers recommend others learn to program. Here’s the result:

![](/img/screenshot-2017-05-15-22.38.14.png)

And again the overwhelming winner is [online courses](http://app.deviq.com/), followed by books with exercises you can work through.

## Most Popular Languages

JavaScript, of course, is the most popular language (it has been every year since the survey started 5 years ago). It makes sense since almost all web-based (and many server apps today) applications use JavaScript. Somewhere, most applications still work with a relational database, so it’s not that surprising that the other common denominator regardless of app platform or programming language is SQL. After that, Java and C# are pretty close to one another (with Java still ahead). The one to watch though is Python. This year it usurped PHP for 5th place:

![](/img/screenshot-2017-05-15-22.44.56.png)

If you look at [StackOverflow trends](https://insights.stackoverflow.com/trends?tags=python%2Cjavascript%2Cjava%2Cphp), though, you can see that Python’s trajectory is impressive:

![](/img/screenshot-2017-05-15-22.48.21.png)

## Methodologies

There is a ton of great information in the survey. I recommend reading it all from the source. One last piece I’d like to highlight is on developer methodologies. It wasn’t that long ago that agile was being scoffed at by many software development organizations. Now, it’s definitely taken over, though what “agile” means varies quite a bit between organizations. Scrum, of course, won the agile marketing war and leads the pack as the most popular “flavor” of agile (and the only one you get to pay money to claim you know).

![](/img/screenshot-2017-05-15-22.56.47.png)

The thing I don’t like about Scrum is that it doesn’t have anything to say about how the teams write code, and it conflates too many unrelated things into the same timebox of the sprint. To these points, I prefer extreme programming, which supports many developer practices that result in better quality code. Unfortunately, it was never well-marketed, so I’m impressed to see it pushing 20% in the survey. [Domain-Driven Design](http://bit.ly/PS-DDD) has done a better job, but is newer and covers more ground than XP. I expect to see DDD continue to grow and I hope it will at least surpass [Waterfall](http://deviq.com/waterfall/) soon. I have courses on [Pair Programming](https://www.pluralsight.com/courses/pair-programming) (hands-on with fellow instructor [Brendan Enrick](http://deviq.com/me/brendan-enrick/)) and [Kanban Fundamentals](https://www.pluralsight.com/courses/kanban-fundamentals), so naturally I’m happy to see them growing in use.

One thing I didn’t mention that there’s a lot of info on is salary, broken down by region, job title, experience, and programming language. If you’re interested in that sort of thing (and if you’re a professional software developer, you probably are), be sure to check out the survey [here](https://insights.stackoverflow.com/survey/2017).