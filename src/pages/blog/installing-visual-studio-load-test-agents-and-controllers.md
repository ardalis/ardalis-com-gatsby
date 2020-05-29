---
templateKey: blog-post
title: Installing Visual Studio Load Test Agents and Controllers
path: blog-post
date: 2011-07-19T12:26:00.000Z
description: "Visual Studio includes support for distributed load testing
  through the use of Test Agents and Controllers. "
featuredpost: false
featuredimage: /img/test-13394.jpg
tags:
  - load testing
  - test agent
  - visual studio
category:
  - Software Development
comments: true
share: true
---
Visual Studio includes support for distributed load testing through the use of Test Agents and Controllers. For reference, there are a couple of MSDN Walkthroughs on [Installing and Configuring Visual Studio Agents and Test and Build Controllers](http://msdn.microsoft.com/en-us/library/dd648127.aspx) and [Using a Test Controller and Test Agents in a Load Test](http://msdn.microsoft.com/en-us/library/ff400223.aspx). However, they lack pretty pictures, so if a screenshot walkthrough is more your speed, read on.

Before starting, you’ll need to installation media. This might be an actual DVD, or more likely it’s an ISO image you’ve gotten from MSDN that looks something like this:

![VS2010AgentsISOImage](<> "VS2010AgentsISOImage")

Here’s what mine looks like once mounted as my F: drive:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Installing-Visual-Studio-Load-Test-Agent_14B6F/image_2.png)

Of course the next step is to run setup.exe, which yields the opening menu screen:

![SNAGHTML1a57da13](<> "SNAGHTML1a57da13")

Feel free to review the installation guide. It’s actually just [a link to the URL I listed above](http://msdn.microsoft.com/library/dd648127%28VS.100%29.aspx). However, another useful URL to consider is the walkthrough that shows how to [Install Test Controller and Test Agents for Visual Studio Automated Tests](http://msdn.microsoft.com/en-us/library/ff469838.aspx) (since that’s what I want to do). Our next step is to install a Test Controller. Once you have a Test Controller installed, you can run tests on any machine that has a Test Agent installed on it. Note too that you’ll need to be a member of the Administrators group to perform this install, you should never do it on a domain controller, and if you’re TFS there are some additional considerations regarding the account you configure to run the test controller configuration tool. Got it? Ok, we’re ready to click something.

Click **“Install Microsoft Visual Studio Test Controller 2010”.**You should see a screen like this one:

![SNAGHTML1a5e437f](<> "SNAGHTML1a5e437f")

After a short wait, you should be able to click **Next >.** Do it. You should see something like this:

![SNAGHTML1a5f661c](<> "SNAGHTML1a5f661c")

Be sure to carefully read the licensing terms. Read them twice, just for good measure – maybe you missed something important! They’re very entertaining. Assuming that you agree and accept these terms, click the**I have read and accept the license terms** radio button, and click **Next**. You should see this:

![SNAGHTML1a61af0d](<> "SNAGHTML1a61af0d")

Assuming you have enough disk space, there’s not much to do on this page but click **Install**. It should start installing…

![SNAGHTML1a623636](<> "SNAGHTML1a623636")

On my laptop, this screen completed in about a minute. Once complete, you should get a happy page like this one:

![SNAGHTML1a62f0af](<> "SNAGHTML1a62f0af")

But… you’re not really done yet. Now you have to Configure the controller. Click **Configure**.

![SNAGHTML1a6412b0](<> "SNAGHTML1a6412b0")

At this point your choices will of course depend somewhat on what you’re trying to do. In my case, I just want a simple setup with two machines and no Team Foundation Server or domain involved. If you need to defer or re-run the configuration, you can do so any time – the app is installed under**All Programs –> Microsoft Visual Studio 2010 –> Microsoft Visual Studio Test Controller 2010 Configuration Tool** (one of Microsoft’s shorter product names, actually). In my case, I check the **Configure for load testing** box and use localhost as my SQL Server instance.

Note that currently I have 0 licensed virtual users on this machine (my laptop). I’m going to change that by unlocking [Unlimited Load Test Virtual Users for Visual Studio 2010](/visual-studio-2010-unlimited-load-test-virtual-users). Keep reading if your**Manage virtual user licenses** button is disabled like mine in the screenshot above – we’ll be able to use it in a moment.

When you’re done on this screen, click **Apply Settings**. Here’s my final screen (after a few moments):

[![SNAGHTML1a6f7a86](<> "SNAGHTML1a6f7a86")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Installing-Visual-Studio-Load-Test-Agent_14B6F/SNAGHTML1a6f7a86.png)

That warning tells me I may need to run as something other than Network Service if I need access to a remote machine’s performance counters. I’ll worry about that later. Once you click Close, you should see the Configure Test Controller screen again, and this time the **Manage virtual user licenses** button is not grayed out, so you can [follow the instructions for adding more virtual users](/visual-studio-2010-unlimited-load-test-virtual-users) (which you’ll certainly need if you’re using more than 1 computer for your load test). I set mine with a maximum of 5000 virtual users, which should be WAY more than I’m going to need on two computers (one of which is the system under test).

### Installing the Agent

From the main Setup screen, click on**Install Microsoft Visual Studio Test Agent 2010**. Note that you can do this on the same machine as the controller, as well as on however many other machines you want to use as load test agents. After a few moments, the installer screen should appear and look something like this:

![SNAGHTML1a9cf458](<> "SNAGHTML1a9cf458")

Click **Next**.

![SNAGHTML1aa41649](<> "SNAGHTML1aa41649")

Accept the license and click **Next >**.

![SNAGHTML1aa4d6da](<> "SNAGHTML1aa4d6da")

Click **Install**. This may take a while. Go do something else for a while… Eventually you see this, if all goes well.

![SNAGHTML1aafc07d](<> "SNAGHTML1aafc07d")

Click **Configure**.

![SNAGHTML1ab11c90](<> "SNAGHTML1ab11c90")

In my case, I’m going to be running web performance tests, and perhaps unit tests, but nothing interactive, so the default Service option is what I want. Click **Next**. Fill in your username and password and (optionally) your test controller on the next screen:

![SNAGHTML1abca34c](<> "SNAGHTML1abca34c")

Click **Apply Settings**. After a minute or so you should see something like this:

![SNAGHTML1ae7fa14](<> "SNAGHTML1ae7fa14")

And that’s it. Repeat the Agent install on as many machines as you like, and then control them all from the controller. I’ll try and post how to actually run the test with the controllers and agents soon, but in any case there’s a walkthrough of it here.

[http://msdn.microsoft.com/en-us/library/ff426235.aspx](http://msdn.microsoft.com/en-us/library/ff426235.aspx "http\://msdn.microsoft.com/en-us/library/ff426235.aspx")

Hope that helps you get started with running load tests using multiple machines as controllers and test agents.