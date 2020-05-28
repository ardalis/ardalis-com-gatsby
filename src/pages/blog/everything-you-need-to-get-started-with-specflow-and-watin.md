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

I opted to leave it in here for now. It’s likely that I’ll update it at some point to include a requirement like “Given I am on the site and logged in” which might require some actual setup work. Next I have \[When] statements for the scenario. Note that any “and” between your “When” and the “Then” is simply treated as another “When” statement. So for my scenario, where I have

> *When I navigate to the Publication/Create page*
>
> And I enter “Test Publication” in the Publisher textbox

that’s going to result in two separate \[When] methods, which I was able to cut-and-paste “scaffolded” versions from my test output. Once filled in with appropriate WatiN calls, they look like this:

```
[When(<span style="color: #006080;">@"I navigate to the Publication/Create page"</span>)]

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> WhenINavigateToThePublicationCreatePage()

{

WebBrowser.Current.GoTo(<span style="color: #006080;">"http://localhost:28555/Publication/Create"</span>);

}

[When(<span style="color: #006080;">@"I enter "</span><span style="color: #006080;">"(.*)"</span><span style="color: #006080;">" in the Publisher textbox"</span>)]

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> WhenIEnterTestPublicationInThePublisherTextbox(<span style="color: #0000ff;">string</span> publicationName)

{

var pubName = publicationName + <span style="color: #0000ff;">new</span> Random().Next(1000);

ScenarioContext.Current.Add(<span style="color: #006080;">"publicationName"</span>, pubName);

WebBrowser.Current.TextField(Find.ByName(<span style="color: #006080;">"Name"</span>)).TypeTextQuickly(pubName);

WebBrowser.Current.Button(Find.ByValue(<span style="color: #006080;">"Create"</span>)).Click();

}
```

