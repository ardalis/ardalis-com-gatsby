---
templateKey: blog-post
title: Use Unit Test Framework to Test Production DB Consistency
path: blog-post
date: 2008-02-22T13:50:15.924Z
description: For [Lake Quincy Media](http://lakequincy.com/)‘s AdSignia Ad
  Server, I wanted to be able to ensure that the database had some internal
  logic rules checked periodically.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - CC.NET
  - ci
  - Software Development
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

For [Lake Quincy Media](http://lakequincy.com/)‘s AdSignia Ad Server, I wanted to be able to ensure that the database had some internal logic rules checked periodically. What kinds of rules? Well, probably an example would be best. Suffice to say up front, though, that we’re talking about more than NOT NULL or enforcing referential integrity. For example, part of the ad engine’s job is to redirect requests to ads to their destination URL on the advertiser’s page. These URLs are stored in a field in the database. Occasionally, through cut-and-paste, there would be newlines in the URL field, which would be difficult to detect visually, but which would cause the redirect to fail. So I wrote a test for it that runs daily (along with the others). Another example of a rule we have is that a ***Campaign*** has a StartDate and an EndDate, and within a Campaign are one ore more ***Placements***, which have their own StartDate and EndDate, each. However, all Placements in a Campaign must have their dates fall within the Campaign dates. That is, no Placement StartDate can be earlier than the Campaign StartDate, and no Placement EndDate can exceed its Campaign’s EndDate. So there is a test for this as well.

So, having some rules for the production database, and having ruled out sql’s built in constraints and such for enforcing them, I considered a variety of alternatives for applying these rules. My requirements were pretty simple: run the tests daily, and send me an email summarizing the results. I was also able to standardize the tests pretty well: each test is a stored procedure with a query that should always return 0 rows. If it returns any rows, those are the rows that are in error and need attention. So at any time I can run those stored procedures and see which, if any, rows of data need fixed up.

Now before anyone comments – yes, the UI has validation to enforce these rules. The business objects have validation and/or filters to scrub incoming data and make it right. But do I trust that they’re always going to catch everything? NO. And neither should you. These production tests have caught several bugs in our UI and business layer which we’ve then been able to fix, but which we might not have discovered for some time otherwise.

Now, back to implementation. You could do all of this in SQL Server as just a scheduled job. SQL Server supports email. That was one option, which I ruled out mainly because I’m less comfortable with SQL Server than I am with some other things I’m using that can do the job, and because I wanted the report to be nicely formatted. Another option would be a console app (EXE) that I would simply run as a scheduled job. I have several of these already performing other recurrent duties, and it was also a contender, but again I would have had to write a fair bit of code to render the output nicely, and it just felt like I was reinventing the wheel. What I really wanted was some kind of test framework that did this stuff for me…

So of course, there are a plethora of testing frameworks, from MSTest to NUnit to MbUnit and more. Any of these would work. I went with MSTest because I’m using VSTS and MSTest already for my projects. We’re also using continuous integration with [CruiseControl.Net](http://ccnet.thoughtworks.com/), so it was a pretty simple thing to set up a scheduled project in CC.NET that would kick off MSTest and run my tests. Each test is very simple – it calls a stored procedure and asserts that the number of rows returned is 0. Otherwise, it outputs a message with the number of rows returned and dumps the rows themselves out to the Console (which in the case of MSTest and most other frameworks is stored with the test results for later viewing). Some XML transforms of the output create a nice looking report summarizing the failed tests, which then is emailed to interested parties using another task in CC.NET. More immediately, I’m notified at once that these tests failed by CCTray.

I’ve been very happy with this solution and it’s saved me several times already. I have a long list of tests that I want to run on my database that I haven’t even had time to write up yet as stored procedures, but now that I have the testing architecture laid out, it will be a fairly simple thing to add these.

<!--EndFragment-->

![](/img/test-ardalis-1.jpg)

![](/img/test-ardalis-2.jpg)