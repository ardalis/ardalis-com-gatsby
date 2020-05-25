---
templateKey: blog-post
title: Unit Testing with Ordered Tests
path: blog-post
date: 2005-04-11T21:23:42.853Z
description: On the NUnit mailing list there’s a discussion going on about
  whether or not it would be useful and/or advisable to be able to specify the
  order in which unit tests are run by a test harness (in this case, NUnit).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Unit Testing
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

On the NUnit mailing list there’s a discussion going on about whether or not it would be useful and/or advisable to be able to specify the order in which unit tests are run by a test harness (in this case, [NUnit](http://www.nunit.org/)). I have to say that I would be strongly in favor of such a feature, and I have some thoughts on how to easily implement it in such a way that it would not greatly disturb anybody who doesn’t care what order their tests run in.

On the one side, the status quo purists argue that the point of SetUp and TearDown is to put you into a known state before every test. In some situations, this resulted in a lot of repeated code, which was not ideal for performance. In a recent release of NUnit, support was added TestFixtureSetUp and TestFixtureTearDown, features I was very pleased to see. The problem with the TestFixture\[SetUp/TearDown] methods is that they introduce the ability for users to do dumb things. It’s now possible to do some setup that needs done before every test in the TestFixtureSetUp instead of in SetUp and to produce invalid results. That’s a valid concern, but I really don’t like being hamstrung to protect the ignorant masses who don’t know what they’re doing. I really don’t think that will happen that often, whereas the extra few seconds I save by not having to run expensive setup operations on a per-test basis (i can do it per-suite) adds up to a lot of my time, which is quite valuable (to me — and to others who share my desire to have the tests run as quickly as possible).

One annoyance I have with NUnit is that if I have a low-level test like, say, testing if I can get a connection to my database or network, which fails, NUnit is not smart enough to realize that every other test that depends on that connection is going to fail. Sometimes, it won’t be immediately obvious from the 50 failed tests that something low level like that is the result, in which case I might spend some time trying to fix the wrong test. Running unit tests should be like compiling code. Every experienced programmer knows that you go for the first one or two errors, not the last ones, because most of the time when you correct a couple of bugs at the top, a whole lot of compilation errors further down in the source will disappear.

Speaking of compilation, a great compilation tool that most NUnit folks are familiar with is [NAnt](http://nant.sourceforge.net/). It manages the build process, making it relatively painless to configure separate types of builds, run tests, deploy production code, etc. NAnt has a concept of tasks which can be specified as being dependent on one another. When a task is called, NAnt will call all of its dependencies (and theirs, recursively) before executing the specified task. If any dependent task fails, the build will fail and exit. This model would work amazingly well for unit testing. Instead of having dozens of tests fail whenever a low level function fails, dependencies and test abortion on failure would make it trivial to locate the root cause of such failures. The implementation could be as simple as a couple more attributes, such as DependsOn and AbortTestsOnFailure. With these, it would be possible to write tests that one could be certain ran in a particular order. Optionally, NUnit could include a user preference StopTestsOnFirstFailure=true|false. The DependsOn attribute could also be applied to classes/suites, and NUnit would need to perform a test for circular dependencies at both levels as part of its initialization.

Another implementation option would be to specify the test dependencies and/or order in a configuration file, but my personal preference would be to keep everything in the attributes rather than add complexity to NUnit’s architecture.

An example TestSuite using these features:

<!--EndFragment-->

```
<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  1</SPAN> [TestSuite]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  2</SPAN> <SPAN style="COLOR: blue">class</SPAN> DataTest

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  3</SPAN> {

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  4</SPAN>     [Test]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  5</SPAN>     [AbortTestsOnFailure]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  6</SPAN>     <SPAN style="COLOR: blue">public</SPAN> <SPAN style="COLOR: blue">void</SPAN> TestConnection()

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  7</SPAN>     {

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  8</SPAN>        <SPAN style="COLOR: green">// Assert connection can be opened

</SPAN><SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey">  9</SPAN>     }

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 10</SPAN>

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 11</SPAN>     [Test]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 12</SPAN>     [DependsOn(<SPAN style="COLOR: maroon">"TestConnection"</SPAN>)]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 13</SPAN>     <SPAN style="COLOR: blue">public</SPAN> <SPAN style="COLOR: blue">void</SPAN> CreateOrderItem()

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 14</SPAN>     {

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 15</SPAN>        <SPAN style="COLOR: green">// assert record is created without error

</SPAN><SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 16</SPAN>     }

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 17</SPAN>

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 18</SPAN>     [Test]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 19</SPAN>     [DependsOn(<SPAN style="COLOR: maroon">"CreateOrderItem"</SPAN>)]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 20</SPAN>     <SPAN style="COLOR: blue">public</SPAN> <SPAN style="COLOR: blue">void</SPAN> ReadOrderItem()

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 21</SPAN>     {

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 22</SPAN>       <SPAN style="COLOR: green">// assert that record can be read correctly

</SPAN><SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 23</SPAN>     }

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 24</SPAN>

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 25</SPAN>     [Test]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 26</SPAN>     [DependsOn(<SPAN style="COLOR: maroon">"ReadOrderItem"</SPAN>)]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 27</SPAN>     <SPAN style="COLOR: blue">public</SPAN> <SPAN style="COLOR: blue">void</SPAN> UpdateOrderItem()

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 28</SPAN>     {

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 29</SPAN>        <SPAN style="COLOR: green">// assert that record is updated correctly

</SPAN><SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 30</SPAN>     }

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 31</SPAN>

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 32</SPAN>     [Test]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 33</SPAN>     [DependsOn(<SPAN style="COLOR: maroon">"UpdateOrderItem"</SPAN>)]

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 34</SPAN>     <SPAN style="COLOR: blue">public</SPAN> <SPAN style="COLOR: blue">void</SPAN> DeleteOrderItem()

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 35</SPAN>     {

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 36</SPAN>        <SPAN style="COLOR: green">// assert that record is deleted correctly

</SPAN><SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 37</SPAN>     }

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 38</SPAN> }

<SPAN style="COLOR: teal; BACKGROUND-COLOR: lightgrey"> 39</SPAN> 
<EM><FONT face=Tahoma><STRONG>Updated:</STRONG> I was a bit frustrated with some side conversations I had just had when I first wrote this -- <BR></FONT><FONT face=Tahoma>I just removed some unnecessarily harsh points.</FONT></EM>
```