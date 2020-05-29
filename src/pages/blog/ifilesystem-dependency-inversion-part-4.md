---
templateKey: blog-post
title: IFileSystem Dependency Inversion Part 4
path: blog-post
date: 2008-12-09T10:38:00.000Z
description: Now it’s time to take the big step of pulling the main ugly method
  guts out into its own object. Since the main purpose of the method,
  GetImageOrFlashData(), is to store a file that has been uploaded, I’m thinking
  at the moment that the name for the class who will take on this responsibility
  is going to be CreativeFileStore
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IFileSystem
  - WindowsFileSystem
category:
  - Uncategorized
comments: true
share: true
---
Still working on cleaning up some legacy ASP.NET code. Here’s where we are:

* [Part 1](/ifilesystem-dependency-inversion-part-1): Define problem and demonstrate IFileSystem basic version
* [Part 2:](/ifilesystem-dependency-inversion-part-2)Spike solution to support saving files in IFileSystem that works in both Amazon S3 and the Windows file system
* [Part 3](/ifilesystem-dependency-inversion-part-3): Initial refactoring via TDD of big ugly method

Now it’s time to take the big step of pulling the main ugly method guts out into its own object. Since the main purpose of the method, GetImageOrFlashData(), is to store a file that has been uploaded, I’m thinking at the moment that the name for the class who will take on this responsibility is going to be **CreativeFileStore** (a creative is a noun in this context; a creative file is a file representing a creative, not a file that uses its left brain). What should the CreativeFileStore’s interface look like?

* Accepts an IFileSystem in its constructor
* Implements a WriteFile() method with required parameters for the existing method to use it to replace its current functionality.

Since we know our current implementation relies on the System.IO, it’s simple enough to have the class use the WindowsFileSystem by default, resulting in a basic structure like so:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CreativeFileStore
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> IFileSystem _fileSystem;
<span style="color: #606060">   4:</span>    
<span style="color: #606060">   5:</span>     <span style="color: #0000ff">public</span> CreativeFileStore() : <span style="color: #0000ff">this</span>(<span style="color: #0000ff">new</span> WindowsFileSystem()) {}
<span style="color: #606060">   6:</span>  
<span style="color: #606060">   7:</span>     <span style="color: #0000ff">public</span> CreativeFileStore(IFileSystem fileSystem)
<span style="color: #606060">   8:</span>     {
<span style="color: #606060">   9:</span>         <span style="color: #0000ff">this</span>._fileSystem = fileSystem;
<span style="color: #606060">  10:</span>     }
<span style="color: #606060">  11:</span> }
```

We also need to update IFileSystem (and its implementation) to support writing files based on the code we came up with during our [spike solution (in part 2)](/ifilesystem-dependency-inversion-part-2). Here’s the new IFileSystem interface:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">interface</span> IFileSystem
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">bool</span> FileExists(<span style="color: #0000ff">string</span> path);
<span style="color: #606060">   4:</span>     <span style="color: #0000ff">bool</span> DirectoryExists(<span style="color: #0000ff">string</span> path);
<span style="color: #606060">   5:</span>     <span style="color: #0000ff">void</span> CreateDirectory(<span style="color: #0000ff">string</span> path);
<span style="color: #606060">   6:</span>     <span style="color: #0000ff">void</span> MoveFile(<span style="color: #0000ff">string</span> oldPath, <span style="color: #0000ff">string</span> newPath);
<span style="color: #606060">   7:</span>     <span style="color: #0000ff">string</span> ReadAllText(<span style="color: #0000ff">string</span> path);
<span style="color: #606060">   8:</span>     <span style="color: #0000ff">void</span> WriteBinaryFile(<span style="color: #0000ff">byte</span>[] bytes, <span style="color: #0000ff">string</span> savingPath);
<span style="color: #606060">   9:</span> }
```

