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
In [part one](/ifilesystem-dependency-inversion-part-1)I described the problem. In [part two](/ifilesystem-dependency-inversion-part-2)I worked out the details of how to save files in a platform-ignorant way by creating a spike solution. Now I’m looking back at my *original ugly method* from part one and extracting it into its own class that accepts an **IFileSystem** instance via constructor injection.

Looking at the original method, it has a number of dependencies and issues. My next step is going to be to get it out of the untestable ASP.NET codebehind file and into a separate class. Doing so is going to require me to replace all global references with method parameters or properties on whatever class I create. Here’s my first pass at things I need to do (click to enlarge):

![file system references](/img/file-system-references.png)

This method processes an uploaded media file for an advertising campaign. In the domain of advertising, such files are referred to as*creatives*. I can see that it has several dependencies related to the posted file itself. I think what I want to do next is make a CreativeFile class that represents this file. It should know things like the FileName and the byte\[] array representing the file itself, and it might be handy if it could be constructed from an HttpPostedFile, since that’s what I’m starting with in this case. I might use such a file like so:

```csharp
var myCreativeFile = new CreativeFile();
 myCreativeFile.FileName = "image.gif";
 myCreativeFile.Bytes = GetBytes();
```

I don’t think I need much more than this at the moment, so let’s test it and get the test to pass:

```csharp
   1: [TestClass]
   2: public class CreativeFileTester
   3: {
   4:     public readonly string TEST_FILE_NAME = "image.gif";
   5:     public readonly byte[] TEST_BYTES = new byte[10];
   6:  
   7:     [TestMethod]
   8:     public void Create_CreativeFile()
   9:     {
  10:         var myCreativeFile = new CreativeFile();
  11:         myCreativeFile.FileName = TEST_FILE_NAME;
  12:         myCreativeFile.Bytes = TEST_BYTES;
  13:  
  14:         Assert.IsNotNull(myCreativeFile);
  15:         Assert.AreEqual(TEST_FILE_NAME, myCreativeFile.FileName);
  16:         Assert.AreEqual(TEST_BYTES, myCreativeFile.Bytes);
  17:     }
  18: }
  19:  
  20: public class CreativeFile
  21: {
  22:     public string FileName { get; set; }
  23:     public byte[] Bytes { get; set; }
  24: }
```

There’s not much to this class yet. It looks like something else it should probably know how to do is generate its own filename to use when we save it. Currently the code for this looks like this:

```csharp
   1: private void GetImageOrFlashData()
   2: {
   3:     string fileExt = ImageOrFlashUpload.FileName.Substring(ImageOrFlashUpload.FileName.LastIndexOf('.'));
   4:     MyCreative.CreativeUrl = DateTime.Now.Ticks.ToString() + fileExt;
   5: // snip
   6: }
```

I think it would make sense to be able to ask this class to generate a filename, and if whatever algorithm it uses depends on a DateTime, then that dependency should be passed into the method. Let’s write a test. First, we need a way to get the file extension. A quick test of the simple case and some copying of the existing code yields:

```csharp
   1: // test
   2: [TestMethod]
   3: public void FileExtension_Returns_DotGif_For_Standard_Test_File()
   4: {
   5:     var myCreativeFile = new CreativeFile();
   6:     myCreativeFile.FileName = TEST_FILE_NAME;
   7:     myCreativeFile.Bytes = TEST_BYTES;
   8:  
   9:     string extension = myCreativeFile.GetFileExtension();
  10:  
  11:     Assert.AreEqual(".gif", extension);
  12: }
  13:  
  14: // method in CreativeFile
  15: public string GetFileExtension()
  16: {
  17:     return FileName.Substring(FileName.LastIndexOf('.'));
  18: }
```

Make a note to remove the duplication of setting up the test CreativeFile in each test, and to test some less-happy scenarios like when FileName is null or doesn’t have any “.” characters in it. For now we move on to generating the filename. For this we’ll pass in a DateTime (no need to use an interface) and pull the ticks from it rather than explicitly using DateTime.Now – this will let us test the method. First the test:

```csharp
   1: public readonly DateTime TEST_DATE = new DateTime(2009, 1, 1);
   2: public readonly long TEST_TICKS = 633663648000000000;
   3:  
   4: [TestMethod]
   5: public void GenerateStandardFileName_Returns_Ticks_Plus_Extension()
   6: {
   7:     var myCreativeFile = new CreativeFile();
   8:     myCreativeFile.FileName = TEST_FILE_NAME;
   9:     string standardFileName = myCreativeFile.GenerateStandardFileName(TEST_DATE);
  10:     string expectedFileName = TEST_TICKS + ".gif";
  11:     Assert.AreEqual(expectedFileName, standardFileName);
  12: }
  13:  
```

It fails the first time (after I generate the method so it will compile). Implement the method as follows to get a passing test:

```csharp
   1: public string GenerateStandardFileName(DateTime time)
   2: {
   3:     return time.Ticks + GetFileExtension();
   4: }
```

## Bringing It All Together

I’m still not 100% sure exactly where all the logic for performing the file system work will go, but now I know how to define a CreativeFile and it knows how to generate its name. I can refactor my original ugly method with this (now tested) code to yield the following:

```csharp
   1: private void GetImageOrFlashData()
   2: {
   3:     var myCreativeFile = new CreativeFile
   4:                              {
   5:                                  FileName = ImageOrFlashUpload.FileName,
   6:                                  Bytes = ImageOrFlashUpload.FileBytes
   7:                              };
   8:  
   9:     MyCreative.CreativeUrl = myCreativeFile.GenerateStandardFileName(DateTime.Now);
  10: // snip
  11: }
```

There’s still a DateTime.Now in the code, but the actual logic of generating the filename no longer has that system clock dependency (we were able to test it with an arbitrary DateTime). And we’ve removed a few instances of the `HttpPostedFile`. It’s a little bit of progress. Since this has grown long, we’ll save the `IFileSystem` stuff for the next part, when we’ll need to come up with some kind of object whose responsibility is the persistence of CreativeFiles to some kind of file system.
