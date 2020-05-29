---
templateKey: blog-post
title: IFileSystem Dependency Inversion Part 5
path: blog-post
date: 2008-12-10T10:11:00.000Z
description: "Where I left off, I’d managed to create a new class for handling
  the storage of my creative files, called CreativeFileStore. This method took
  in an IFileSystem as a parameter to its constructor, which provides two
  benefits:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IFileSystem
category:
  - Uncategorized
comments: true
share: true
---
The saga began [here](/ifilesystem-dependency-inversion-part-1).

Where I left off, I’d managed to create a new class for handling the storage of my creative files, called*CreativeFileStore*. This method took in an **IFileSystem** as a parameter to its constructor, which provides two benefits:

* Testability
* Flexibility – I can swap between **WindowsFileSystem** and **AmazonS3FileSystem** easily

In the interest of keeping the individual posts at a reasonable size, I didn’t include all the tests for the CreativeFileStore, but here’s a summary:

```
<span style="color: #606060">   1:</span> [TestMethod]
<span style="color: #606060">   2:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Create_CreativeFileStore(){}
<span style="color: #606060">   3:</span>  
<span style="color: #606060">   4:</span> [TestMethod]
<span style="color: #606060">   5:</span> [ExpectedException(<span style="color: #0000ff">typeof</span> (IOException))]
<span style="color: #606060">   6:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile_Fails_If_File_Already_Exists(){}
<span style="color: #606060">   7:</span>  
<span style="color: #606060">   8:</span> [TestMethod]
<span style="color: #606060">   9:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile_Calls_WriteBinaryFile_When_No_Dimensions_Passed(){}
<span style="color: #606060">  10:</span> [TestMethod]
<span style="color: #606060">  11:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile_Calls_WriteBinaryFile_When_Dimensions_Passed_But_File_Is_Not_Image()
<span style="color: #606060">  12:</span> {}
<span style="color: #606060">  13:</span>  
<span style="color: #606060">  14:</span> [TestMethod]
<span style="color: #606060">  15:</span> [ExpectedException(<span style="color: #0000ff">typeof</span> (ApplicationException))]
<span style="color: #606060">  16:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile_Throws_Exception_When_Incorrect_Dimensions_Passed(){}
<span style="color: #606060">  17:</span>  
<span style="color: #606060">  18:</span> [TestMethod]
<span style="color: #606060">  19:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile_Calls_WriteBinaryFile_When_Dimensions_Passed_And_Image_Is_Correct_Size()
<span style="color: #606060">  20:</span> {}
```

In the last post, when I finished up there was a nasty call to **FormatAndSaveUploadedImage**() that was failing. I wrapped up by commenting it out and just saving the image (without validating its size), which was obviously not a long term solution. That method call goes to a fairly old and procedural library of static calls, and in this case it’s trying to do way too much and is completely violating [SRP](http://www.c2.com/cgi/wiki?SingleResponsibilityPrinciple). I decided to fix it – the original method isn’t worth describing here.

I decided that validating the height and width of an image file was worthy of its own class, so I created a simple ImageValidator class that implements its very own IImageValidator interface (you’ll see why in a moment). The interface looks like this:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">interface</span> IImageValidator
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">int</span> ExpectedHeight { get; set; }
<span style="color: #606060">   4:</span>     <span style="color: #0000ff">int</span> ExpectedWidth { get; set; }
<span style="color: #606060">   5:</span>     System.Drawing.Image ImageToValidate { get; set; }
<span style="color: #606060">   6:</span>  
<span style="color: #606060">   7:</span>     <span style="color: #0000ff">void</span> SetImageFromBytes(<span style="color: #0000ff">byte</span>[] imageToValidate);
<span style="color: #606060">   8:</span>     <span style="color: #0000ff">bool</span> IsExpectedHeight();
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">bool</span> IsExpectedWidth();
<span style="color: #606060">  10:</span>     <span style="color: #0000ff">bool</span> IsExpectedDimensions();
<span style="color: #606060">  11:</span> }
```

The only interesting code from the ImageValidator is here:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> IsExpectedHeight()
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">if</span>(ImageToValidate == <span style="color: #0000ff">null</span>)
<span style="color: #606060">   4:</span>     {
<span style="color: #606060">   5:</span>         <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ArgumentNullException(<span style="color: #006080">"ImageToValidate"</span>, 
<span style="color: #606060">   6:</span> <span style="color: #006080">"ImageToValidate property must be specified."</span>);
<span style="color: #606060">   7:</span>     }
<span style="color: #606060">   8:</span>     <span style="color: #0000ff">float</span> imageHeight = ImageToValidate.PhysicalDimension.Height;
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">if</span> (imageHeight != ExpectedHeight) <span style="color: #0000ff">return</span> <span style="color: #0000ff">false</span>;
<span style="color: #606060">  10:</span>  
<span style="color: #606060">  11:</span>     <span style="color: #0000ff">return</span> <span style="color: #0000ff">true</span>;
<span style="color: #606060">  12:</span> }
<span style="color: #606060">  13:</span>  
<span style="color: #606060">  14:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> IsExpectedWidth()
<span style="color: #606060">  15:</span> {
<span style="color: #606060">  16:</span>     <span style="color: #0000ff">if</span> (ImageToValidate == <span style="color: #0000ff">null</span>)
<span style="color: #606060">  17:</span>     {
<span style="color: #606060">  18:</span>         <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ArgumentNullException(<span style="color: #006080">"ImageToValidate"</span>, 
<span style="color: #606060">  19:</span> <span style="color: #006080">"ImageToValidate property must be specified."</span>);
<span style="color: #606060">  20:</span>     }
<span style="color: #606060">  21:</span>     <span style="color: #0000ff">float</span> imageWidth = ImageToValidate.PhysicalDimension.Width;
<span style="color: #606060">  22:</span>     <span style="color: #0000ff">if</span> (imageWidth != ExpectedWidth) <span style="color: #0000ff">return</span> <span style="color: #0000ff">false</span>;
<span style="color: #606060">  23:</span>  
<span style="color: #606060">  24:</span>     <span style="color: #0000ff">return</span> <span style="color: #0000ff">true</span>;
<span style="color: #606060">  25:</span> }
<span style="color: #606060">  26:</span>  
<span style="color: #606060">  27:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> IsExpectedDimensions()
<span style="color: #606060">  28:</span> {
<span style="color: #606060">  29:</span>     <span style="color: #0000ff">return</span> IsExpectedHeight() && IsExpectedWidth();
<span style="color: #606060">  30:</span> }
```

