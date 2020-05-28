---
templateKey: blog-post
title: DevConnections Afterthoughts and Presentations
path: blog-post
date: 2007-11-10T11:59:56.763Z
description: I got back from DevConnections yesterday at 7am (took the redeye
  flight), after being gone since Saturday.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ajax
  - asp.net
  - conference
  - devconnections
  - speaking
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I got back from [DevConnections](http://aspadvice.com/blogs/devconnections) yesterday at 7am (took the redeye flight), after being gone since Saturday. I’m glad to be home, and I know it will be a few days before I’m even close to caught up on everything that fell behind while I was in Vegas. The show was great, though, and this is sort of my summary of the last week.

I flew in early for DevExpress’s TechSummit, which included about 20 other guests and about a dozen members of the DevExpress team. It was great to get to spend some time with these guys, many of whom I’d met before (like~~Devin~~[Dustin](http://diditwith.net/) and [Mark](http://www.doitwith.net/)) and a few whom I hadn’t (like [Oliver](http://www.sturmnet.org/blog)). I [already blogged about this](http://aspadvice.com/blogs/ssmith/archive/2007/11/04/DevExpress-TechSummit.aspx), so I’ll avoid repeating myself here, but it was a fun weekend and a great opportunity for me to learn more about their offerings and answer some questions I had about their products.

Monday [Brendan](http://aspadvice.com/blogs/name) flew in for DevConnections. This was his first conference and I think he enjoyed it and learned a lot from the sessions and networking opportunities, which I suspect he’ll blog about when he has the chance. The day ended with the standard “where the heck are we going” keynote from Microsoft which promised to finally bring together all of my disparate data and applications and let my users builds their own applications with their own personal orbital lasers while making me financially independent because I was clever enough to enhance my productivity with the latest MS tools. Or something like that. Afterward, the expo hall was much larger and more diverse than in previous DevConnections shows. I became one of the first of many during the course of the show to lose to Sarah (hired model) at the [DevExpress](http://devexpress.com/) booth in a coding competition – with her using [CodeRush](http://www.devexpress.com/Products/NET/IDETools/CodeRush) and me not. She beat me typing with only two pencils (no fingers), but I was only about 5 seconds behind her. By Tuesday she’d gotten this down to a science and was beating people in both VB and C# before they could even finish the app in one language. It was a great way to show off the productivity of CodeRush, and far more eye-pleasing than watching Mark Miller do it… She beat Brendan pretty handily Tuesday, which I’ll post a video of when I get a chance.

Tuesday, [Scott Guthrie](http://weblogs.asp.net/scottgu) gave the Developer keynote, after which I spent most of my time networking with other speakers and exhibitors. I also participated in Microsoft Unplugged Tuesday evening, hosted by Doug Seven. During this event, 42+ members of the audience (we started with 42 but too many were eliminated so we added a bunch more) competed in a trivia game for prizes, with 5 contestants getting Zunes and many others getting t-shirts and coffee mugs and such. I did a quick demo of the ListView control for the event, demonstrating the correctness of a question on this new control that I’d submitted to Doug for this event. My demo was based pretty much entirely on [ScottGu’s great walkthrough, so check that out if you want to see more on the ListView](http://weblogs.asp.net/scottgu/archive/2007/08/10/the-asp-listview-control-part-1-building-a-product-listing-page-with-clean-css-ui.aspx). After the event, we had dinner at StripSteak, which was excellent (Thanks, Doug!).

Wednesday I gave two of my talks. The first one was on the AJAX Control Toolkit, which was very popular (standing room only). Unfortunately, it was in one of the smaller halls, while my next talk, on ASP.NET Membership (a bit old hat, methinks), was in a massive hall with seating for at least a thousand (half the room that was used for the keynotes). It would have been better if these two rooms had been switched, and apparently this was a common issue since many attendees agreed it was a problem when the issue was raised during the post-conference panel.

The AJAX Control Toolkit talk spends about 5 minutes discussing AJAX and describing the difference between Controls and Extenders, then spends about an hour walking through the toolkit’s controls, demonstrating how they work, and answering audience questions. The last 10 minutes are spent showing how to do a very simple extender control for the toolkit, which unfortunately does not ship with any very simple “hello world” implementations to use as a base when learning. In my presentation download, I include the source for my simple toolkit control, the ClickLabelExtender.

The ASP.NET Membership talk just goes over Membership, Profile, and Role Manager along with the ASP.NET controls that use these features (including SiteMapProvider). This talk was one of my “backup” talks and was meant to provide the conference with some non-bleeding edge content, but in hindsight given its relatively poor attendance and the fact that an audience poll showed that most of the attendees were already using these features leads me to conclude that it wasn’t a great choice. Unfortunately, the show didn’t let me talk about performance or caching this time around.

Wednesday night I enjoyed a speaker cocktail party, followed by dinner with the [StrangeLoop](http://www.strangeloopnetworks.com/) team, which was again excellent (Vegas, if nothing else, has some very fine restaurants). These guys have a really slick “just plug it in and it works” product that can drastically increase the performance of most ASP.NET applications, and were voted one of the Best of TechEd 2007 before they even had a product release. [Kent and Richard](http://www.strangeloopnetworks.com/about/management) gave nearly continuous demonstrations of the product during the show’s expo hours, where many attendees showed great interest in StrangeLoop’s product.

Thursday I gave my last talk, which was one of the show’s final sessions, on TDD and CI for ASP.NET with VSTS. This talk is based on my own personal experience with these techniques, and focuses on pre-2008 release tools and applications. The demos show off the [Plasma](http://codeplex.com/plasma) project, which can be an effective way to test ASP.NET pages quickly, but which I expect will be eclipsed soon by the MVC framework the ASP.NET team is working on. This session was well-attended, thought not packed like the toolkit one the day before in the same room. I think it went pretty well and feedback from those who stayed after was all pretty positive. One question I got was whether CI is worthwhile for a one- or two-developer team, and I think it is. If nothing else, the build server with tests will ensure that if the developer(s) get busy or lazy or both and don’t always run their tests, the build server won’t forget to do so and will act as a safety net, catching any bugs that creep in.

After the show, I participated in the closing panel for the developer-oriented conferences (the total show was a combination of 10 conferences). The attendees asked fewer technical questions than usual (probably a good thing) and had a lot of praise for the show as well as a lot of feedback and suggestions. One suggestion that I think will likely happen at some point in the future is recording of sessions (audio only or audio/video), since many attendees agreed they had had to miss sessions that interested them in order to go to another held at the same time. Another good suggestion that would ease the problem with the room sizes was to incent attendees to tell the conference planners which sessions they were planning to attend, so the more popular sessions could be moved to the larger rooms. Another question centered on how speakers for the conference(s) are chosen, and [Brendan](http://aspadvice.com/blogs/name) (afterward) suggested that perhaps

DevConnections could hold a [Speaker Idol event like the one TechEd](http://www.mseventseurope.com/teched/07/Developers/Content/Pages/SpeakerIdol.aspx) has been hosting in recent years.

Overall, it was a great conference. Everyone I talked to, both attendees and exhibitors, was happy with the turnout and content. For anyone interested in my slides and demos, I’ve provided them to the conference coordinators (e.g. they should be on the conference website) as well as linked to them below:

[AJAX Control Toolkit Presentation – DevConnections 2007](http://aspalliance.info/samples/AJAXControlToolkitOverview_DevConnectionsFall2007.zip)

[ASP.NET Membership and Personalization Presentation – DevConnections 2007](http://aspalliance.info/samples/ASPNET_Membership_DevConnectionsFall2007.zip)

[TDD and CI with ASP.NET and VSTS – DevConnections 2007](http://aspalliance.info/samples/TDDandCI_DevConnectionsFall2007.zip)

<!--EndFragment-->