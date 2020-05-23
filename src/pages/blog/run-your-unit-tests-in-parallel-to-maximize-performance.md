---
templateKey: blog-post
title: Run Your Unit Tests in Parallel to Maximize Performance
path: blog-post
date: 2012-01-19T05:11:00.000Z
description: "If you’re at all serious about testing, at some point you’re going
  to have a rather large suite of tests that need to run, and you’ll find that
  your builds are taking longer than you would like because of how long the
  tests run. "
featuredpost: false
featuredimage: /img/programmer.png
tags:
  - performance
  - testing
  - unit testing
  - unit tests
category:
  - Software Development
comments: true
share: true
---
If you’re at all serious about testing, at some point you’re going to have a rather large suite of tests that need to run, and you’ll find that your builds are taking longer than you would like because of how long the tests run. For example, consider this suite of 24 tests, each one of which looks like this one:

![](/img/test-method.png)

If you run 24 of these, it’s going to take about 24 seconds, by default:

![](/img/test-sessions.png)

Now of course[it’s important to keep your unit tests and integration tests separate and to know which is which](https://ardalis.com/unit-test-or-integration-test-and-why-you-should-care), but even once you’ve done that, anything you can do to speed up your test execution times is going to be a big help to your productivity. Slow builds due to slow tests kill productivity:

![](/img/compiling.png)

![](/img/programmer.png)

One simple way you can speed up your tests is to run them in parallel. Doing so with MSTest is actually extremely easy to do, although it’s not at all obvious how to do it, since the setting you need to adjust is hidden away and has no user interface exposed. The really cool thing is that, after you make the change, even if you don’t use the Visual Studio built-in test runner, your tests will run in parallel.

## Enabling Parallel Testing in MSTest

Like most of the settings used by MSTest, the setting you need to tweak to enable parallel unit test execution is in the .testsettings file that you’re using. In a brand new test project, you should have a Local.testsettings file, like this one:

![](/img/solution.png)

If you open this file and click through the various settings boxes, you won’t find anything there related to test parallization. Go ahead and look. Ok, satisfied now? Good, let’s move on.

Now, if you right-click on the file and open it with an XML Editor, you’ll find some more interesting settings.

![](/img/local-test.png)

Here’s the default XML file:

![](/img/xml-2.png)

If you go click on the <Execution> element, and attempt to add an attribute to it, you should get some Intellisense/statement completion, showing you what the acceptable attributes are:

![](/img/execution.png)

In this case, the option you want is parallelTestCount. If you simply set it to 0, the system will automatically choose a number of parallel tests equal to the number of cores detected on your system. In my case, I have a 4-core machine, so it will use 4 cores. Save the file.

**Note**: Typically at this point if you re-run your tests, they will continue to run one-at-a-time. The .testsettings files are cached and are not read immediately when you make changes to them. I’ve had success getting them to update by going to the Test View window and hitting the Refresh button there, but if that fails you could simply try closing Visual Studio and re-opening it and your project.

Run your tests again. Here’s a screenshot showing them running in the Visual Studio test runner. You can see there are 4 tests In Progress at the same time:

![](/img/test-results.png)

Of course, you can also set the value to a number that exceeds the number of (apparent) cores on your system. I’ve gotten it to work with as many as 16 on one machine, but on the one I’m working on now, it fails once it exceeds 5 cores. According to a friend of mine, there is a hotfix available that fixes this bug and allows VS2008/VS2010 to use this setting with a parallelTestCount > 5, and apparently this already works in some environments without this hotfix (such as my laptop). Likewise, I was able to run tests in parallel using ReSharper’s test runner on my laptop, but on this desktop machine running the latest 6.1 version of R# it is only running one test at a time.

Nonetheless, if you set the value to 5 and run my suite of 24 1s tests, the entire suite executes in about 5 seconds. That’s an 80% reduction in total test time, which is pretty amazing, and of course this number gets even bigger if you make it larger (assuming you have the hardware to support it).

## Caveats

You need to be using MSTest. This doesn’t work with NUnit.

You may need to be using the Visual Studio built-in test runner. I had it working with the ReSharper test runner, but it’s not working now on this machine, so YMMV.

You may not be able to exceed <Execution parallelTestCount=”5″>. If you need to do so, contact Microsoft support for the hotfix. If it’s a publicly available link, please link to it in the comments below.

Your tests should be thread-safe and side effect free. This rules out most integration tests ([what’s the difference between unit tests and integration tests?](https://ardalis.com/unit-test-or-integration-test-and-why-you-should-care)). You also need to be very careful about any use of global state. Here’s a simple example of a test suite that passes when run sequentially but fails when run in parallel (click to open in new window):

![](/img/tester.png)

## Summary

Especially as CPUs continue to ship with greater and greater numbers of cores, rather than faster clock speeds, the ability to take advantage of the potential performance of these systems will depend on our ability to perform operations in parallel. One area in which MSTest currently has the lead on alternatives like NUnit is in parallel test execution, and I hope that the next version of Visual Studio improves upon this feature and makes it more discoverable and addresses some of the current issues it suffers from. I have confirmed that the XML attribute and test runner behavior in the Visual Studio 11 CTP distributed at the BUILD conference in September 2011 work just as they do today in VS2010.

You can view and[download the sample code from its BitBucket Mercurial Repository here](https://bitbucket.org/ardalis/paralleltests).