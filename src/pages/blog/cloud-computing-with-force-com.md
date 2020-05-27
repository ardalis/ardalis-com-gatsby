---
templateKey: blog-post
title: Cloud Computing with Force.com
path: blog-post
date: 2009-04-24T07:13:00.000Z
description: Lake Quincy Media uses SalesForce.com as our CRM to manage our
  leads and customers and keep our salespeople organized. Overall we’ve been
  very pleased with the solution, and we know plenty of others who swear by SF.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - CloudComputing
category:
  - Uncategorized
comments: true
share: true
---
[Lake Quincy Media](http://lakequincy.com/) uses [SalesForce.com](http://www.salesforce.com/) as our CRM to manage our leads and customers and keep our salespeople organized. Overall we’ve been very pleased with the solution, and we know plenty of others who swear by SF. So when I heard about their foray into Cloud Computing via Developer.Force.com (DFC), I figured I should check it out. Similar to [Azure](http://azure.com/), you need to register to get an account and the SDK. They also have a free white paper and tutorials. The [download](http://www.developerforce.com/events/dotnetdevs_starter/registration.php?d=70130000000EihT) looks something like this:

![](/img/cloud-com1.png)

The first PDF contains 11 tutorials that help you get started building your first app in the cloud:

![](/img/cloud-com2.png)

The second PDF is a 30 page white paper on*“Force.com: A Comprehensive Look at the World’s Premier Cloud-Computing Platform.”* Unfortunately, you have to [register](http://www.developerforce.com/events/dotnetdevs_starter/registration.php?d=70130000000EihT) to get to this file, but registration was pretty painless for me so if you want to compare Force.com to Azure to Amazon to Google it’s probably worth it. Personally, I can only compare Azure with Force.com and a tiny subset of Amazon’s offerings, as those are all that I’ve used. If you know how Google (or other Cloud competitors) compares please share in the comments. There are some pretty compelling testimonials in the white paper, such as these:

![](/img/cloud-com3.png)

Not included is a video that I also found and which you \*don’t\* need to register to watch. Check it out here: <http://wiki.developerforce.com/index.php/CloudComputingForDotNet> It’s pretty high-level, showing the general concepts and architecture, not actual coding.

Registration with DFC results in a couple of emails containing account information as well as a list of resources including forums, a wiki, ideas, and new. Pretty straightforward stuff, and no surprises. Force.com uses the Apex language for development, which similar in syntax to Java or C#. Querying data uses the Salesforce Object Query Language (SOQL) or the Salesforce Object Search Language (SOSL). The former is similar to SQL but queries objects based on their relationships, rather than a database.

**Tutorial #1: Creating an App with Point-and-Click Tools**

Starting out with point-and-click programming, eh? Sounds like they’re using the same playbook as so many teams at Microsoft… But I digress…

So, one thing that I really was impressed with right off the bat by this tutorial is that it’s not just a PDF. I mean, sure, the PDF is nice and I can print it out if I want but there is \*also\* an online version of the tutorials built into the application (see screenshot below):

![](/img/cloud-com4.png)

The tutorial runs in another window and pretty much shows you step-by-step what you need to be doing as you go through it. The steps to create the “database” (Object) for the first tutorial remind me a little of [CloudDB](http://clouddb.com/), though without the cool Ajax. Still very cool that you can do it all online, though, rather than having to run an SDK tool or write code as is currently the case with Azure.

In my experience, the performance of the app-builder could have been a little bit better. It took a couple of seconds on average for each page request, which isn’t awful but if I were building a large application this way, the number of requests and the delays for each one would start to wear on me. Fortunately, I’m pretty sure this isn’t the only way to create things.

As you build the pieces of the app, they actually appear in the infrastructure of the Force.com site you’re working within, like this:

![](/img/cloud-com5.png)

Of course the very next step allows you to replace the logo with a custom one. Ultimately, the application front end is comprised of UI elements built entirely within the browser via the app itself (for this tutorial, that is). It’s pretty slick, and especially if you’re targeting users of SalesForce.com (or other Force.com apps), the commonality of the UI would be a big plus for usability and ease of learning curve.

After completing the first tutorial, you see:

> *Summary*
>
> *Congratulations, you have just built an application—without any coding. Using the online user interface, you simply followed the steps in each wizard to create an object, fields, and a tab, and then pulled it all together into an application that lets users create mileage records to track their business trips.*

If you want to give it a whirl, [sign up here](http://www.developerforce.com/events/dotnetdevs_starter/registration.php?d=70130000000EihT). Let me know what you think. If you’ve already built real-world apps on this platform, I’d love to hear from you.