Now the WriteFile() method can simply do the validation itself, rather than rely on it happening within a rather long and cumbersome (and untestable) static method:

```
<span style="color: #606060">   1:</span> _imageValidator.SetImageFromBytes(creativeFile.Bytes);
<span style="color: #606060">   2:</span> _imageValidator.ExpectedHeight = expectedHeightWidth.FirstValue;
<span style="color: #606060">   3:</span> _imageValidator.ExpectedWidth = expectedHeightWidth.SecondValue;
<span style="color: #606060">   4:</span>  
<span style="color: #606060">   5:</span> <span style="color: #0000ff">if</span> (!_imageValidator.IsExpectedDimensions())
<span style="color: #606060">   6:</span> {...}
<span style="color: #606060">   7:</span>     
```

Note that to make this work, we need to inject the dependency on IImageValidator via the constructor (or the method). We were already doing this with the IFileSystem – the complete code for the **CreativeFileStore** is shown here:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CreativeFileStore
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> IFileSystem _fileSystem;
<span style="color: #606060">   4:</span>     <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> IImageValidator _imageValidator;
<span style="color: #606060">   5:</span>  
<span style="color: #606060">   6:</span>     <span style="color: #0000ff">public</span> CreativeFileStore() : 
<span style="color: #606060">   7:</span>         <span style="color: #0000ff">this</span>(<span style="color: #0000ff">new</span> WindowsFileSystem(), <span style="color: #0000ff">new</span> ImageValidator()) { }
<span style="color: #606060">   8:</span>  
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">public</span> CreativeFileStore(IFileSystem fileSystem, 
<span style="color: #606060">  10:</span>         IImageValidator imageValidator)
<span style="color: #606060">  11:</span>     {
<span style="color: #606060">  12:</span>         <span style="color: #0000ff">this</span>._fileSystem = fileSystem;
<span style="color: #606060">  13:</span>         <span style="color: #0000ff">this</span>._imageValidator = imageValidator;
<span style="color: #606060">  14:</span>     }
<span style="color: #606060">  15:</span>  
<span style="color: #606060">  16:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile(CreativeFile creativeFile, 
<span style="color: #606060">  17:</span> Tuple&lt;<span style="color: #0000ff">int</span>, <span style="color: #0000ff">int</span>&gt; expectedHeightWidth, DateTime time)
<span style="color: #606060">  18:</span>     {
<span style="color: #606060">  19:</span>         <span style="color: #0000ff">string</span> fileName = creativeFile.GenerateStandardFileName(time);
<span style="color: #606060">  20:</span>  
<span style="color: #606060">  21:</span>         <span style="color: #0000ff">if</span> (_fileSystem.FileExists(fileName))
<span style="color: #606060">  22:</span>         {
<span style="color: #606060">  23:</span>             <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> IOException(
<span style="color: #606060">  24:</span> <span style="color: #006080">@"An error occurred which did not allow the uploading of your file. "</span> +
<span style="color: #606060">  25:</span> <span style="color: #006080">@"Please try again or contact your account manager."</span>);
<span style="color: #606060">  26:</span>         }
<span style="color: #606060">  27:</span>  
<span style="color: #606060">  28:</span>         <span style="color: #008000">// if it's an image and we have expected dimensions, </span>
<span style="color: #606060">  29:</span>         <span style="color: #008000">//validate it and throw if it is invalid</span>
<span style="color: #606060">  30:</span>         <span style="color: #0000ff">if</span> (CreativeType.GetTypeFromExtension(
<span style="color: #606060">  31:</span> creativeFile.GetFileExtension()) == CreativeTypes.Image &&
<span style="color: #606060">  32:</span> expectedHeightWidth != <span style="color: #0000ff">null</span>)
<span style="color: #606060">  33:</span>         {
<span style="color: #606060">  34:</span>             _imageValidator.SetImageFromBytes(creativeFile.Bytes);
<span style="color: #606060">  35:</span>             _imageValidator.ExpectedHeight = expectedHeightWidth.FirstValue;
<span style="color: #606060">  36:</span>             _imageValidator.ExpectedWidth = expectedHeightWidth.SecondValue;
<span style="color: #606060">  37:</span>  
<span style="color: #606060">  38:</span>             <span style="color: #0000ff">if</span> (!_imageValidator.IsExpectedDimensions())
<span style="color: #606060">  39:</span>             {
<span style="color: #606060">  40:</span>                 <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ApplicationException(
<span style="color: #606060">  41:</span>                                     <span style="color: #0000ff">string</span>.Format(
<span style="color: #606060">  42:</span> <span style="color: #006080">@"There was a problem uploading your image. Please verify that the width 
<span style="color: #606060">  43:</span> height of the image you're uploading are exactly {0} x {1} pixels."</span>,
<span style="color: #606060">  44:</span> expectedHeightWidth.SecondValue, expectedHeightWidth.FirstValue));
<span style="color: #606060">  45:</span>             }
<span style="color: #606060">  46:</span>         }
<span style="color: #606060">  47:</span>         _fileSystem.WriteBinaryFile(creativeFile.Bytes, fileName);
<span style="color: #606060">  48:</span>     }
<span style="color: #606060">  49:</span> }
```

Since we’re using interfaces and DI, we’re not only able to swap out our file system (or validation logic), we’re also able to easily test scenarios that would otherwise involve complex setup. For instance, as I was wrapping up this exercise I thought it would be good to have a test showing what should happen when the image is of the expected height and width. In that case, the file should be written. Using the original static method, the only way I could get it to write the file would be to ensure that the actual byte array I passed it was a valid image file of the expected size. By refactoring to introduce an IImageValidator, I was able to test this case using the following code (which uses [Rhino Mocks](http://ayende.com/wiki/Rhino+Mocks.ashx)):

```
<span style="color: #606060">   1:</span> [TestMethod]
<span style="color: #606060">   2:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile_Calls_WriteBinaryFile_When_Dimensions_Passed_And_Image_Is_Correct_Size()
<span style="color: #606060">   3:</span> {
<span style="color: #606060">   4:</span>     Expect.Call(myFileSystem.FileExists(CreativeFileTester.TEST_FILE_NAME)).IgnoreArguments().Return(<span style="color: #0000ff">false</span>);
<span style="color: #606060">   5:</span>     Expect.Call(myImageValidator.IsExpectedDimensions()).IgnoreArguments().Return(<span style="color: #0000ff">true</span>);
<span style="color: #606060">   6:</span>     Expect.Call(<span style="color: #0000ff">delegate</span> { myFileSystem.WriteBinaryFile(CreativeFileTester.TEST_BYTES, <span style="color: #006080">""</span>); }).IgnoreArguments();
<span style="color: #606060">   7:</span>  
<span style="color: #606060">   8:</span>     mocks.ReplayAll();
<span style="color: #606060">   9:</span>     var myFileStore = <span style="color: #0000ff">new</span> CreativeFileStore(myFileSystem, myImageValidator);
<span style="color: #606060">  10:</span>     CreativeFile myCreativeFile = CreativeFileTester.GetTestCreativeFile();
<span style="color: #606060">  11:</span>     var expectedHeightWidth = <span style="color: #0000ff">new</span> Tuple&lt;<span style="color: #0000ff">int</span>, <span style="color: #0000ff">int</span>&gt;(10, 10);
<span style="color: #606060">  12:</span>  
<span style="color: #606060">  13:</span>     myFileStore.WriteFile(myCreativeFile, expectedHeightWidth, CreativeFileTester.TEST_DATE);
<span style="color: #606060">  14:</span>     mocks.VerifyAll();
<span style="color: #606060">  15:</span> }

