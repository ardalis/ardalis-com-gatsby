---
templateKey: blog-post
title: Live Unit Testing in Visual Studio 2017
path: blog-post
date: 2017-03-08T03:30:00.000Z
description: Visual Studio 2017 has a new feature called Live Unit Testing.
featuredpost: false
featuredimage: /img/vs2017-live-unit-testing-multiline-760x360.png
tags:
  - tdd
  - testing
  - visual studio
  - xunit
category:
  - Software Development
comments: true
share: true
---
Visual Studio 2017 has a new feature called Live Unit Testing. ~~It’s currently not> available for .NET Core projects, but you should see it as an option in your standard .NET projects.~~ Live Unit Testing is currently only available in the Enterprise SKU (see [feature comparison](https://www.visualstudio.com/vs/compare/)) – [click here to grab a free trial](https://www.visualstudio.com/downloads/) if you want to check it out.

**Update:** Live Unit Testing now works with .NET Core projects, too!

For this example, I simply created a new C# .NET test project in VS 2017 Enterprise, and added the start of the [String Calculator](https://github.com/ardalis/kata-catalog/blob/master/katas/String%20Calculator.md) kata (which you can find in this [kata catalog repository on GitHub](https://github.com/ardalis/kata-catalog)). Once you have a project set up with some tests, and you want to see the tests run live as you implement new functionality, enable Live Unit Testing with the Test > Live Unit Testing > Start menu, as shown:

![](/img/vs2017-live-unit-testing-start.png)

With Live Unit Testing running, this menu will change so that you can Pause, Stop, or Restart Live Unit Testing (which you might want to do because running the tests utilizes some of your system’s resources):

![](/img/vs2017-live-unit-testing-pause-stop-restart.png)

Notice in the screen capture above there are green checkmarks on lines 5 and 7 of the StringCalculator class. These represent lines of code that have been covered (called) by tests that have run most recently via Live Unit Testing. At this point there is just one test, and it expects zero to be returned to the trivial implementation of the Add method passes all tests. Thus, the green checkmarks.

Now you would write another test, perhaps verifying that passing in “1” to Add results in an integer 1 being returned:

![](/img/vs2017-live-unit-testing-in-progress.png)

Notice now that the first passing test still shows as green checks, but the second test is failing with red X icons. The right-hand StringCalculator class is also showing red X icons now, because the failing test ran against this method. There are a couple of subtle things to notice in this screenshot.

First, the StringCalculatorAdd.cs file on the left *hasn’t even been saved*, but Live Unit Testing is running. That allows it to provide extremely rapid feedback as you work. It’s especially nice for practicing katas like this one, but you’ll find it worthwhile for production code, too. (By the way, if this [test naming convention is new to you, learn more here](http://ardalis.com/unit-test-naming-convention))

Second, so far the green and red icons aren’t providing that much more value than simply showing whether a test passed or failed – and we already had CodeLens to do that. But notice that the Add method’s CodeLens says “0/1 passing”. Live Unit Testing was smart enough to know that when I added a new test on the left, but didn’t change anything on the right, it didn’t need to re-run the first (passing) test. CodeLens is only showing the most recent test run, which in this case was just the last (failing) test. This is important to note because Live Unit Testing needs to be smart about when and which tests it runs. It wouldn’t be very useful if it tried to run every test in the solution on each keypress, for instance. So instead, it has logic that allows it to run only a subset of tests based on what has changed in your code.

Of course, Live Unit Testing becomes more valuable when your system under test (SUT) code becomes more complex, since it can show you exactly which parts of the SUT have failing tests. For instance, adding some conditional logic (poorly) to the SUT might result in the following output:

![](/img/vs2017-live-unit-testing-multiline.png)

Here you can see that the Add method has failing tests, but beyond that, you can also see that the sequence of statements on line 9 and 11 both have a test failure. However, all tests that execute line 13 succeed. So you can be pretty certain that the bug you’re looking for is somewhere between lines 9-11, in this case (and in this case, that 2 should be a zero).

I think Live Unit Testing will be a popular VS2017 feature. I’ve already shown it at the Hudson Software Craftsmanship user group that meets at the [Tech Hub Hudson coworking office space](http://techhubhudson.com/) each month, to much excitement, as well as for clients. Now that Visual Studio 2017 has shipped, I expect to use it even more often. I can’t wait for it to be supported for .NET Core projects, too, since a lot of my work these days targets .NET Core and ASP.NET Core.

*If you found this useful, consider sharing it with a peer and joining my[weekly dev tips newsletter](https://ardalis.com/tips)or[podcast](http://weeklydevtips.com/).*