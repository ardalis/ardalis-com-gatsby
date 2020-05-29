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

![ifilesystem code listing](/img/ifilesystem.png)

My basic version of the interface is similar:

```csharp
public interface IFileSystem
{
    bool FileExists(string path);
    void MoveFile(string oldPath, string newPath);
    string ReadAllText(string path);
}
```

From this, I was able to extract some simple System.IO dependencies that were detecting if a file existed and moving it. This made my unit tests much simpler, as they no longer depended on certain paths being configured for the tests to work (though integration tests might still require this). Once the interface was extracted, it was a simple matter to create a WindowsFileSystem class that implemented the interface:

```csharp
public class WindowsFileSystem : IFileSystem
{
    public bool FileExists(string path)
    {
        return System.IO.File.Exists(path);
    }

    public void MoveFile(string oldPath, string newPath)
    {
        System.IO.FileInfo myFileInfo = new System.IO.FileInfo(oldPath);
        myFileInfo.MoveTo(newPath);
    }

    public string ReadAllText(string path)
    {
        return System.IO.File.ReadAllText(path);
    }
}
```

This worked great for my code that simply needed to detect if a file existed and if so, move it, as well as for some email template code that simply needed to read in templates from disk. However, my next step is to try and get web-based file uploads working. This is a bit more of a challenge because I need to work with(or rather, around) the **HttpPostedFile** class. Here’s the code currently, which is living in a user control’s codebehind. My next step is going to be to extend my IFileSystem interface to support DirectoryExists, CreateDirectory, and SaveFile operations. The real trick that’s coming, though, is that once I’ve done this my next step is going to be to write an Amazon S3 IFileSystem implementation – so I want to be sure my interface doesn’t automatically assume that I’m working with a standard disk-based file system.

## Current Ugly Code:

```csharp
private void GetImageOrFlashData()
{
    string fileExt = ImageOrFlashUpload.FileName.Substring(
ImageOrFlashUpload.FileName.LastIndexOf('.'));
    MyCreative.CreativeUrl = DateTime.Now.Ticks.ToString() + fileExt;

    string virtualPath = MyCreative.ActualCreativeUrl;
    string filePath = Config.Settings.TemporaryCreativeBaseFilePath + MyCreative.CreativeUrl;

    // directoryPath is the File Path without the file
    string directoryPath = Config.Settings.
TemporaryCreativeBaseFilePath;

    if (System.IO.File.Exists(filePath))
    {
        FileErrorLabel.Text =  "An error occurred which did not allow the uploading of your file.";
        return;
    }
    if (!System.IO.Directory.Exists(directoryPath))
    {
        System.IO.Directory.CreateDirectory(directoryPath);
    }

    if (fileExt == ".swf")
    {
        ImageOrFlashUpload.PostedFile.SaveAs(filePath);
    }
    else // Is not Flash Type (Image)
    {
        // This also depends on System.IO...
        Ardalis.Framework.Drawing.ImageFileInfo fileInfo =
            new Ardalis.Framework.Drawing.ImageFileInfo(ImageOrFlashUpload.PostedFile);

        try
        {
            // This also depends on System.IO...
            Ardalis.Framework.Drawing.Image.FormatAndSaveUploadedImage(ImageOrFlashUpload.PostedFile, 
                MyCreativeFormat.Height, MyCreativeFormat.Width, false, filePath, 
                Server.MapPath("/images/admin/blank_logo.gif"));
        }
        catch (Exception)
        {
            FileErrorLabel.Text = @"There was a problem uploading your image. 
Please verify that the width and height of the image you're uploading are exactly " 
+ MyCreativeFormat.Width.ToString() + " x " + MyCreativeFormat.Height.ToString() 
+ " pixels.";
            return;
        }
    }
}
```

Continue reading about [Dependency Inversion in Part 2.](/ifilesystem-dependency-inversion-part-2)