```

**Return To The Ugly Method**

In the last part of this series, the **GetImageOrFlashData**() method was down to 20 lines. I decided to move the folder creation code to it, and now there’s a little bit of setup code to create the necessary objects to do the work, but it’s still much smaller than it was, and much easier to follow. The name isn’t great, though, so I think one last refactoring before we call it a day is to rename it to ***SaveCreativeFile***, since that’s really what it’s doing.

**SaveCreativeFile**:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> SaveCreativeFile()
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile
<span style="color: #606060">   4:</span>     {
<span style="color: #606060">   5:</span>         FileName = ImageOrFlashUpload.FileName,
<span style="color: #606060">   6:</span>         Bytes = ImageOrFlashUpload.FileBytes
<span style="color: #606060">   7:</span>     };
<span style="color: #606060">   8:</span>  
<span style="color: #606060">   9:</span>     var myFileSystem = <span style="color: #0000ff">new</span> WindowsFileSystem();
<span style="color: #606060">  10:</span>     
<span style="color: #606060">  11:</span>     var myCreativeFileStore = <span style="color: #0000ff">new</span> CreativeFileStore(myFileSystem, 
<span style="color: #606060">  12:</span> <span style="color: #0000ff">new</span> ImageValidator());
<span style="color: #606060">  13:</span>     <span style="color: #0000ff">try</span>
<span style="color: #606060">  14:</span>     {
<span style="color: #606060">  15:</span>         <span style="color: #008000">// Ensure Destination Folder Exists</span>
<span style="color: #606060">  16:</span>         <span style="color: #0000ff">string</span> directoryLocation = 
<span style="color: #606060">  17:</span> LQPro

motionServerConfig.Settings.TemporaryCreativeBaseFilePath;
<span style="color: #606060">  18:</span>         <span style="color: #0000ff">if</span> (!myFileSystem.DirectoryExists(directoryLocation))
<span style="color: #606060">  19:</span>         {
<span style="color: #606060">  20:</span>             myFileSystem.CreateDirectory(directoryLocation);
<span style="color: #606060">  21:</span>         }
<span style="color: #606060">  22:</span>         myFileSystem.StorageFolderPath = directoryLocation;
<span style="color: #606060">  23:</span>  
<span style="color: #606060">  24:</span>         var expectedHeightWidth = <span style="color: #0000ff">new</span> Tuple&lt;<span style="color: #0000ff">int</span>, <span style="color: #0000ff">int</span>&gt;(
<span style="color: #606060">  25:</span> MyCreativeFormat.Height, MyCreativeFormat.Width);
<span style="color: #606060">  26:</span>         myCreativeFileStore.WriteFile(myCreativeFile, 
<span style="color: #606060">  27:</span> expectedHeightWidth, DateTime.Now);
<span style="color: #606060">  28:</span>     }
<span style="color: #606060">  29:</span>     <span style="color: #0000ff">catch</span> (Exception ex)
<span style="color: #606060">  30:</span>     {
<span style="color: #606060">  31:</span>         FileErrorLabel.Text = ex.Message;
<span style="color: #606060">  32:</span>         <span style="color: #0000ff">return</span>;
<span style="color: #606060">  33:</span>     }
<span style="color: #606060">  34:</span> }
```

