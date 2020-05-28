---
templateKey: blog-post
title: IFileSystem Dependency Inversion Part 3
path: blog-post
date: 2008-12-09T11:01:00.000Z
description: In part one I described the problem. In part two I worked out the
  details of how to save files in a platform-ignorant way by creating a spike
  solution. Now I’m looking back at my original ugly method from part one and
  extracting it into its own class that accepts an IFileSystem instance via
  constructor injection.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IFileSystem
category:
  - Uncategorized
comments: true
share: true
---
In [part one](http://stevesmithblog.com/blog/ifilesystem-dependency-inversion-part-1)I described the problem. In [part two](http://stevesmithblog.com/blog/ifilesystem-dependency-inversion-part-2)I worked out the details of how to save files in a platform-ignorant way by creating a spike solution. Now I’m looking back at my *original ugly method* from part one and extracting it into its own class that accepts an **IFileSystem** instance via constructor injection.

Looking at the original method, it has a number of dependencies and issues. My next step is going to be to get it out of the untestable ASP.NET codebehind file and into a separate class. Doing so is going to require me to replace all global references with method parameters or properties on whatever class I create. Here’s my first pass at things I need to do (click to enlarge):

[![image](https://stevesmithblog.com/files/media/image/WindowsLiveWriter/IFileSystemDependencyInversionPart3_D46B/image_thumb.png)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/IFileSystemDependencyInversionPart3_D46B/image_2.png)

This method processes an uploaded media file for an advertising campaign. In the domain of advertising, such files are referred to as*creatives*. I can see that it has several dependencies related to the posted file itself. I think what I want to do next is make a CreativeFile class that represents this file. It should know things like the FileName and the byte\[] array representing the file itself, and it might be handy if it could be constructed from an HttpPostedFile, since that’s what I’m starting with in this case. I might use such a file like so:

```
<span style="color: #606060">   1:</span> var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile();
<span style="color: #606060">   2:</span> myCreativeFile.FileName = <span style="color: #006080">"image.gif"</span>;
<span style="color: #606060">   3:</span> myCreativeFile.Bytes = GetBytes();
```

I don’t think I need much more than this at the moment, so let’s test it and get the test to pass:

```
<span style="color: #606060">   1:</span> [TestClass]
<span style="color: #606060">   2:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CreativeFileTester
<span style="color: #606060">   3:</span> {
<span style="color: #606060">   4:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">string</span> TEST_FILE_NAME = <span style="color: #006080">"image.gif"</span>;
<span style="color: #606060">   5:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">byte</span>[] TEST_BYTES = <span style="color: #0000ff">new</span> <span style="color: #0000ff">byte</span>[10];
<span style="color: #606060">   6:</span>  
<span style="color: #606060">   7:</span>     [TestMethod]
<span style="color: #606060">   8:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Create_CreativeFile()
<span style="color: #606060">   9:</span>     {
<span style="color: #606060">  10:</span>         var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile();
<span style="color: #606060">  11:</span>         myCreativeFile.FileName = TEST_FILE_NAME;
<span style="color: #606060">  12:</span>         myCreativeFile.Bytes = TEST_BYTES;
<span style="color: #606060">  13:</span>  
<span style="color: #606060">  14:</span>         Assert.IsNotNull(myCreativeFile);
<span style="color: #606060">  15:</span>         Assert.AreEqual(TEST_FILE_NAME, myCreativeFile.FileName);
<span style="color: #606060">  16:</span>         Assert.AreEqual(TEST_BYTES, myCreativeFile.Bytes);
<span style="color: #606060">  17:</span>     }
<span style="color: #606060">  18:</span> }
<span style="color: #606060">  19:</span>  
<span style="color: #606060">  20:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CreativeFile
<span style="color: #606060">  21:</span> {
<span style="color: #606060">  22:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> FileName { get; set; }
<span style="color: #606060">  23:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">byte</span>[] Bytes { get; set; }
<span style="color: #606060">  24:</span> }
```

There’s not much to this class yet. It looks like something else it should probably know how to do is generate its own filename to use when we save it. Currently the code for this looks like this:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> GetImageOrFlashData()
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">string</span> fileExt = ImageOrFlashUpload.FileName.Substring(ImageOrFlashUpload.FileName.LastIndexOf(<span style="color: #006080">'.'</span>));
<span style="color: #606060">   4:</span>     MyCreative.CreativeUrl = DateTime.Now.Ticks.ToString() + fileExt;
<span style="color: #606060">   5:</span> <span style="color: #008000">// snip</span>
<span style="color: #606060">   6:</span> }
```

I think it would make sense to be able to ask this class to generate a filename, and if whatever algorithm it uses depends on a DateTime, then that dependency should be passed into the method. Let’s write a test. First, we need a way to get the file extension. A quick test of the simple case and some copying of the existing code yields:

```
<span style="color: #606060">   1:</span> <span style="color: #008000">// test</span>
<span style="color: #606060">   2:</span> [TestMethod]
<span style="color: #606060">   3:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> FileExtension_Returns_DotGif_For_Standard_Test_File()
<span style="color: #606060">   4:</span> {
<span style="color: #606060">   5:</span>     var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile();
<span style="color: #606060">   6:</span>     myCreativeFile.FileName = TEST_FILE_NAME;
<span style="color: #606060">   7:</span>     myCreativeFile.Bytes = TEST_BYTES;
<span style="color: #606060">   8:</span>  
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">string</span> extension = myCreativeFile.GetFileExtension();
<span style="color: #606060">  10:</span>  
<span style="color: #606060">  11:</span>     Assert.AreEqual(<span style="color: #006080">".gif"</span>, extension);
<span style="color: #606060">  12:</span> }
<span style="color: #606060">  13:</span>  
<span style="color: #606060">  14:</span> <span style="color: #008000">// method in CreativeFile</span>
<span style="color: #606060">  15:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> GetFileExtension()
<span style="color: #606060">  16:</span> {
<span style="color: #606060">  17:</span>     <span style="color: #0000ff">return<
 
/span> FileName.Substring(FileName.LastIndexOf(<span style="color: #006080">'.'</span>));
<span style="color: #606060">  18:</span> }
```

Make a note to remove the duplication of setting up the test CreativeFile in each test, and to test some less-happy scenarios like when FileName is null or doesn’t have any “.” characters in it. For now we move on to generating the filename. For this we’ll pass in a DateTime (no need to use an interface) and pull the ticks from it rather than explicitly using DateTime.Now – this will let us test the method. First the test:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">readonly</span> DateTime TEST_DATE = <span style="color: #0000ff">new</span> DateTime(2009, 1, 1);
<span style="color: #606060">   2:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">long</span> TEST_TICKS = 633663648000000000;
<span style="color: #606060">   3:</span>  
<span style="color: #606060">   4:</span> [TestMethod]
<span style="color: #606060">   5:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> GenerateStandardFileName_Returns_Ticks_Plus_Extension()
<span style="color: #606060">   6:</span> {
<span style="color: #606060">   7:</span>     var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile();
<span style="color: #606060">   8:</span>     myCreativeFile.FileName = TEST_FILE_NAME;
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">string</span> standardFileName = myCreativeFile.GenerateStandardFileName(TEST_DATE);
<span style="color: #606060">  10:</span>     <span style="color: #0000ff">string</span> expectedFileName = TEST_TICKS + <span style="color: #006080">".gif"</span>;
<span style="color: #606060">  11:</span>     Assert.AreEqual(expectedFileName, standardFileName);
<span style="color: #606060">  12:</span> }
<span style="color: #606060">  13:</span>  
```

It fails the first time (after I generate the method so it will compile). Implement the method as follows to get a passing test:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> GenerateStandardFileName(DateTime time)
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">return</span> time.Ticks + GetFileExtension();
<span style="color: #606060">   4:</span> }
```

**Bringing It All Together**

I’m still not 100% sure exactly where all the logic for performing the file system work will go, but now I know how to define a CreativeFile and it knows how to generate its name. I can refactor my original ugly method with this (now tested) code to yield the following:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> GetImageOrFlashData()
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile
<span style="color: #606060">   4:</span>                              {
<span style="color: #606060">   5:</span>                                  FileName = ImageOrFlashUpload.FileName,
<span style="color: #606060">   6:</span>                                  Bytes = ImageOrFlashUpload.FileBytes
<span style="color: #606060">   7:</span>                              };
<span style="color: #606060">   8:</span>  
<span style="color: #606060">   9:</span>     MyCreative.CreativeUrl = myCreativeFile.GenerateStandardFileName(DateTime.Now);
<span style="color: #606060">  10:</span> <span style="color: #008000">// snip</span>
<span style="color: #606060">  11:</span> }
```

There’s still a DateTime.Now in the code, but the actual logic if generating the filename no longer has that system clock dependency (we were able to test it with an arbitrary DateTime). And we’ve removed a few instances of the HttpPostedFile. It’s a little bit of progess. Since this has grown long, we’ll save the IFileSystem stuff for the next part, when we’ll need to come up with some kind of object whose responsibility is the persistence of CreativeFiles to some kind of file system.