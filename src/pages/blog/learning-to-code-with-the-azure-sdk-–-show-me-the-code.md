---
templateKey: blog-post
title: Learning To Code with the Azure SDK Ndash Show Me The Code
path: blog-post
date: 2012-02-02T04:43:00.000Z
description: "I’ve been working with Azure off and on since last summer, and
  like any new API or platform, there are hurdles involved with the learning
  curve. "
featuredpost: false
featuredimage: /img/java-script.png
tags:
  - azure
category:
  - Software Development
comments: true
share: true
---
I’ve been working with Azure off and on since last summer, and like any new API or platform, there are hurdles involved with the learning curve. This is especially true for pre-release software that is rapidly changing and of course has neither official documentation nor much in the way of info on blogs or [developer community sites like ASPAlliance.com](http://aspalliance.com/). One of the ways I like to learn about projects these days is through testing. Ideally, the project will already have a suite of unit tests that I can run to confirm that it actually works at least as well as its creators expect it to, and then I can look at individual tests to discover how the creators of the API expect others to use it. Like many other developers, I usually don’t bother to read the official documentation (I’ve come to expect it will be lacking), preferring instead a “Show Me The Code (SMTC)” approach.

**Show Me The Code**

The big benefit of SMTC is that you don’t have to worry about whether or not the documentation was properly updated between the previous CTP release and the preview alpha CTP pre-release daily build you’re using now. You run the code, and if it does what it’s supposed to do, then you know you have a system that is more-or-less working and you can go from there. Most SDKs include samples to help you get started, with full source code, as obviously this is one of the best ways developers can quickly get up to speed with a new set of tools.

Azure’s SDK as of the January CTP ships with about 9 folders worth of samples, including a couple of HelloWorld projects, a PersonalWebSite, a CloudDrive demo that lets you map a drive to cloud storage, and more. If you want to take advantage of Azure Storage on your local machine, then you’ll most likely run the sample storage client API sample so you can get up to speed with it. It’s comprised of a console application that basically runs through a bunch of API exercises that demonstrate how to perform operations against Azure’s Blog, Queue, and Table storage options. If you run it, you end up with something like this:

Coupled with the actual source code, this is a great example of how to use Azure Storage. However, it’s not the best output and unless you watch it as it runs, you don’t really know what all this program actually did. Or if some pieces maybe failed. Or how to run just the part on deleting table entries. This is a good example of SMTC, but it falls short of being as expressive and approachable as it could be.

**Unit Tests**

I’m probably preaching the choir here when it comes to unit tests, but there are still about a bazillion developers out there who simply don’t get them. They don’t write them, they don’t run them, and they certainly don’t see the value in them. This is just one instance where I think unit tests are valuable, and that is as documentation. As a developer trying to learn an API or going through an SDK, I would much rather have an exhaustive suite of unit (and integration) tests than a .chm file or PDF with standard documentation (though of course having both would be ideal). With the unit tests, I have documentation I can *execute*. And I can do it for the whole system or just a tiny piece that interests me at the moment. I don’t have to try and set up a huge solution that came as a sample with the SDK – I can run just one test. Or I can look at just one test and, if it was written well, I can come quickly grasp how the System Under Test (SUT) is meant to be used.

Going back to the Azure SDK example with the StorageClientAPISample project, the Program.cs file in that project is 972 lines long. Here’s a small example of some of the code, showing how to create a Blob of text:

// write some text blobs\
NameValueCollection nv1 = new NameValueCollection();\
nv1\[“m1”] = “v1”;\
nv1\[“m2”] = “v2”;

StringBlob hello1 = new StringBlob(“hello.txt”, “Hello World”);\
hello1.Blob.Metadata = nv1;\
Console.WriteLine(“Creating blob hello.txt”);\
PutTextBlob(container, hello1);

BlobProperties prop = container.GetBlobProperties(“hello.txt”);\
Console.WriteLine(“hello.txt content length = ” + prop.ContentLength);

I’m sure the unit testers among you will agree that this would be a good candidate for a unit test (or in this case, since it really is talking to the storage service, an integration test). It’s possible that some future version of the Azure SDK (it’s not even Beta yet, I realize) will include a suite of unit tests, but Microsoft faces some challenges here with deployment. MSTest still is not xcopy deployable, and to date they’ve shown a fair amount of reluctance to use alternative open source tools like [NUnit](http://nunit.org/) (though the ASP.NET MVC team has been more open in this regard than most other teams). Since I’m not on the Azure team but I do think such tests would be a valuable addition, I’ve suggested this to the team but I’ve also gone ahead and started an [Azure Contrib project on CodePlex](http://codeplex.com/azurecontrib) that will include such tests among its samples, as well as other Azure add-ons that don’t ship with the official SDK. Naturally I’ll be looking for additional project members as well as ideas for things to include in the project, though for now I don’t even have these tests set up so I don’t want to get too far ahead of myself.

**Summary**

Show Me The Code (SMTC) is a great way to learn. Tests are a great way to break up a lot of code into bite-sized pieces that are both easy to learn and easy to evaluate whether or not they’re working correctly. Microsoft should consider shipping tests instead of monolithic console applications with the SDK samples, for Azure as well as other frameworks they are developing, and they should consider making MSTest distributable or accepting the fact that tools like NUnit can serve this space well. [Azure Contrib](http://codeplex.com/azurecontrib) will soon provide some additional components of interest to Azure developers which are not part of the official SDK.