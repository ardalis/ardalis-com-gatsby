---
templateKey: blog-post
title: Build Automation for your Application using MSBuild
path: blog-post
date: 2010-09-29T11:58:00.000Z
description: "Over the past few years, I’ve established something of a standard
  for how I like to organize my projects, and this includes having a one-click
  build-and-test script for each project. "
featuredpost: false
featuredimage: /img/build-automation-2.png
tags:
  - cd
  - ci
  - continuous integration
  - devops
  - msbuild
category:
  - Software Development
comments: true
share: true
---
Over the past few years, I’ve established something of a standard for how I like to organize my projects, and this includes having a one-click build-and-test script for each project. This is a quick description of my current thoughts on this, along with some details of how to get the MSBuild scripts working for your project as well. The ultimate goal is that you, a new developer who just pulled down the source from the version control system, and the build server can all run a build in exactly the same way, and expect the same results.

## Solution Organization

Of late I’m using a structure like this one for most non-trivial projects:

![](/img/build-automation-1.png)

This is designed to use the [Onion Architecture](http://jeffreypalermo.com/blog/the-onion-architecture-part-1), and it’s worth noting that the Core project has no outgoing project dependencies, and no dependencies on external resources (database, web services, etc). These things are located in the Infrastructure project, which references Core. This is in keeping with the [Dependency Inversion Principle](http://en.wikipedia.org/wiki/Dependency_inversion_principle) as applied to software components (as opposed to classes).

The DependencyResolution project uses StructureMap or a similar container to map interfaces to implementations at runtime. For small projects, this work can simply be done in the UI on app startup, but oftentimes if you know you’re going to need it, it’s not a violation of YAGNI to set this up from the start so you don’t have to rework how you construct your object graph later in the project.

UnitTests and IntegrationTests should be self-explanatory. The reason for splitting them is speed and dependency management. UnitTests don’t talk to external resources, and instead will typically rely on mock/fake/stub objects in place of external dependencies like databases. IntegrationTests include any tests that do talk to external dependencies, and will confirm things like the ability to do CRUD operations correctly on the database, as well as interaction between classes and layers in the application. UnitTests should run in milliseconds; IntegrationTests should run as fast as possible but often will take about a second per test (which can add up quickly).

Not shown in this solution are the database projects for this application. For most apps I would only have one, but this app actually talks to two databases, so there are two .dbproj files. I prefer to keep these in a separate solution so that my main solution builds faster. It also encourages me to think at the domain level, rather than the data level, as I figure out how I want to solve problems and implement features. However, whenever changes are made to the database projects, I do want these to be deployed immediately, since otherwise some of my integration tests will likely fail.

## Setting Up a One-Click Build-Test File with MSBuild

Notice the 3 files under Solution Items:

* Build.bat
* Build.proj
* ClickToBuild.bat

The batch files are each just one line. Here’s Build.bat:

```
%systemroot%Microsoft.NetFrameworkv4.0.30319MSBuild.exe build.proj /t:%
```

Since MSBuild isn’t xcopy deployable (like NAnt is), this batch file includes the path where the correct version should be found on the current machine. We’re figuring it’s ok to assume the user has the correct version of .NET installed in order to accomplish this task. ClickToBuild.bat is pretty small as well:

```
build.bat ReleaseBuild & pause
```

As you can see, ClickToBuild just calls build.bat, passes in a target (in this case, ReleaseBuild), and then pauses. This allows you to double-click on ClickToBuild.bat in windows explorer and not miss the result of the build operation (hopefully a green build successful).

That leaves the Build.proj file itself, which is where all the real work is done:

```
<?xml version="1.0" encoding="utf-8" ?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <ProjectName>Acme.Awesomizer</ProjectName>
  </PropertyGroup> 
  <Target Name="DebugBuild">
    <Message Text="Building $(ProjectName)" />
    <MSBuild Projects="src\$(ProjectName).sln" Targets="Clean" Properties="Configuration=Debug"/>
    <MSBuild Projects="src\$(ProjectName).sln" Targets="Build" Properties="Configuration=Debug"/>
  </Target>
 
  <Target Name="UnitTests" DependsOnTargets="DebugBuild">
      <Message Text="Running $(ProjectName) Unit Tests" />
      <Exec Command="lib\Nunit\nunit-console.exe src\Awesomizer.UnitTests\bin\debug\Awesomizer.UnitTests.dll /nologo /framework=4.0.30319 /xml:UnitTestResults.xml"/>
  </Target>
 
  <Target Name="DeployDBLocal">
    <Message Text="Deploying Acme.Logging Database Locally" />
    <MSBuild Projects="src\Acme.Logging\Acme.Logging.dbproj" Targets="Build;Deploy" />
    <Message Text="Deploying Acme.Reporting Database Locally" />
    <MSBuild Projects="src\Acme.Reporting\Acme.Reporting.dbproj" Targets="Build;Deploy" />
  </Target>
 
  <Target Name="BuildAndTest" DependsOnTargets="UnitTests; DeployDBLocal">
    <Message Text="Running $(ProjectName) Integration Tests" />
    <Exec Command="lib\Nunit\nunit-console.exe src\Awesomizer.IntegrationTests\bin\debug\Awesomizer.IntegrationTests.dll /nologo /framework=4.0.30319 /xml:IntegrationTestResults.xml"/>
  </Target>
 
  <Target Name="ReleaseBuild" DependsOnTargets="BuildAndTest">
    <Message Text="Building $(ProjectName) Release Build" />
    <MSBuild Projects="src\$(ProjectName).sln" Targets="Clean" Properties="Configuration=Release" />
    <MSBuild Projects="src\$(ProjectName).sln" Targets="Build" Properties="Configuration=Release" />
    <Message Text="$(ProjectName) Release Build Complete!" />
  </Target>
 
</Project>
```

There are 5 targets in this file. Here’s a quick summary of what they do:

* DebugBuild – cleans and builds the solution in debug mode
* UnitTests – runs the UnitTests project
* DeployDBLocal – deploys the *.dbproj projects to the local computer
* BuildAndTest – runs the integration tests after ensuring all of the above are done
* ReleaseBuild – cleans and builds the solution in release mode after all of the above are done

Observant readers may note that I’m building the same solution twice if everything works – once in debug mode and once in release mode. The reason for this is that I prefer to have the debug build when tests are failing and giving me stack trace info, but when I’m ultimately done and I want to deploy the bits, I want release build dlls.

Once you have a build.proj file like this one, setting up continuous integration is a breeze. For this current project, I’m using [JetBrains TeamCity](http://jetbrains.com/), which is an awesome product that has a free version for a ton of projects and users. To set up a new build in TeamCity using this information, you just do fill in a form on the TeamCity server’s web site like this:

![](/img/build-automation-2.png)

For now I’m using xml output files from NUnit, specified in the NUnit command in build.proj, and then instructing TeamCity to look for those xml files using the Import data from XML and Report paths menu items at the bottom of the screenshot above. This works pretty well, but you can also hook up TeamCity to the NUnit (or MSTest) tests directly. My reason for avoiding this thus far is that I really like the fact that TeamCity and my machine and everyone else on my team’s machines are all running the same exact build script, including how the tests are being called.

**Summary**

Having a well-automated build and test process eliminates a lot of waste in the software development process. The ideal situation is to be able to sit a new developer down at a machine with basic dev tools installed, pull down your app from source, and immediately run ClickToBuild.bat and have it build the app and run all tests against it successfully, locally, the first time. What’s more, you should have a build server, and that build server should, ideally, be running the same build script that you run before you checkin, so that failed builds are very rare. In fact, if you follow [The Check In Dance](https://ardalis.com/the-check-in-dance), you should very, very rarely encounter broken builds on the build server.