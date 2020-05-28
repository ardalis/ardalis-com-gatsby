---
templateKey: blog-post
title: Atlas Tripped Over His Own Feet
path: blog-post
date: 2008-06-02T01:58:06.346Z
description: "Through Lake Quincy Media, we work with a variety of ad management
  platforms used by our customers. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - advertising
  - Marketing
  - reviews
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Through [Lake Quincy Media](http://lakequincy.com/), we work with a variety of ad management platforms used by our customers. This is a story about [Atlas](http://www.atlassolutions.com/index.aspx), as told by our CEO Michelle. It is not a pleasant story, as a Microsoft customer and evangelist (Microsoft acquired Atlas a little while back), and hopefully there is enough constructive criticism in this story to qualify it as more than a simple rant. Read on…

> In our work as an advertising agency, we often find it necessary to work with other media agencies. It is always an interesting experience, because we learn a lot that we can use to improve the experience that we provide to our own customers. As with anything, there are some good agencies, and some not so good. But one of the worst, in over two years of interactions, has been Atlas.
>
> Our experience with them this week is a clear example of the issues that they bring to their customers. One of our customers, a large media company, requested that we pull some reports for them. They use Atlas to serve their ads, and required reports pulled from that system. In any case, it was a simple request, if you can access your account. Unfortunately, the password that I had was not working, and the password hint (which only confirmed that the password that I was using was the correct one) wasn’t helpful. There is no way to request a simple password reset.
>
> My first email explained the situation and requested that they reset the password, which seemed a reasonable request. I provided our logon information, which we have used for over two years. The response that I got was a new account and logon. Not overly helpful, since I needed data that was tied to the first account and the information was not transferred. When I explained that fact, I was asked for the following information: Publisher Name, Agency, Client Number, Advertiser’s Name, and Media Plan or number. Not “one of the following” – ALL of that information. Alternatively, they needed the original [RFP](http://en.wikipedia.org/wiki/Request_for_Proposal) (of which we have dozens on this account). Frustrated, I called customer service.
>
> My original phone call to customer service left me on hold for 2 minutes and 38 seconds before informing me that all operators were busy and that I could leave a message. Which I did. I followed up again, hoping for better results, a little while later. The conversation went something like this:
>
> **Me**: Hello, my name is Michelle Smith, and I am a Publisher within the Atlas system. I am having a problem with my password and I have been trying to resolve this for the last two days via email.
>
> **Customer Service Rep**: Uh-huh. (Long pause.)
>
> **Me**: Well… Do you think perhaps you could connect me with someone who could help me with that. (Another long pause.)
>
> **Customer Service Rep**: Um, I guess I can connect you to someone back in the Publisher’s department. Let me see if anyone is back there.
>
> Unfortunately, when I was connected to someone “back there”, the resolution was painful. The person that I was connected to was the same person I had been emailing back and forth with (do they really only have one guy?), and he still needed the same information. Worse yet, even with the information (and reading off several long Media Plan numbers), he couldn’t find the account. He couldn’t find the account with our publisher name. He couldn’t search by agency name (“yeah, there have been some problems with this agency”). Searching by logon was definitely out – they apparently have no capability to do that at all??!!! I finally suggested that perhaps he could use my email account? (Information which he has had for two days.) “Uh, yeah, I guess I might be able to do that.”
>
> Fortunately the situation was resolved. But I suspect that I am not alone in thinking that two days, multiple emails, and two phone calls (where I made most of the suggestions as to how to resolve the problem) are a bit much for a simple password reset.
>
> Atlas is a painful solution. Its reports take unreasonably long to run, with multiple page updates required to reset several required parameters for even the simplest of reports. Customer support is, well, less than supportive. For one of the biggest solutions out there, they need to do better. Or maybe that is part of the problem – they are the biggest solution and therefore don’t care about the commitment that they should have to their customers?
>
> One of the functions of our ad network, Lake Quincy Media, is ad serving and reporting. We have over 100 publisher sites, and a large number of advertisers, so that isn’t a trivial task. We looked at Atlas and some of the other big solutions to replace our aging ad server a couple of years ago, and realized quickly that it lacked the functionality that we want to provide to our customers. So, we wrote our own custom solution, [AdSignia](http://lakequincy.com/AdSignia). And while I think that the system itself is technically better, I realized today that the customer service function is the critical piece. We may not always get it right, but shouldn’t we expect that all companies at least make the effort?

As a follow up to provide some actual data, I asked Michelle how many clicks it took to get to a campaign report in Atlas from their home page (assuming you’re not logged in) compared to our system to do the same thing. To get an activity report for the month, it took 19 clicks and 2 minutes and 10 seconds from the Atlas log in screen. In AdSignia, she was able to view a campaign activity report (with comparable data) in 3 clicks and 30 seconds. Now, I’ll be the first to say that our software is not fast enough. In fact, as someone who speaks about ASP.NET application performance, I’m embarrassed at how slow our system is compared to what I think it should be. But compared to some other solutions out there (and, last time I used it, DoubleClick’s DART solution wasn’t much better) it compares pretty favorably.

**Advice for Atlas**

**Don’t require so many logins.** Go to their login page and you don’t get a familiar login dialog, you get [this](http://www.atlassolutions.com/clientlogin.aspx). And while we’re talking about logins, since you’re part of Microsoft now, how about you simplify things and just use Live ID?

**Let users reset their passwords themselves.** It appears you’re using ASP.NET, so you might check out the built-in Membership support that shipped back in 2005 that handles all of this easily.

**Let users merge their accounts.** This is challenging, I know from our own system. However, it’s frequently the case that customers will get multiple usernames or accounts when they really could all be combined. Make this possible, then make it easy. I think we now have 3 accounts…

**Show today’s data in reports**. Users want instant information. They also want as close of delivery as possible for advertising impressions. Having access only to yesterday’s stale data is less than ideal for managing campaigns to meet customer needs. Our own system updates every 6 hours. Realtime is the goal we’re striving toward; we’re not quite there yet, but we’re not satisfied and neither should you be.

**Strive for 24/7 uptime**. Being down for most of every Sunday (and sometimes Monday) is lame. You can do better. It’s very frustrating when customer’s have questions or deadlines and the information we need is locked in Atlas and Atlas is down for maintenance. And not for an hour – oh no – for a DAY.

**Allow bookmarking of reports**. We do. Would reduce the number of clicks to get a campaign activity report to 1, instead of your current NINETEEN.

Any other Atlas users out there have some suggestions? Or how about a testimonial about how great their system is? I’m not out to bash them so much as call attention to some areas that could use real improvement that would greatly reduce the frustration of their customers. I’m happy to [give praise](http://aspadvice.com/blogs/ssmith/archive/2008/06/01/Customer-Service-Is-Key.aspx) when [it’s been earned](http://aspadvice.com/blogs/ssmith/archive/2008/03/21/Gotta-Love-Orcsweb.aspx) – in this case I’ll hold off on that until I see some serious improvements in their system and service.

<!--EndFragment-->