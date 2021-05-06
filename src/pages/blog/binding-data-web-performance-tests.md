---
templateKey: blog-post
title: Binding Data to Web Performance Tests
date: 2011-05-03
path: blog-post
description: Web Performance Tests provide a simple means of ensuring correct and performant responses are being returned from your web application. Testing a wide variety of inputs can be tedious without a way to separate test recording and input selection. Data binding provides a convenient and simple way to try an unlimited number of different inputs as part of your web performance tests using Visual Studio 2010.
featuredpost: false
featuredimage: /img/binding-data-performance-tests.png
tags:
  - testing
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

Visual Studio's Web Performance Tests can be used to test whether web pages return the correct results and/or whether they respond quickly enough.  You can record these tests manually, but if you have a large number of scenarios you need to test for using the same set of pages, it's much more efficient to use the built in data source and data binding tools to do so.  This article walks through the steps of building a data driven Web Performance Test in Visual Studio 2010.

## Create the Test Project and Web Test

Open Visual Studio 2010 and create a new Test Project and then record a new Web Performance Test.

When the browser opens as part of the recorder, go to your favorite search engine, and search for something.  Then stop the recording and wait while Visual Studio detects dynamic parameters.  Depending on the search engine you're using, you may end up with a fair number of requests (due to various images as well as AJAX script callbacks) in your recording.  Find the one that corresponds to your actual search request and delete the others.

For our test data, we're going to use a simple text file.  Go to your test project and add a new file.  Name it SearchTerms.csv.  Add three rows of text to the file and save it:

Term
one
two
three

Next, in the QueryString Parameters of your search request, click on the term you searched for and then inspect its properties.

From the dropdown beside the Value's value, choose Add Data Source.

The simplest way to add data to your test is to create a comma-separated file and include it in the test project.  We'll use this approach for now, but certainly you could also store the test data in an actual database.  Name the data source 'search terms', and click Next.

Next, select your SearchTerms.csv file from your test project.  You should see it added to your Web Test.

Now go back to your query parameter (in my case, q=aspalliance) and inspect its properties.  When you look at that value, you should have the option to replace it with an item from the data source.

Choose the Term from the CSV file.  Finally, delete all of the other QueryString parameters except for your term.

Now you're ready to run the test.

Notice that we searched for our first search term, 'one'.  But wait, we only did one search - I thought the whole data file thing was meant to let us run many different cases?  So it is.  The last step is to click on the Edit run settings link above.  Click the One run per data source row option.

Now run the test again - you should get three test runs.  You can inspect each one to see the parameters that were passed in.

You can edit your test run settings in your .testsettings file, which you'll find in your Solution items by default (e.g. Local.testsettings).  Under Web Test you'll find the setting to run the web tests once per data row.

## Summary

Testing web pages can be a tedious process, and having to test many slightly different scenarios only makes the task worse.  By using data binding, web performance tests can be written such that they test a range of values without the need to re-record test scripts or write custom code.  Test data can be decoupled from the actual recording of the test itself, and can be stored either in simple text files in CSV or XML format, or in an actual database.

I found [this article](http://visualstudiomagazine.com/Articles/2010/06/17/Web-Performance-Testing-with-Visual-Studio-2010.aspx?Page=3) to be helpful while working on this walkthrough.  I'm also working on an online video series for PluralSight on Visual Studio performance testing that I hope to have completed in a couple of months.

Originally published on [ASPAlliance.com](http://aspalliance.com/2056_Binding_Data_to_Web_Performance_Tests.all)
