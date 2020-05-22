---
templateKey: blog-post
title: Getting Next Month in MSBuild
path: blog-post
date: 2011-02-01T10:51:00.000Z
description: I’m working on an application that needs to deploy a new database
  each month, in order to manage the large amount of data involved
featuredpost: false
featuredimage: /img/cloud-native.jpg
tags:
  - msbuild
category:
  - Software Development
comments: true
share: true
---
I’m working on an application that needs to deploy a new database each month, in order to manage the large amount of data involved. We’d like to automate this as much as possible, and since we already have the database schema in a Visual Studio 2010 database project, we figured the simplest thing would be to create an MSBuild task to do this, and then schedule it as part of our build server. The format we want to use for the database name is simply “Databasename_201103” where the 201103 is next month’s year and month number (in this case, March 2011).

So, to make the first part work is pretty simple. You can pass in a parameter, TargetDatabase, to the Deploy task of a .dbproj file and it will create the new database as part of the deployment. You can do this from the command line, or directly in MSBuild, which looks something like this:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Target</span> <span style="color: #ff0000">Name</span><span style="color: #0000ff">=&quot;DeployLoggingDBNextMonth&quot;</span> <span style="color: #ff0000">DependsOnTargets</span><span style="color: #0000ff">=&quot;GetNextMonth&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">MSBuild</span> <span style="color: #ff0000">Projects</span><span style="color: #0000ff">=&quot;srcDatabasename.dbproj&quot;</span> 
<span style="color: #ff0000">Targets</span><span style="color: #0000ff">=&quot;Build;Deploy&quot;</span>  <span style="color: #ff0000">Properties</span><span style="color: #0000ff">=&quot;TargetDatabase=Databasename_$(NextMonthString)&quot;</span> <span style="color: #0000ff">/&gt;</span> 
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">Target</span><span style="color: #0000ff">&gt;</span>
```

That’s the easy part. The tough part is actually getting the string, 201103, to use in the $(NextMonthString) value.

My searching led me to the [MSBuild Community Tasks Project](http://msbuildtasks.tigris.org/), which includes things like Add and Time that I thought I could use. Time even has a nice Format property so you can format out the time. In fact, if all I wanted to know was \*this\* month’s code, it would be a simple matter:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Target</span> <span style="color: #ff0000">Name</span><span style="color: #0000ff">=&quot;ThisMonth&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Time</span> <span style="color: #ff0000">Format</span><span style="color: #0000ff">=&quot;yyyyMM&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Output</span> <span style="color: #ff0000">TaskParameter</span><span style="color: #0000ff">=&quot;FormattedTime&quot;</span> <span style="color: #ff0000">PropertyName</span><span style="color: #0000ff">=&quot;ThisMonth&quot;</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">Time</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Message</span> <span style="color: #ff0000">Text</span><span style="color: #0000ff">=&quot;This Month: $(ThisMonth)&quot;</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">Target</span><span style="color: #0000ff">&gt;</span>
```

Result:

> **This Month: 201102**

Now of course, I could use the <Add> task from the community tasks project, and this would work \*most\* of the time:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Target</span> <span style="color: #ff0000">Name</span><span style="color: #0000ff">=&quot;GetNextMonthAdd&quot;</span> <span style="color: #ff0000">DependsOnTargets</span><span style="color: #0000ff">=&quot;ThisMonth&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Add</span> <span style="color: #ff0000">Numbers</span><span style="color: #0000ff">=&quot;1;$(ThisMonth)&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Output</span> <span style="color: #ff0000">TaskParameter</span><span style="color: #0000ff">=&quot;Result&quot;</span> <span style="color: #ff0000">PropertyName</span><span style="color: #0000ff">=&quot;Result&quot;</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">Add</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">Message</span> <span style="color: #ff0000">Text</span><span style="color: #0000ff">=&quot;Next Month Using Add: $(Result)&quot;</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">Target</span><span style="color: #0000ff">&gt;</span>
```

Result:

> **Add numbers: 1 + 201102 = 201103**
>
>
>
> **Next Month Using Add: 201103**

Eureka! Ship it! That’s perfect! But wait, somehow years of unit-testing have me wondering, what will happen in December? Oh, right, it will yield this:

> **Add numbers: 1 + 201112 = 201113**
>
>
>
> **Next Month Using Add: 201113**

That’s not a problem, is it? Everybody knows January 2012 is the 13th month of 2011, right?

What about using a Conditional? We could always add 1, unless the month is 12, in which case we add 89 (because that’s intuitive). That would yield 89 + 201112 = 201201, which is what we expect. Sadly, apart from being an awful hack, I can’t see how to actually implement a <Conditional> <When> <Otherwise> block inside of an MSBuild task.

Fortunately, the MSBuild Community Tasks have a solution, which is to simply let me execute some arbitrary .NET code in a script-like fashion. In this case, one line of C# is easily able to do what many lines of declarative gunk can’t easily do. The end result (with some declarative gunk to wrap my one line of code) is shown here:

```
&lt;PropertyGroup&gt;
    &lt;GetNextMonthString&gt;
     &lt;![CDATA[
        <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">string</span> ScriptMain() {

            <span style="color: #0000ff">return</span> DateTime.Today.AddMonths(1).ToString(<span style="color: #006080">&quot;yyyyMM&quot;</span>);

        }

]]&gt;
&lt;/GetNextMonthString&gt;
&lt;/PropertyGroup&gt;
&lt;Target Name=<span style="color: #006080">&quot;GetNextMonth&quot;</span>&gt;
&lt;Script Language=<span style="color: #006080">&quot;C#&quot;</span> Code=<span style="color: #006080">&quot;$(GetNextMonthString)&quot;</span>&gt;
&lt;Output TaskParameter=<span style="color: #006080">&quot;ReturnValue&quot;</span> 
PropertyName=<span style="color: #006080">&quot;NextMonthString&quot;</span> /&gt;
&lt;/Script&gt;
&lt;/Target&gt;
```

This satisfies the requirement nicely, both today, and in 10 months. (It’s 1 February 2011 as this is being written)