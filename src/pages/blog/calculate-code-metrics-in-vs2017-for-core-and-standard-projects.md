---
templateKey: blog-post
title: Calculate Code Metrics in VS2017 for Core and Standard Projects
date: 2018-07-03
path: blog-post
featuredpost: false
featuredimage: /img/calculate-code-metrics.png
tags:
  - ndepend
  - visual studio
category:
  - Software Development
comments: true
share: true
---

A feature I use quite a bit in Visual Studio is the Calculate Code Metrics tool, found under the Analyze menu. You can use it to get some nice information about your projects, including Cyclomatic Complexity, Depth of Inheritance, Class Coupling, and Lines of Code. Microsoft aggregates these into a Maintainability Index as well (which for some reason they color code Green even when it's abysmal, but I digress). With the introduction of .NET Core and more recently .NET Standard projects types, this functionality hasn't been updated in the latest versions of Visual Studio 2017. If you try to calculate code metrics on a Class Library (Net Standard) you'll see this:

[![](/img/calculate-code-metrics.png)](/img/calculate-code-metrics.png)

Note that in this case, I'm talking about a C# class library, which definitely IS NOT a Web Site project (and remember, a web site isn't a project and doesn't have a project file - it's just a folder - but again I digress).

If you think this feature should exist, you can [vote for the feature here](https://visualstudio.uservoice.com/forums/121579-visual-studio-ide/suggestions/33459643--netcore-code-metrics). Unfortunately, this [similar feature request](https://developercommunity.visualstudio.com/content/problem/8920/cannot-calculate-code-metrics-on-a-net-standard-li.html) is marked "Closed - Won't Fix" which doesn't bode well.

In the meantime, if you need this kind of static code analysis functionality, I recommend [NDepend](https://www.ndepend.com/). It integrates with Visual Studio or can run standalone, and can also easily be integrated into your CI build process. I hate that Visual Studio is losing functionality it already had, and I realize NDepend isn't a free tool, but it also has a huge amount more functionality than VS code metrics offers, which justifies its price for many teams. I've written about [using NDepend for Static Analysis](https://ardalis.com/static-code-analysis-and-quality-metrics) before if you want to learn more.
