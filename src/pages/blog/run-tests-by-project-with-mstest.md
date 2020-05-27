---
templateKey: blog-post
title: Run Tests By Project With MSTest
path: blog-post
date: 2008-07-08T02:28:06.986Z
description: An annoyance I used to have with unit testing in Visual Studio is
  that it was often difficult to limit the number of tests I wanted to run.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - MSTest
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

An annoyance I used to have with unit testing in Visual Studio is that it was often difficult to limit the number of tests I wanted to run. In VS 2008 there are some improvements here, and the nicest one is the ability to right-click in a test and select Run Tests and have it run that unit test (or do so in a test class, and it will run all the tests in the class). However, go over to the solution explorer and right click on a test project, and you won’t find any Run Tests link there. And trying Run Tests in a file but outside of a test class will kick off every test in the solution. Sometimes that’s what you want, but sometimes you just want to run the tests in one project.

The easiest way I’ve found to do this is to expand the Test View window. By default my Test View window looks something like this:

[![Visual Studio Test View](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/RunTestsByProjectWithMSTest_B059/image_2.png)

Now, one solution would be to sort by Project, and then highlight the tests to run, and then click the little Run Tests button. This is not exactly fun, easy, straightforward, or something I see myself doing on any kind of regular basis due to the hassle involved. However, if you widen the Test View slightly (or click the little toolbar thingie in the top right), you’ll see the Group By option:



[![Visual Studio Test View with Group By](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/RunTestsByProjectWithMSTest_B059/image_4.png)

Grouping by project will let you easily run the tests from one (or several) projects. This is especially nice when you have a lot of test projects and some of them are integration tests (or load tests) that take a significant amount of time and all you want to run at the moment are your unit tests to ensure you haven’t broken anything.

[![Run All Tests In Project](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/RunTestsByProjectWithMSTest_B059/image_6.png)

<!--EndFragment-->