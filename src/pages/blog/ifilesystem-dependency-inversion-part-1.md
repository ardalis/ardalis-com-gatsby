---
templateKey: blog-post
title: IFileSystem Dependency Inversion Part 1
path: blog-post
date: 2008-12-08T11:32:00.000Z
description: "In the course of making my software more testable, I’ve attempted
  to eliminate a dependency on the file system (in this case, via System.IO) by
  creating an interface, IFileSystem. I just did a quick search for this term
  and came back with only one C# interface that matches this, which is for
  CC.NET, and looks like this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IFileSystem
category:
  - Uncategorized
comments: true
share: true
---
In the course of making my software more testable, I’ve attempted to eliminate a dependency on the file system (in this case, via System.IO) by creating an interface, ***IFileSystem***. I just did a quick search for this term and came back with only[ one C# interface](http://www.koders.com/csharp/fid3D7351540A84B6DE1150963950F9C55EC3E776FD.aspx?s=mdef%3Ainsert)(in the first few results) that matches this, which is for CC.NET, and looks like this:

[![image](https://stevesmithblog.com/files/media/image/WindowsLiveWriter/IFileSystemDependencyInversionPart1_B8B7/image_thumb.png "image")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/IFileSystemDependencyInversionPart1_B8B7/image_2.png)

My basic version of the interface is similar:

```
<span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">interface</span> IFileSystem
{
    <span style="color: rgb(0, 0, 255);">bool</span> FileExists(<span style="color: rgb(0, 0, 255);">string</span> path);
    <span style="color: rgb(0, 0, 255);">void</span> MoveFile(<span style="color: rgb(0, 0, 255);">string</span> oldPath, <span style="color: rgb(0, 0, 255);">string</span> newPath);
    <span style="color: rgb(0, 0, 255);">string</span> ReadAllText(<span style="color: rgb(0, 0, 255);">string</span> path);
}
```

From this, I was able to extract some simple System.IO dependencies that were detecting if a file existed and moving it. This made my unit tests much simpler, as they no longer depended on certain paths being configured for the tests to work (though integration tests might still require this). Once the interface was extracted, it was a simple matter to create a WindowsFileSystem class that implemented the interface:

```
<span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">class</span> WindowsFileSystem : IFileSystem
{
    <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">bool</span> FileExists(<span style="color: rgb(0, 0, 255);">string</span> path)
    {
        <span style="color: rgb(0, 0, 255);">return</span> System.IO.File.Exists(path);
    }
 
    <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">void</span> MoveFile(<span style="color: rgb(0, 0, 255);">string</span> oldPath, <span style="color: rgb(0, 0, 255);">string</span> newPath)
    {
        System.IO.FileInfo myFileInfo = <span style="color: rgb(0, 0, 255);">new</span> System.IO.FileInfo(oldPath);
        myFileInfo.MoveTo(newPath);
    }
 
    <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">string</span> ReadAllText(<span style="color: rgb(0, 0, 255);">string</span> path)
    {
        <span style="color: rgb(0, 0, 255);">return</span> System.IO.File.ReadAllText(path);        
    }
}
```

\
This worked great for my code that simply needed to detect if a file existed and if so, move it, as well as for some email template code that simply needed to read in templates from disk. However, my next step is to try and get web-based file uploads working. This is a bit more of a challenge because I need to work with(or rather, around) the **HttpPostedFile** class. Here’s the code currently, which is living in a user control’s codebehind. My next step is going to be to extend my IFileSystem interface to support DirectoryExists, CreateDirectory, and SaveFile operations. The real trick that’s coming, though, is that once I’ve done this my next step is going to be to write an Amazon S3 IFileSystem implementation – so I want to be sure my interface doesn’t automatically assume that I’m working with a standard disk-based file system.

**Current Ugly Code:**



```
<span style="color: rgb(0, 0, 255);">private</span> <span style="color: rgb(0, 0, 255);">void</span> GetImageOrFlashData()
{
    <span style="color: rgb(0, 0, 255);">string</span> fileExt = ImageOrFlashUpload.FileName.Substring(
ImageOrFlashUpload.FileName.LastIndexOf(<span style="color: rgb(0, 96, 128);">'.'</span>));
    MyCreative.CreativeUrl = DateTime.Now.Ticks.ToString() + fileExt;
 
    <span style="color: rgb(0, 0, 255);">string</span> virtualPath = MyCreative.ActualCreativeUrl;
    <span style="color: rgb(0, 0, 255);">string</span> filePath = Config.Settings.
TemporaryCreativeBaseFilePath + MyCreative.CreativeUrl;
 
    <span style="color: rgb(0, 128, 0);">// directoryPath is the File Path without the file</span>
    <span style="color: rgb(0, 0, 255);">string</span> directoryPath = Config.Settings.
TemporaryCreativeBaseFilePath;
 
    <span style="color: rgb(0, 0, 255);">if</span> (System.IO.File.Exists(filePath))
    {
        FileErrorLabel.Text = 
<span style="color: rgb(0, 96, 128);">@&quot;An error occurred which did not allow the uploading of your file.&quot;</span>;
        <span style="color: rgb(0, 0, 255);">return</span>;
    }
    <span style="color: rgb(0, 0, 255);">if</span> (!System.IO.Directory.Exists(directoryPath))
    {
        System.IO.Directory.CreateDirectory(directoryPath);
    }
 
    <span style="color: rgb(0, 0, 255);">if</span> (fileExt == <span style="color: rgb(0, 96, 128);">&quot;.swf&quot;</span>)
    {
        ImageOrFlashUpload.PostedFile.SaveAs(filePath);
    }
    <span style="color: rgb(0, 0, 255);">else</span> <span style="color: rgb(0, 128, 0);">// Is not Flash Type (Image)</span>
    {
<span style="color: rgb(0, 128, 0);">// This also depends on System.IO...</span>
        Ardalis.Framework.Drawing.ImageFileInfo fileInfo = 
<span style="color: rgb(0, 0, 255);">new</span> Ardalis.Framework.Drawing.ImageFileInfo(ImageOrFlashUpload.PostedFile);
 
        <span style="color: rgb(0, 0, 255);">try</span>
        {
<span style="color: rgb(0, 128, 0);">// This also depends on System.IO...</span>
            Ardalis.Framework.Drawing.Image.
FormatAndSaveUploadedImage(ImageOrFlashUpload.PostedFile, 
MyCreativeFormat.Height, MyCreativeFormat.Width, <span style="color: rgb(0, 0, 255);">false</span>, filePath, 
Server.MapPath(<span style="color: rgb(0, 96, 128);">&quot;/images/admin/blank_logo.gif&quot;</span>));
        }
        <span style="color: rgb(0, 0, 255);">catch</span> (Exception)
        {
            FileErrorLabel.Text = <span style="color: rgb(0, 96, 128);">@&quot;There was a problem uploading your image. </span>
Please verify that the width and height of the image you're uploading are exactly &quot; 
+ MyCreativeFormat.Width.ToString() + <span style="color: rgb(0, 96, 128);">&quot; x &quot;</span> + MyCreativeFormat.Height.ToString() 
+ <span style="color: rgb(0, 96, 128);">&quot; pixels.&quot;</span>;
            <span style="color: rgb(0, 0, 255);">return</span>;
        }
    }
}
```

\
Continue reading about [Dependency Inversion in Part 2.](http://stevesmithblog.com/blog/ifilesystem-dependency-inversion-part-2)