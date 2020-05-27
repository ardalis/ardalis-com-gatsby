---
templateKey: blog-post
title: More Team System Class Notes
path: blog-post
date: 2005-07-04T16:01:55.541Z
description: We spent some time looking at testing in general, and the theory of
  why to test and how testing relates to quality.  Briefly mentioned TDD and
  other related disciplines.  In VSTS, tests are code and are versioned along
  with the code.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Test Driven Development
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[See](http://aspadvice.com/blogs/ssmith/archive/2005/06/28/1886.aspx)[](http://aspadvice.com/blogs/ssmith/archive/2005/06/28/1886.aspx)

[Day One.](http://aspadvice.com/blogs/ssmith/archive/2005/06/28/1886.aspx)

Didn’t get a chance to post my notes for days two and three until now.

We spent some time looking at testing in general, and the theory of why to test

and how testing relates to quality. Briefly mentioned TDD and other

related disciplines. In VSTS, tests are code and are versioned along with

the code. The tool can auto-geneate tests per method or class. The

skeleton is generated along with stub code to call the method, but no additional

logic is inferred. It’s possible to step through tests in the debugger,

which can be done today with NUnit, but it seems easier with Team System.

**Test Driven Development (TDD)**\
Red – Green –

Refactor\
Unit Tests must be\
– Automatic\
–

Repeatable\
– Available to all devs

**Build Process**\
– Team Builds\
– Multiple

Build Types – basically different build scripts – stored centrally\
–

Choose a machine to perform builds

In VS Team Explorer, locate Team Build. VS communicates with Team

Foundation Server, which talks to the Build Server. The build information

is stored in the database. The build server pulls the build information

from the data store and performs the build. In theory, the build server

does not require a full version of visual studio — unfortunately in practice it

pretty much does, since without Visual Studio it cannot do any advanced options

like running tests, performing code analysis (FxCop), etc. All those tasks

are tightly coupled to Visual Studio today.

**Web Test\
–**Record a script – basically like

Application Center Test but nicer.\
– Data Source – set up a data

source for the test, and use queries to populate posted data fields or user

ids\
– Set Credentials\
– Add Test Callback\
–

Generate Code –> one way process. For ultimate customization you can

convert a web test to code (your choice of .NET language) and basically do

anything you can do with code within the test.\
– Add Validation

Rule\
– Find Text — specify text, specify pass/fail if

found.\
– Extraction Rule — Pull out some data, use it in

a following request.

**Load Test**\
– Can run web tests, obviously, but can

also run unit tests, which is really slick\
– Can be scheduled with

build process\
– Allows a bunch of options Application Center Test does

not, including\
– Ramping Load (add x users every N

seconds)\
– Think Time randomized normally around recorded

think time\
– Impersonate various browser types and

connection speeds for clients

**Work Item Queries**

Work Items are the main thing tracked by Team System’s bug/task

tracker. It comes with a bunch of default queries and you can build your

own. You can save your custom queries in your own My Queries section, or

save them as team queries for all to use. If you customize a process

template, you can specify quich queries should be in there by default,

too. These queries are saved as *.wiq files, and use a SQL-like

syntax. A couple of good aliases to know are @Project which refers to the

current project and @Me which refers to the current user.

**Performance Wizard – Profiling**

Built into Visual Studio (under Tools). Allows two choices, sampling

and instrumentation.

Sampling\
– No Instrumentation\
– Non-invasive\
–

Some methods could be missed\
– Basically polls the running process

periodically to see which method is currently being executed.\
– Not

supported on Virtual Machines. If you try it you’ll get an error:

**VSP1454 – Sampling is not supported on Virtual Machines.**

Instrumentation\
– Injects code\
– Higher

overhead\
– More accuracy\
– Add code to the entry/exit of

every method, which notifies profiler when the code is reached.

Neither choice will allow line-level accuracy, only method level.

In case anybody encounters this error (from the lab): **Launch Error –**



**Found two different objects associated with the same URI.** The fix

for me was to restart Visual Studio.

**Source Control**\
– supports branching\
–

supports shelving\
– store pending changes in source

control but outside main repository – good for work in progress or if a

gatekeeper is used to review all code before it goes into main

repository.\
– workspace – local working copy

Team System Source Control Does **NOT** Support:\
–

Pinning (but branching is better)\
– Sharing (sharing one file among

multiple projects; avoids need for multiple copies)\
– Archive and

Restore\
– Destroy

In fact, it’s fairly difficult to delete anything once it gets into VSTS

Source Control.

<!--EndFragment-->