And here’s the WindowsFileSystem implementation of WriteBinaryFile:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> StorageFolderPath { get; set; }
<span style="color: #606060">   2:</span>  
<span style="color: #606060">   3:</span> <span style="color: #0000ff">public</span> WindowsFileSystem()
<span style="color: #606060">   4:</span> {
<span style="color: #606060">   5:</span>     StorageFolderPath = String.Empty;
<span style="color: #606060">   6:</span> }
<span style="color: #606060">   7:</span>  
<span style="color: #606060">   8:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteBinaryFile(<span style="color: #0000ff">byte</span>[] bytes, <span style="color: #0000ff">string</span> savingPath)
<span style="color: #606060">   9:</span> {
<span style="color: #606060">  10:</span>     <span style="color: #0000ff">using</span> (var writingStream =
<span style="color: #606060">  11:</span>         <span style="color: #0000ff">new</span> FileStream(
<span style="color: #606060">  12:</span>             Path.Combine(StorageFolderPath, savingPath), 
<span style="color: #606060">  13:</span>             FileMode.OpenOrCreate)
<span style="color: #606060">  14:</span>             )
<span style="color: #606060">  15:</span>     {
<span style="color: #606060">  16:</span>         writingStream.Write(bytes, 0, bytes.Length);
<span style="color: #606060">  17:</span>         writingStream.F

lush();
<span style="color: #606060">  18:</span>         writingStream.Close();
<span style="color: #606060">  19:</span>     }
<span style="color: #606060">  20:</span> }
<span style="color: #606060">  21:</span>  
```

We determined in the spike solution that the windows file system would need to know an upload path, so we’ve added a property StorageFolderPath to represent this. It will be up to whatever part of the system creates my implementation of IFileSystem to ensure that any additional properties like this one are properly set. In any event, if a full path is given to WriteBinaryFile, the lack of a StorageFolderPath shouldn’t cause it to fail. That sounds like an assumption – let’s verify with a test, shall we?

Pull out the Path.Combine into a separate method (extract method) which in our case we’ll make protected since nothing outside this class should need it.

**WindowsFileSystem (refactored):**

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteBinaryFile(<span style="color: #0000ff">byte</span>[] bytes, <span style="color: #0000ff">string</span> savingPath)
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">using</span> (var writingStream =
<span style="color: #606060">   4:</span>         <span style="color: #0000ff">new</span> FileStream(
<span style="color: #606060">   5:</span>             GetFilePath(savingPath), 
<span style="color: #606060">   6:</span>             FileMode.OpenOrCreate)
<span style="color: #606060">   7:</span>             )
<span style="color: #606060">   8:</span>     {
<span style="color: #606060">   9:</span>         writingStream.Write(bytes, 0, bytes.Length);
<span style="color: #606060">  10:</span>         writingStream.Flush();
<span style="color: #606060">  11:</span>         writingStream.Close();
<span style="color: #606060">  12:</span>     }
<span style="color: #606060">  13:</span> }
<span style="color: #606060">  14:</span>  
<span style="color: #606060">  15:</span> <span style="color: #0000ff">protected</span> <span style="color: #0000ff">string</span> GetFilePath(<span style="color: #0000ff">string</span> savingPath)
<span style="color: #606060">  16:</span> {
<span style="color: #606060">  17:</span>     <span style="color: #0000ff">return<
 
/span> Path.Combine(StorageFolderPath, savingPath);
<span style="color: #606060">  18:</span> }
```

Then we can test it easily enough by simply subclassing, like so:

