---
templateKey: blog-post
title: If Writing An Object That Is IDisposable, Dont Fail During Construction
path: blog-post
date: 2011-02-02T10:07:00.000Z
description: There’s a great pattern for ensuring that unmanaged resources are
  cleaned up in the .NET world. It’s called the Disposable pattern and it
  applies to any resource that implements the Disposable interface.
featuredpost: false
featuredimage: /img/java-script.png
tags:
  - .net
  - C#
category:
  - Software Development
comments: true
share: true
---
There’s a great pattern for ensuring that unmanaged resources are cleaned up in the .NET world. It’s called the Disposable pattern and it applies to any resource that implements the [IDisposable](http://msdn.microsoft.com/en-us/library/system.idisposable.aspx) interface. If you are writing an object that directly deals with unmanaged resources, such as files, database connections, network sockets, fonts, etc., then [you are well advised to implement IDisposable](http://msdn.microsoft.com/en-us/library/ms244737(v=vs.80).aspx) and ensure your resources are cleaned up in your class’s Dispose() method. Having followed this pattern, you’ll allow client code to clean up after itself by calling Dispose() as soon as they are finished with the resources your class uses, rather than waiting for the garbage collector, which could take a long and indeterminate amount of time. Further, nice constructs like the using() statement make it relatively easy to deal with IDisposable objects in a clean fashion. You can even stack using() statements if you happen to be using multiple IDisposable objects together, which is not uncommon in data access code, like this:

```
<span style="color: #0000ff">using</span> (SqlConnection myConnection = <span style="color: #0000ff">new</span> SqlConnection(connectionString))<br /><span style="color: #0000ff">using</span> (SqlCommand myCommand = <span style="color: #0000ff">new</span> SqlCommand(query, myConnection))<br />{<br />    myConnection.Open();<br />    <span style="color: #0000ff">using</span> (SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection))<br />    {<br />        <span style="color: #0000ff">while</span> (myReader.Read())<br />        {<br />            Console.WriteLine(myReader[1]);<br />        }<br />        myReader.Close();<br />    }<br />    myConnection.Close();<br />}<br />
```

As you can see, there are three different IDisposable objects in play here, and each one is properly wrapped in its own using() block. The code is relatively tidy, with no extra lines of code (not counting the { } lines) from the using() statements since we would have had to declare the objects anyway. And by stacking the first two using() statements together, we saved one level of indenting, making the code somewhat easier to follow as well.

This is all great , but the point of this article is to describe a scenario in which the using() statement can fail. In fact, it’s not the fault of using() – writing a try-catch-finally and calling Dispose() in the finally fails as well in this scenario. The problem is, what happens if the IDisposable object throws an exception during its construction?

Consider this IDisposable object, which is intentionally degenerate ([see here for correct implementation of IDisposable](http://msdn.microsoft.com/en-us/library/system.idisposable.aspx)):

**DisposableObject.cs**

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> DisposableObject : IDisposable<br />{<br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">int</span> DisposeCount;<br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">int</span> CreateCount;<br />    <span style="color: #0000ff">public</span> DisposableObject(<span style="color: #0000ff">bool</span> fail)<br />    {<br />        CreateCount++;<br />        <span style="color: #008000">// allocate some expensive resources</span><br />        <span style="color: #0000ff">if</span> (fail)<br />        {<br />            <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ArgumentException(<span style="color: #006080">&quot;Bad stuff happened.&quot;</span>);<br />        }<br />    }<br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Dispose()<br />    {<br />        DisposeCount++;<br />    }<br />}<br />
```

Now, consider the following test, which calls the object with a using() statement:

```
[TestMethod]<br /><span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> UsingFail()<br />{<br />    Assert.AreEqual(0, DisposableObject.CreateCount);<br />    Assert.AreEqual(0, DisposableObject.DisposeCount);<br />    <span style="color: #0000ff">try</span><br />    {<br />        <span style="color: #0000ff">using</span> (var disp1 = <span style="color: #0000ff">new</span> DisposableObject(<span style="color: #0000ff">true</span>))<br />        {<br />            <span style="color: #008000">// do stuff</span><br />        }<br />    }<br />    <span style="color: #0000ff">catch</span> (Exception)<br />    {<br />        <span style="color: #008000">// gulp</span><br />    }<br />    Assert.AreEqual(DisposableObject.CreateCount, DisposableObject.DisposeCount);<br />}<br />
```

Note that you have to run this test singly – if you run it with other tests they will step on each other’s global state in the form of the static counters.

**Result: Assert.AreEqual failed. Expected:<1>. Actual:<0>.**

What if we use a try-catch block instead, does that save us? Here’s a test showing that case:

```
[TestMethod]<br /><span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> TryFinallyDisposeFail()<br />{<br />    Assert.AreEqual(0, DisposableObject.CreateCount);<br />    Assert.AreEqual(0, DisposableObject.DisposeCount);<br />    DisposableObject disp1 = <span style="color: #0000ff">null</span>;<br />    <span style="color: #0000ff">try</span><br />    {<br />        disp1 = <span style="color: #0000ff">new</span> DisposableObject(<span style="color: #0000ff">true</span>);<br />        <span style="color: #008000">// do stuff</span><br />    }<br />    <span style="color: #0000ff">catch</span> (Exception)<br />    {<br />        <span style="color: #008000">// gulp</span><br />    }<br />    <span style="color: #0000ff">finally</span><br />    {<br />        <span style="color: #0000ff">if</span> (disp1 != <span style="color: #0000ff">null</span>)<br />        {<br />            disp1.Dispose();<br />        }<br />    }<br />    Assert.AreEqual(DisposableObject.CreateCount, DisposableObject.DisposeCount);<br />}<br />
```

The result in this case is the same:

**Result: Assert.AreEqual failed. Expected:<1>. Actual:<0>.**

Let’s look at a real example and the consequences of this behavior. Consider a class that makes use of a file. We’ll call the class FileOpenerObject or FOO. This time we’re using the full Dispose implementation, per the docs:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> FileOpenerObject : IDisposable<br />{<br />    <span style="color: #0000ff">private</span> FileStream _fileStream;<br />    <span style="color: #0000ff">private</span> <span style="color: #0000ff">bool</span> disposed;<br />    <span style="color: #0000ff">public</span> FileOpenerObject(<span style="color: #0000ff">string</span> filepath, <span style="color: #0000ff">bool</span> fail)<br />    {<br />        _fileStream = File.OpenRead(filepath);<br />        <span style="color: #0000ff">if</span> (fail)<br />        {<br />            <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ApplicationException(<span style="color: #006080">&quot;Bad stuff happened.&quot;</span>);<br />        }<br />    }<br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> GetName()<br />    {<br />        <span style="color: #0000ff">return</span> _fileStream.Name;<br />    }<br /><br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Dispose()<br />    {<br />        Dispose(<span style="color: #0000ff">true</span>);<br />        GC.SuppressFinalize(<span style="color: #0000ff">this</span>);<br />    }<br /><br />    <span style="color: #0000ff">protected</span> <span style="color: #0000ff">virtual</span> <span style="color: #0000ff">void</span> Dispose(<span style="color: #0000ff">bool</span> disposing)<br />    {<br />        <span style="color: #0000ff">if</span> (!<span style="color: #0000ff">this</span>.disposed)<br />        {<br />            <span style="color: #0000ff">if</span> (disposing)<br />            {<br />                <span style="color: #008000">// dispose of managed resources</span><br />                _fileStream.Dispose();<br />            }<br />            disposed = <span style="color: #0000ff">true</span>;<br />        }<br />    }<br />}<br />
```

The important part of the above code is all in the constructor. Note that we allocate a resource that itself implemented IDisposable, and thus we need to be responsible for cleaning it up. The same would also hold true if we were directly working with unmanaged resources. The second argument in the constructor is a boolean flag used for testing – when it’s true, Bad Stuff Happens™.

So let’s test this. We want to test the happy path, and the sad path. First, let’s see how things go if everything works.

```
[TestMethod]<br /><span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> FileOpenerWorksWithoutException()<br />{<br />    <span style="color: #0000ff">string</span> filepath = <span style="color: #006080">@&quot;C:DevScratchTestFile.txt&quot;</span>;<br />    <span style="color: #0000ff">using</span> (File.CreateText(filepath))<br />    {<br />    }<br />    <span style="color: #0000ff">using</span> (var foo = <span style="color: #0000ff">new</span> FileOpenerObject(filepath, <span style="color: #0000ff">false</span>))<br />    {<br />        Console.WriteLine(foo.GetName());<br />    }<br />    <span style="color: #008000">// if my filestream is disposed</span><br />    <span style="color: #008000">// I should be able to delete the file now</span><br />    <span style="color: #008000">//System.Threading.Thread.Sleep(3000);</span><br />    File.Delete(filepath);<br />}<br />
```

This works. Test passes (which means nothing blew up since we aren’t asserting anything). Note that this test will fail if you don’t clean up the File.CreateText() call, which is why it, too, is in a using() block.

So now the sad path. What happens if our class doesn’t handle exceptions well in its constructor?

```
[TestMethod]<br /><span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> FileOpenerBlowsUp_LeaksResource()<br />{<br />    <span style="color: #0000ff">string</span> filepath = <span style="color: #006080">@&quot;C:DevScratchTestFile.txt&quot;</span>;<br />    <span style="color: #0000ff">using</span> (File.CreateText(filepath))<br />    {<br />    }<br />    <span style="color: #0000ff">try</span><br />    {<br />        <span style="color: #0000ff">using</span> (var foo = <span style="color: #0000ff">new</span> FileOpenerObject(filepath, <span style="color: #0000ff">true</span>))<br />        {<br />            Console.WriteLine(foo.GetName());<br />        }<br />    }<br />    <span style="color: #0000ff">catch</span> (Exception)<br />    {<br />        <span style="color: #008000">// gulp</span><br />    }<br />    <span style="color: #008000">// if my filestream is disposed</span><br />    <span style="color: #008000">// I should be able to delete the file now</span><br />    File.Delete(filepath);<br />}<br />
```

Note this is the same code, we’re just passing in true to FileOpenerObject() so that it blows up. The result:

> **System.IO.IOException: The process cannot access the file ‘C:DevScratchTestFile.txt’ because it is being used by another process.**
>
> **at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)**
>
>
>
> **at System.IO.File.Delete(String path)**

It’s also worth noting that the first (happy) test takes less than a second, while the second takes about 26 seconds to run. In the meantime, trying to delete the file myself in Windows Explorer resulted in this:

![SNAGHTML5cd1b1c](<> "SNAGHTML5cd1b1c")

**Summary**

If an object that works with unmanaged resources allocates those resources in its constructor, any unhandled exceptions that occur after that point will result in a resource leak. The calling code cannot clean up such resources, and so they will remain allocated until the garbage collector cleans up the object. Thus, if you are the client in this scenario, and the code you’re depending on doesn’t handle exceptions correctly in its constructor, **you’re screwed**. If you’re writing classes that need to be disposed, **Don’t Be That Guy**. Make sure you either do not allocate unmanaged resources in your constructor, or that you are certain that you clean up any such resources in the event that an error takes place.

*Thanks, [Bill Wagner](http://billwagner.cloudapp.net/), for your help in talking this through.*