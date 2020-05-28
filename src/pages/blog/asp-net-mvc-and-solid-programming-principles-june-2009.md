---
templateKey: blog-post
title: ASP.NET MVC and SOLID Programming Principles June 2009
path: blog-post
date: 2009-06-11T00:25:00.000Z
description: This week I presented “Introducing ASP.NET MVC and SOLID
  Programming Principles” (aka SOLIDify Your ASP.NET MVC) to the Cleveland .NET
  SIG and the Ann Arbor .NET Developers group. Thanks to everyone who came, it
  was standing room only at the Microsoft office in Cleveland and a great
  turnout at the SRT Solutions office in Ann Arbor, too.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET MVC
category:
  - Uncategorized
comments: true
share: true
---
This week [I presented “Introducing ASP.NET MVC and SOLID Programming Principles” (aka SOLIDify Your ASP.NET MVC) to the Cleveland .NET SIG and the Ann Arbor .NET Developers group](https://ardalis.com/speaking-in-cleveland-and-ann-arbor-this-week). Thanks to everyone who came, it was standing room only at the Microsoft office in Cleveland and a great turnout at the SRT Solutions office in Ann Arbor, too. I thought the presentation went well and had some good discussion in both locations and I enjoyed getting to see a lot of folks I know in the area whom I hadn’t seen in a while. And the projector didn’t turn off every 5 minutes like [the last time I spoke in Ann Arbor](https://ardalis.com/speaking-in-ann-arbor-november-14th)(always bonus).

## Download

[ASP.NET MVC and SOLID Programming Principles Slides and Demos](http://ssmith-presentations.s3.amazonaws.com/ssmith_SOLIDifyASPNETMVC_June2009.zip)

The only difference between the two talks is that for Ann Arbor I put together a 2-slide example showing how one’s solution would be organized in order to not have all projects ultimately referencing the Data Access Layer (DAL). I mentioned this concept Tuesday in Cleveland but didn’t have a visual to go with it, so I threw something together for Wednesday (and eventually it will make its way into the actual presentation). In fact, here are those two slides for reference:

![](/img/mvc1.png)

![](/img/mvc11.png)

If you follow ISP and try to keep your interfaces with their consumers (typically in your business/domain model/core project) then your data access project needs to reference this project in order to implement these interfaces.