Note that you probably don’t have a .TypeTextQuickly() method – you can replace that with TypeText for now, which I recommend so you can see how things work by default. Note that for this to work, your web application has to be running (if you’re using the Dev Web Server). If you’re using IIS or actually hitting a site on the Internet, then this shouldn’t be an issue. Note in the second function that I’ve changed the attribute value, replacing the original (C# escaped quotes) “”Test Publication”” with this “”(.\*)””. This is a regular expression, and .\* basically will match any series of characters. The result of this match is then provided as the string parameter on the method, string publicationName. It will be populated from the scenario, so when the test is run, publicationName will be “Test Publication”. Since at the moment I’m not resetting the database between each test, I made the test a bit more robust by adding a random number to the name, and then storing the resulting modified name in the ScenarioContext. I’ll use that in the assertions within the \[Then] methods.

By the way, I’m using a simple ASP.NET MVC 3 application with some default controllers and view set up using Entity Framework. You can see how to do this in [ScottGu’s post on EF Code First and Data Scaffolding with the ASP.NET MVC 3 Tools Update](http://weblogs.asp.net/scottgu/archive/2011/05/05/ef-code-first-and-data-scaffolding-with-the-asp-net-mvc-3-tools-update.aspx). If you want to follow along, just create a class called Publication with a Name property (and an ID column), build your project, and then Add Controller and (assuming you have the tools update referenced in Scott’s post) you should then choose the Controller with read/write actions and views, using Entity Framework template, which will generated a Create controller action and view that you can use to run the exact tests I’m showing. Here’s what my view looks like:

![image](<> "image")

Before you can fully run the test, we need to implement the \[Then] methods. These are both pretty simple:

```
[Then(<span style="color: #006080;">@"I am taken the the Publication/Index page"</span>)]

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> ThenIAmTakenTheThePublicationIndexPage()

{

 var currentUrlPath = WebBrowser.Current.Uri.PathAndQuery;

 Assert.That(currentUrlPath, Is.EqualTo(<span style="color: #006080;">"/Publication"</span>));

}

[Then(<span style="color: #006080;">@"I see the publication I just created"</span>)]

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> ThenISeeThePublicationIJustCreated()

{

var pubName = ScenarioContext.Current[<span style="color: #006080;">"publicationName"</span>] <span style="color: #0000ff;">as</span> <span style="color: #0000ff;">string</span>;
Assert.That(WebBrowser.Current.ContainsText(pubName));
<span style="color: #008000;">//WebBrowser.Current.Close();</span>

}
```

With these in place, you should be able to run your test, and with any luck it will come back green. Two things to note at this point, however:

1. The test is pretty slow.
2. The IE window created sticks around, and a new one is made every time you run the test.

To fix the speed problem, you can add this extension method (create a class WatinExtensions and add it to your project):

```
<span style="color: #0000ff;">using</span> WatiN.Core;
<span style="color: #0000ff;">namespace</span> Specifications.Extensions

{

    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">class</span> WatiNExtensions

    {

        <span style="color: #008000;">/// &lt;summary&gt;</span>

        <span style="color: #008000;">/// Sets text quickly, but does not raise key events or focus/blur events</span>

        <span style="color: #008000;">/// Source: http://blog.dbtracer.org/2010/08/05/speed-up-typing-text-with-watin/</span>

        <span style="color: #008000;">/// &lt;/summary&gt;</span>

        <span style="color: #008000;">/// &lt;param name="textField"&gt;&lt;/param&gt;</span>

        <span style="color: #008000;">/// &lt;param name="text"&gt;&lt;/param&gt;</span>

        <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">void</span> TypeTextQuickly(<span style="color: #0000ff;">this</span> TextField textField, <span style="color: #0000ff;">string</span> text)

        {
        textField.SetAttributeValue(<span style="color: #006080;">"value"</span>, text);

        }

    }

}
```

This should speed up your test dramatically – on my machine it makes it about twice as fast. It’s still slow compared to unit tests, but twice as fast is certainly an improvement, and in this case I don’t need any keypress events or in fact any client-side events at all.

To fix the window problem, you can uncomment the call to WebBrowser.Current.Close() in the last \[Then] method. As you add additional features, you’ll no-doubt want to come up with a better approach to recycle the browser windows. From what I’ve been able to learn, it seems like the typical usage of WatiN is to use test class level setup and teardown methods to create and close the window. With SpecFlow, if you want to go this route, you can either manually edit the .feature.cs file (which I don’t recommend), or since it’s a partial class, you can create your own partial class and add the following to it:

```
<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">partial</span> <span style="color: #0000ff;">class</span> CreateNewPublicationFeature

{

    [NUnit.Framework.TearDownAttribute()]

    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">virtual</span> <span style="color: #0000ff;">void</span> MyScenarioTeardown()

    {

        WebBrowser.Current.Close();

    }

}
```

This will destroy the current WebBrowser at the end of each scenario. With that in place, you should be able to run your tests, run them reasonably quickly, and not have any browser instances to clean up when you are finished.

**Automation and Reporting**

It would be nice if we could automate the running of these tests, so that we could schedule them or run them as part of a build process. Likewise, one of the nice features of creating executable specifications is that they should produce documents that you can share with project stakeholders. SpecFlow supports both of these scenarios, but getting it set up can take a little bit of work. In order to use SpecFlow to create reports as part of your automated build process, you’ll need some of the SpecFlow DLLs and the specflow.exe file in source control, so they can work on any machine without requiring SpecFlow to be installed on that machine. If you’re using Nuget, I think everything you need should be in the /packages folder, but I haven’t tested that scenario. In my case, I simply copied the DLLs I needed into a /lib folder in my project’s source control repository. Here are the files I ended up needing:

![image](<> "image")

To create an HTML report, you need to first run your unit tests using NUnit’s command line tool, with a few switches enabled. I like to use a combination of MSBuild and a ClickToBuild.bat batch file in the root of my source repository so that whenever someone grabs the source they can immediately run that batch file and get a working build of the software (with all tests run). Here is my current build.proj file, that is in the root of my solution:

```
<span style="color: #0000ff;">&lt;?</span><span style="color: #800000;">xml</span> <span style="color: #ff0000;">version</span><span style="color: #0000ff;">="1.0"</span> <span style="color: #ff0000;">encoding</span><span style="color: #0000ff;">="utf-8"</span> ?<span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Project</span> <span style="color: #ff0000;">xmlns</span><span style="color: #0000ff;">="http://schemas.microsoft.com/developer/msbuild/2003"</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">PropertyGroup</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">ProjectName</span><span style="color: #0000ff;">&gt;</span>MyProject<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">ProjectName</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">NUnitConsoleEXE</span><span style="color: #0000ff;">&gt;</span>srcpackagesNUnit.2.5.10.11092Toolsnunit-console.exe<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">NUnitConsoleEXE</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">PropertyGroup</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Target</span> <span style="color: #ff0000;">Name</span><span style="color: #0000ff;">="DebugBuild"</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Message</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="Building $(ProjectName)"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">MSBuild</span> <span style="color: #ff0000;">Projects</span><span style="color: #0000ff;">="src$(ProjectName).sln"</span> <span style="color: #ff0000;">Targets</span><span style="color: #0000ff;">="Clean"</span> <span style="color: #ff0000;">Properties</span><span style="color: #0000ff;">="Configuration=Debug"</span><span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">MSBuild</span> <span style="color: #ff0000;">Projects</span><span style="color: #0000ff;">="src$(ProjectName).sln"</span> <span style="color: #ff0000;">Targets</span><span style="color: #0000ff;">="Build"</span> <span style="color: #ff0000;">Properties</span><span style="color: #0000ff;">="Configuration=Debug"</span><span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">Target</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Target</span> <span style="color: #ff0000;">Name</span><span style="color: #0000ff;">="BuildAndTest"</span> <span style="color: #ff0000;">DependsOnTargets</span><span style="color: #0000ff;">="DebugBuild"</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Message</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="Running $(ProjectName) Unit Tests"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Exec</span> <span style="color: #ff0000;">Command</span><span style="color: #0000ff;">="$(NUnitConsoleEXE) srcUnitTestsbindebugUnitTests.dll /nologo /framework=4.0.30319 /xml:UnitTestResults.xml"</span><span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Message</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="Running $(ProjectName) Acceptance Tests"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Exec</span> <span style="color: #ff0000;">Command</span><span style="color: #0000ff;">="$(NUnitConsoleEXE) srcSpecificationsbindebugSpecifications.dll /nologo /framework=4.0.30319 /labels /xml:TestResult.xml"</span><span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Message</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="Generating SpecFlow Report..."</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Exec</span> <span style="color: #ff0000;">Command</span><span style="color: #0000ff;">="libSpecFlowspecflow.exe nunitexecutionreport srcSpecificationsSpecifications.csproj /out:AcceptanceTestResults.html"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">Target</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Target</span> <span style="color: #ff0000;">Name</span><span style="color: #0000ff;">="ReleaseBuild"</span> <span style="color: #ff0000;">DependsOnTargets</span><span style="color: #0000ff;">="BuildAndTest"</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Message</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="Building $(ProjectName) Release Build"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">MSBuild</span> <span style="color: #ff0000;">Projects</span><span style="color: #0000ff;">="src$(ProjectName).sln"</span> <span style="color: #ff0000;">Targets</span><span style="color: #0000ff;">="Clean"</span> <span style="color: #ff0000;">Properties</span><span style="color: #0000ff;">="Configuration=Release"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">MSBuild</span> <span style="color: #ff0000;">Projects</span><span style="color: #0000ff;">="src$(ProjectName).sln"</span> <span style="color: #ff0000;">Targets</span><span style="color: #0000ff;">="Build"</span> <span style="color: #ff0000;">Properties</span><span style="color: #0000ff;">="Configuration=Release"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;</span><span style="color: #800000;">Message</span> <span style="color: #ff0000;">Text</span><span style="color: #0000ff;">="$(ProjectName) Release Build Complete!"</span> <span style="color: #0000ff;">/&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">Target</span><span style="color: #0000ff;">&gt;</span>
<span style="color: #0000ff;">&lt;/</span><span style="color: #800000;">Project</span><span style="color: #0000ff;">&gt;</span>
```

Then I also include a build.bat and a ClickToBuild.bat file with every solution. They look like this (one line each):

**build.bat**

%systemroot%Microsoft.NetFrameworkv4.0.30319MSBuild.exe build.proj /t:%*

**ClickToBuild.bat**

build.bat ReleaseBuild & pause

The main work is all performed in the BuildAndTest target of the MSBuild .proj file. If you’re just testing this out from a command prompt, you can pull the commands you need from the <Exec /> elements there. For NUnit to generate a TestResult.xml file, you need to pass in the**/xml:TestResult.xml** switch. Note that at this time [ReSharper cannot generate an NUnit TestResult.xml file](http://devnet.jetbrains.com/message/5297087;jsessionid=A229234B2F7D691436DCBA79055322D8), so you have to resort to using the command line (or the NUnit GUI). Once you have that XML file, you can generate the SpecFlow HTML report by running **specflow.exe** with the command **nunitexecutionreport** and providing it with **/out:SomeFile.html**. Assuming that’s all correct, you should end up with an HTML file that looks something like this:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Getting-Started-with-SpecFlow_F705/image_19.png)

Note that if you are using the ClickToBuild the first time when you grab the source, you will need to start the web project (if using Web Dev Server) or otherwise set it up in IIS or IIS Express. You can script this as well (launch webdevserver from the MSBuild task if you like, on a known and otherwise unused port), but what I’m showing you here does not include that one step in any automated fashion.

**Summary**

There’s not a whole lot to getting SpecFlow and WatiN working with your ASP.NET (MVC) application. There are a few hidden gotchas that I’ve tried to cover in this post. Hopefully this will provide all of the resources you need. If there’s something missing, please let me know and I will provide an update to address the issue. The nice thing about the final HTML report you get is that you can sit down with the customer or project stakeholder and create all of the major features and many of the known scenarios prior to an iteration or release cycle, and then provide regular updates showing progress being made on a feature-by-feature (and scenario-by-scenario) level. Assuming the documented executable specifications accurately reflect the customer’s needs, these acceptance tests provide a common definition of what “done” is for the project, reducing the frequency of the team delivering incomplete or incorrect features.