**TestWindowsFileSystem**

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> TestWindowsFileSystem : WindowsFileSystem
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> TestGetFilePath(<span style="color: #0000ff">string</span> filePath)
<span style="color: #606060">   4:</span>     {
<span style="color: #606060">   5:</span>         <span style="color: #0000ff">return</span> GetFilePath(filePath);
<span style="color: #606060">   6:</span>     }
<span style="color: #606060">   7:</span> }
```

**Tests**

```
<span style="color: #606060">   1:</span> [TestMethod]
<span style="color: #606060">   2:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> GetFilePath_Returns_Combined_Folder_And_File_Path()
<span style="color: #606060">   3:</span> {
<span style="color: #606060">   4:</span>     <span style="color: #0000ff">string</span> folderPath = <span style="color: #006080">@"C:Foo"</span>;
<span style="color: #606060">   5:</span>     <span style="color: #0000ff">string</span> filePath = <span style="color: #006080">"bar.txt"</span>;
<span style="color: #606060">   6:</span>     <span style="color: #0000ff">string</span> expectedFilePath = <span style="color: #006080">@"C:Foobar.txt"</span>;
<span style="color: #606060">   7:</span>  
<span style="color: #606060">   8:</span>     TestWindowsFileSystem myFileSystem = <span style="color: #0000ff">new</span> TestWindowsFileSystem();
<span style="color: #606060">   9:</span>     myFileSystem.StorageFolderPath = folderPath;
<span style="color: #606060">  10:</span>     Assert.AreEqual(expectedFilePath, myFileSystem.TestGetFilePath(filePath));
<span style="color: #606060">  11:</span>     myFileSystem.StorageFolderPath = folderPath + <span style="color: #006080">@"";
<span style="color: #606060">  12:</span>     Assert.AreEqual(expectedFilePath, myFileSystem.TestGetFilePath(filePath));
<span style="color: #606060">  13:</span> }
<span style="color: #606060">  14:</span>  
<span style="color: #606060">  15:</span> [TestMethod]
<span style="color: #606060">  16:</span> public void GetFilePath_Returns_File_Path_When_No_Folder_Set()
<span style="color: #606060">  17:</span> {
<span style="color: #606060">  18:</span>     string filePath = @"</span>C:Foobar.txt<span style="color: #006080">";
<span style="color: #606060">  19:</span>     string expectedFilePath = @"</span>C:Foobar.txt";
<span style="color: #606060">  20:</span>  
<span style="color: #606060">  21:</span>     TestWindowsFileSystem myFileSystem = <span style="color: #0000ff">new</span> TestWindowsFileSystem();
<span style="color: #606060">  22:</span>     Assert.AreEqual(expectedFilePath, myFileSystem.TestGetFilePath(filePath));
<span style="color: #606060">  23:</span> }
```

These pass, so it sounds like we got this right. Now back to CreativeFileStore, which needs a method for writing files. This method replaces the goo that was in GetImageOrFlashData(), which when we’re done should look pretty much like this:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> GetImageOrFlashData()
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     var myCreativeFile = <span style="color: #0000ff">new</span> CreativeFile
<span style="color: #606060">   4:</span>     {
<span style="color: #606060">   5:</span>         FileName = ImageOrFlashUpload.FileName,
<span style="color: #606060">   6:</span>         Bytes = ImageOrFlashUpload.FileBytes
<span style="color: #606060">   7:</span>     };
<span style="color: #606060">   8:</span>  
<span style="color: #606060">   9:</span>     var myCreativeFileStore = <span style="color: #0000ff">new</span> CreativeFileStore();
<span style="color: #606060">  10:</span>     <span style="color: #0000ff">try</span>
<span style="color: #606060">  11:</span>     {
<span style="color: #606060">  12:</span>         myCreativeFileStore.WriteFile(myCreativeFile, 
<span style="color: #606060">  13:</span> MyCreativeFormat, DateTime.Now);
<span style="color: #606060">  14:</span>     }
<span style="color: #606060">  15:</span>     <span style="color: #0000ff">catch</span> (Exception ex)
<span style="color: #606060">  16:</span>     {
<span style="color: #606060">  17:</span>         FileErrorLabel.Text = ex.Message;
<span style="color: #606060">  18:</span>         <span style="color: #0000ff">return</span>;
<span style="color: #606060">  19:</span>     }
<span style="color: #606060">  20:</span> }
```

In the original implementation, we called into an upload control’s PostedFile property to do SaveAs(filePath). We can now replace this with a call to our file system’s WriteBinaryFile() method. The resulting method looks something like this (doesn’t quite compile):

