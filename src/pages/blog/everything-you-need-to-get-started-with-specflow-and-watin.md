---
templateKey: blog-post
title: Everything You Need to Get Started with SpecFlow and WatiN
path: blog-post
date: 2011-06-24T12:34:00.000Z
description: I’m adding [SpecFlow](http://specflow.org/) to an application I’m
  working on so that I can add some acceptance tests that actually exercise the
  user interface.
featuredpost: false
featuredimage: /img/get-start.jpg
tags:
  - bdd
  - specflow
  - testing
  - watin
category:
  - Software Development
comments: true
share: true
---
I’m adding [SpecFlow](http://specflow.org/) to an application I’m working on so that I can add some acceptance tests that actually exercise the user interface. I’ve only spent a couple of hours on it thus far, but I have it working with a single specification running through the tests via [WatiN](http://watin.org/). I found the following resources helpful as I was going through this exercise:

* [Getting Started with SpecFlow and ASP.NET](http://www.bryanthankins.com/techblog/2010/05/12/getting-started-with-specflow-in-asp-net)
* [BDD with SpecFlow and ASP.NET MVC](http://blog.stevensanderson.com/2010/03/03/behavior-driven-development-bdd-with-specflow-and-aspnet-mvc)
* [BDD with SpecFlow](http://www.codeproject.com/KB/architecture/BddWithSpecFlow.aspx)
* [BDD with SpecFlow and Watin](http://msdn.microsoft.com/en-us/magazine/gg490346.aspx)
* [WatiN – Web App Testing in .NET](http://www.codeproject.com/KB/aspnet/WatiN.aspx)

I’m assuming that you’re just interested in getting up to speed with SpecFlow for acceptance testing and that you don’t want to waste any time on hidden gotchas or visiting all of the above URLs just to figure out what you actually need. Let me just give you the **Stuff You Need To Know™**.

**Installing SpecFlow**

First, you need to [install SpecFlow from this URL](http://www.specflow.org/downloads/installer.aspx). When I wrote this, the latest version was 1.6.1. Alternately, you can [get SpecFlow via Nuget here](http://nuget.org/List/Packages/SpecFlow). If you run the installer, specflow will be installed in your Program Files (x86) folder under TechTalk, like so:

![image](<> "image")

Next, you’ll want to add a new Class Library project to whatever solution you’re working with (I’m going to assume you have an ASP.NET web project in the solution that you’re trying to test). You can name it Specifications or AcceptanceTests or whatever you prefer. There isn’t a special project template set up, but there are item templates, so after you have the class library, add a New Item and choose a SpecFlow Feature File:

![image](<> "image")

This will give you a sample .feature file to start from. I’m not going to go into detail about the gherkin language, but rather will simply show you my first .feature file which is a bit more real-world than the one provided (this one will end up working against a scaffolded ASP.NET MVC 3 app):

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Getting-Started-with-SpecFlow_F705/image_8.png)

Note that there is a generated C# (.cs) file that goes along with each .feature file. This generated code is responsible for all of the test setup. In my case I’m using the default NUnit test runner, but you can also use MSTest. To install NUnit, I simply used the Package Manager to add it, like so:

**install-package nunit**

Once you have NUnit installed, you can run the tests. I’m using ReSharper so this screenshot shows its integrated test runner:

[![SNAGHTML9f51cef](<> "SNAGHTML9f51cef")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Getting-Started-with-SpecFlow_F705/SNAGHTML9f51cef.png)

Note that since I haven’t defined any Step definitions, my tests don’t actually do anything yet. However, part of the workflow of SpecFlow that you can follow is to run the test without the steps, and then copy and paste the step methods from the test results shown here. You can just add a new class and replace its contents with one of the classes above, or you can Add –> New Item and add a new SpecFlow Step Definition. I’m still figuring out how best to organize my Specifications project but for now I’m naming things by feature name, so I have a CreatePublicationFeature.feature file and a CreatePublicationSteps.cs file, so the two will sort together.

Now that we have some yellow tests, we can work toward making the test pass. We also can produce an HTML report, showing all of our features and our progress on them thus far. I’ll show the reporting last, but if you’re defining a lot of features up front, having the reporting early on can be a great thing to share with project stakeholders, since they’ll be able to see with each iteration how many features are going from yellow to green (and hopefully none turning red) as they are implemented and tested.

**Testing ASP.NET MVC with WATIN**

In my scenario I decided to give WatiN a try. To install it, I once again turned to Nuget. The install was easy, however, there were a few gotchas that I encountered. The first one was the dreaded STAThread issue, which you can resolve by adding an attribute to your unit test class marking it as a Single Threaded Apartment. However, since SpecFlow generates our test classes, this isn’t ideal. So the alternate approach is to add an app.config file with the following configuration to force NUnit to run in STA mode:

```
<span style="color: #0000ff;">&lt;?</span><span style="color: #800000;">xml</span> <span style="color: #ff0000;">version</span><span style="color: #0000ff;">="1.0"</span> <span style="color: #ff0000;">encoding</span><span style="color: #0000ff;">="utf-8"</span> ?<span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">configuration</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">configSections</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">sectionGroup</span> <span style="color: #ff0000;">name</span><span style="color: #0000ff;">="NUnit"</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">section</span> <span style="color: #ff0000;">name</span><span style="color: #0000ff;">="TestRunner"</span> <span style="color: #ff0000;">type</span><span style="color: #0000ff;">="System.Configuration.NameValueSectionHandler"</span><span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">sectionGroup</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">configSections</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">NUnit</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">TestRunner</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #008000;">&lt;!-- Valid values are STA,MTA. Others ignored. --&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">add</span> <span style="color: #ff0000;">key</span><span style="color: #0000ff;">="ApartmentState"</span> <span style="color: #ff0000;">value</span><span style="color: #0000ff;">="STA"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">TestRunner</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">NUnit</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">configuration</span><span style="color: #0000ff;">&gt;</span>

```

The other issue I encountered was related to the Interop.SHDocVw assembly, which is referenced and is in my /packages folder, but still my tests would fail saying they could not load the assembly. The fix that worked for me (VS2010, Windows 7 x64, if that matters) was to change the Embed Interop Types property of the reference to False (it defaulted to True). This eliminated that issue, and allowed my tests to launch an Internet Explorer window. Here’s the setting:

![image](<> "image")

I mention the above up front because they were immediate roadblocks to my being able to use WatiN in my project, and I don’t want you to get hung up on them when you get started with the next bit of code. I did add one helper class that I found on one of the links I listed at the top of this post, which lets me reference the same browser instance between test methods. It’s a simple static class with a static method that leverages the SpecFlow ScenarioContext collection. If you’re following along with my code exactly, you’ll need this:

```
<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">class</span> WebBrowser

{
 <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> IE Current

 {

get
   {
 <span style="color: #0000ff;">string</span> key = <span style="color: #006080;">"browser"</span>;
         <span style="color: #0000ff;">if</span> (!ScenarioContext.Current.ContainsKey(key))
 {

 ScenarioContext.Current[key] = <span style="color: #0000ff;">new</span> IE();
}

  <span style="color: #0000ff;">return</span> ScenarioContext.Current[key] <span style="color: #0000ff;">as</span> IE;

        }

    }

}
```

Now back to the Step .cs class. We cut-and-pasted the empty step definitions from our test output so that we now have some \[Given] \[When] and \[Then] methods in our class, CreatePublicationSteps. For my scenario, I don’t actually have any setup to do in my \[Given], so I could omit it entirely. But if I do keep it, it’s sufficient for it to look like this:

```
[Given(<span style="color: #006080;">@"I am on the site"</span>)]

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> GivenIAmOnTheSite()

{

}
```