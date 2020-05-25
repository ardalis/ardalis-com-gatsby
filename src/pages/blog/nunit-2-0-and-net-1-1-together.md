---
templateKey: blog-post
title: NUnit 2.0 And .NET 1.1 Together
path: blog-post
date: 2003-06-10T23:56:00.000Z
description: I spoke at the [Wisconsin .NET User Group] last night and had a
  good time. A small part of my talk was on using NUnit to do unit testing and
  an introduction to [Test Driven Development(TDD)].
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - nunit
  - testing
  - unit testing
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I spoke at the [Wisconsin .NET User Group](http://www.wi-ineta.org/) last night and had a good time. A small part of my talk was on using NUnit to do unit testing and an introduction to [Test Driven Development(TDD)](http://groups.yahoo.com/group/testdrivendevelopment). In the course of preparing my samples I upgrade to VS.NET 2003 from VS.NET 2002 and thus from .NET v1.0 to v1.1. Unfortunately, I had a heck of a time getting [NUnit](http://www.nunit.org/) to work after doing this, and was getting a security exception any time I tried to load a 1.1 compiled assembly.

There are couple of resources I was directed to related to this when I asked the community at [ASPAdvice.com](http://aspadvice.com/)for help. Rachel Reese directed me to [Robert McLaws blog on the subject](http://weblogs.asp.net/rmclaws/posts/5348.aspx), which in turn linked this [very detailed article](http://www.3leaf.com/default/articles/ea/SBS.aspx). However, because I’m dense at times I didn’t actually “get it” as far as what I had to do until James Shaw from [www.CoverYourASP.com](http://www.coveryourasp.com/) wrote to inform me of this exact process:

To get NUnit to work with 1.1 assemblies, add this to the NUnit config files in NUnit’s /bin folder (gui and console):

<!--EndFragment-->

```
<configuration>
<startup>
<supportedRuntime version=”v1.1.4322″ />
</startup>
```

<!--StartFragment-->

I did that, started up NUnit, loaded my 1.1 compiled assembly, ran my tests, and everything came up green on the first try. Yay! Hope this helps other NUnit users.

\[Listening to: Redshift – Infamy (great Ohio local band)]

<!--EndFragment-->