CreativeFileStore.WriteFile

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteFile(CreativeFile creativeFile, CreativeFormat expectedFormat, DateTime time)
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">string</span> fileName = creativeFile.GenerateStandardFileName(time);
<span style="color: #606060">   4:</span>     <span style="color: #0000ff">string</span> directoryPath = LQPromotionServerConfig.Settings.TemporaryCreativeBaseFilePath;
<span style="color: #606060">   5:</span>     <span style="color: #0000ff">string</span> filePath = directoryPath + fileName;
<span style="color: #606060">   6:</span>                       
<span style="color: #606060">   7:</span>     <span style="color: #0000ff">if</span> (_fileSystem.FileExists(filePath))
<span style="color: #606060">   8:</span>     {
<span style="color: #606060">   9:</span>         <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> IOException(<span style="color: #006080">@"An error occurred which did not allow the uploading of your file. "</span> +
<span style="color: #606060">  10:</span>                               <span style="color: #006080">@"Please try again or contact your account manager."</span>);
<span style="color: #606060">  11:</span>     }
<span style="color: #606060">  12:</span>     <span style="color: #0000ff">if</span> (!_fileSystem.DirectoryExists(directoryPath))
<span style="color: #606060">  13:</span>     {
<span style="color: #606060">  14:</span>         _fileSystem.CreateDirectory(directoryPath);
<span style="color: #606060">  15:</span>     }
<span style="color: #606060">  16:</span>  
<span style="color: #606060">  17:</span>     <span style="color: #0000ff">if</span> (creativeFile.GetFileExtension() == <span style="color: #006080">".swf"</span>)
<span style="color: #606060">  18:</span>     {
<span style="color: #606060">  19:</span>         <span style="color: #008000">// TODO: Put some type of check to make sure this is really a flash file.</span>
<span style="color: #606060">  20:</span>         _fileSystem.WriteBinaryFile(creativeFile.Bytes, filePath);
<span style="color: #606060">  21:</span>     }
<span style="color: #606060">  22:</span>     <span style="color: #0000ff">else</span> <span style="color: #008000">// Is not Flash Type (Image)</span>
<span style="color: #606060">  23:</span>     {
<span style="color: #606060">  24:</span>         <span style="color: #0000ff">try</span>
<span style="color: #606060">  25:</span>         {
<span style="color: #606060">  26:</span>             <span style="color: #008000">// THIS CALL FAILS SINCE ImageOrFlashUpload and Server are both undefined here</span>
<span style="color: #606060">  27:</span>             Ardalis.Framework.Drawing.Image.FormatAndSaveUploadedImage(
<span style="color: #606060">  28:</span>                 ImageOrFlashUpload.PostedFile,
<span style="color: #606060">  29:</span>                 expectedFormat.Height,
<span style="color: #606060">  30:</span>                 expectedFormat.Width, <span style="color: #0000ff">false</span>,
<span style="color: #606060">  31:</span>                 filePath,
<span style="color: #606060">  32:</span>                 Server.MapPath(<span style="color: #006080">"/images/admin/blank_logo.gif"</span>));
<span style="color: #606060">  33:</span>         }
<span style="color: #606060">  34:</span>         <span style="color: #0000ff">catch</span> (Exception ex)
<span style="color: #606060">  35:</span>         {
<span style="color: #606060">  36:</span>             <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ApplicationException(
<span style="color: #606060">  37:</span>                 <span style="color: #0000ff">string</span>.Format(
<span style="color: #606060">  38:</span>                     <span style="color: #006080">@"There was a problem uploading your image. Please verify that the width 
<span style="color: #606060">  39:</span> height of the image you're uploading are exactly {0} x {1} pixels."</span>,
<span style="color: #606060">  40:</span>                     expectedFormat.Width, expectedFormat.Height), ex);
<span style="color: #606060">  41:</span>         }
<span style="color: #606060">  42:</span>     }
<span style="color: #606060">  43:</span> }
```

Now we need to refactor this library call so that it doesn’t depend on an HttpPostedFile, then add some tests, and we’re done (finally). What this code does is determine the dimensions of the uploaded image and verify they’re what’s expected, throwing an exception if not. To get this to compile for now, we can replace the call with the same thing that we used for .swf files:

```
<span style="color: #606060">   1:</span> _fileSystem.WriteBinaryFile(creativeFile.Bytes, filePath);
```

**Summary**

In this part, we extracted an ugly method into its own class and along the way wrote some tests and added some properties and methods to our IFileSystem and WindowsFileSystem components. The end result is a testable CreativeFileStore (we haven’t written enough tests yet – I decided this was getting long enough so they’ll come in the next part) that (currently) is missing a little functionality it had before (verifying image dimensions) but which we’ll work on restoring in the next step.