I added a few line breaks to make it fit the blog better – it’s about 30 lines in Visual Studio. Definitely fits the rule that no method should be longer than can be viewed on the screen at one time (and I’m only on a 1050 line vertical resolution monitor at the moment). Having longer methods makes it much more difficult to grok what’s going on, and is almost always a sign that the method is trying to do too much.

In fact, just to add one \*last\* refactoring to this, let me point out another sign — comments. Often comments are a sign that what you really want to do is refactor, often with an Extract Method. The only comment I have left in the above code says “Ensure Destination Folder Exists”. So… why do I need that when I could extract to a method called EnsureFolderExists(foldername)?

Something like this:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> EnsureFolderExists(IFileSystem myFileSystem, <span style="color: #0000ff">string</span> directoryLocation)
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">if</span> (!myFileSystem.DirectoryExists(directoryLocation))
<span style="color: #606060">   4:</span>     {
<span style="color: #606060">   5:</span>         myFileSystem.CreateDirectory(directoryLocation);
<span style="color: #606060">   6:</span>     }
<span style="color: #606060">   7:</span> }
```

This adds 7 lines to my total LOC for the file, but takes away 3 lines and, more importantly, the need for a comment, in the other method.

Now to write my **AmazonS3FileSystem** and see if we really can just flip a switch and use another service to host our files…