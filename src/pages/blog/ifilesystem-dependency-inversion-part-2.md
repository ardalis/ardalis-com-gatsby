---
templateKey: blog-post
title: IFileSystem Dependency Inversion Part 2
path: blog-post
date: 2008-12-08T11:16:00.000Z
description: In my last post in this IFileSystem series, I described the problem
  I’m working on of removing a dependency on the System.IO Windows file system
  in my ASP.NET application. A bit of research on this subject revealed some
  help on making file uploads testable by ScottHa, but his technique still makes
  use of the SaveAs() method and ultimately ties the solution to the server file
  system.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IFileSystem
category:
  - Uncategorized
comments: true
share: true
---
In [my last post in this IFileSystem series](/ifilesystem-dependency-inversion-part-1), I described the problem I’m working on of removing a dependency on the System.IO Windows file system in my ASP.NET application. A bit of research on this subject revealed some help on [making file uploads testable by ScottHa](http://www.hanselman.com/blog/ABackToBasicsCaseStudyImplementingHTTPFileUploadWithASPNETMVCIncludingTestsAndMocks.aspx), but his technique still makes use of the SaveAs() method and ultimately ties the solution to the server file system. A similar post on creating [Unit Test Friendly File Uploads](http://weblogs.asp.net/meligy/archive/2008/02/18/unit-test-friendly-file-upload-handling-in-n-tier-applications.aspx) was more helpful, in that it provided some helper methods for saving files from HttpPostFile without using its built-in SaveAs() method.

Since my ultimate goal is to be able to swap between Amazon S3 and Windows file systems (and likely Azure as well), I decided to create a [spike solution](http://c2.com/xp/SpikeSolution.html) that allows me to accomplish both tasks using the same API. To this end, I created a simple ASP.NET web form like so:

**Default.aspx**

```
<span style="color: #606060">   1:</span> <span style="background-color: #ffff00">&lt;%@ Page Language="C#" AutoEventWireup="true" 
<span style="color: #606060">   2:</span> CodeBehind="Default.aspx.cs" Inherits="UploadTestCS._Default" %&gt;</span>
<span style="color: #606060">   3:</span>  
<span style="color: #606060">   4:</span> <span style="color: #0000ff">&lt;!</span><span style="color: #800000">DOCTYPE</span> <span style="color: #ff0000">html</span> <span style="color: #ff0000">PUBLIC</span> <span style="color: #0000ff">"-//W3C//DTD XHTML 1.0 Transitional//EN"</span> 
<span style="color: #606060">   5:</span> <span style="color: #0000ff">"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">   6:</span>  
<span style="color: #606060">   7:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">html</span> <span style="color: #ff0000">xmlns</span><span style="color: #0000ff">="http://www.w3.org/1999/xhtml"</span> <span style="color: #0000ff">&gt;</span>
<span style="color: #606060">   8:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">head</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">&lt;</span><span style="color: #800000">title</span><span style="color: #0000ff">&gt;</span>Untitled Page<span style="color: #0000ff">&lt;/</span><span style="color: #800000">title</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  10:</span> <span style="color: #0000ff">&lt;/</span><span style="color: #800000">head</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  11:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">body</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  12:</span>
 
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">form</span> <span style="color: #ff0000">id</span><span style="color: #0000ff">="form1"</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  13:</span>     <span style="color: #0000ff">&lt;</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  14:</span>         <span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:FileUpload</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">="FileUpload1"</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #606060">  15:</span>         <span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:Button</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">="Button1"</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span>
<span style="color: #606060">  16:</span>             <span style="color: #ff0000">Text</span><span style="color: #0000ff">="Button"</span> <span style="color: #ff0000">onclick</span><span style="color: #0000ff">="Button1_Click"</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #606060">  17:</span>     <span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  18:</span>     <span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:Label</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">="MessageLabel"</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span> <span style="color: #ff0000">EnableViewState</span><span style="color: #0000ff">="False"</span><span style="color: #0000ff">&gt;&lt;/</span><span style="color: #800000">asp:Label</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  19:</span>     <span style="color: #0000ff">&lt;/</span><span style="color: #800000">form</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  20:</span> <span style="color: #0000ff">&lt;/</span><span style="color: #800000">body</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">  21:</span> <span style="color: #0000ff">&lt;/</span><span
```

**Default.aspx.cs**

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">using</span> System;
<span style="color: #606060">   2:</span> <span style="color: #0000ff">using</span> System.IO;
<span style="color: #606060">   3:</span> <span style="color: #0000ff">using</span> Affirma.ThreeSharp;
<span style="color: #606060">   4:</span> <span style="color: #0000ff">using</span> Affirma.ThreeSharp.Model;
<span style="color: #606060">   5:</span> <span style="color: #0000ff">using</span> Affirma.ThreeSharp.Query;
<span style="color: #606060">   6:</span>  
<span style="color: #606060">   7:</span> <span style="color: #0000ff">namespace</span> UploadTestCS
<span style="color: #606060">   8:</span> {
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">partial</span> <span style="color: #0000ff">class</span> _Default : System.Web.UI.Page
<span style="color: #606060">  10:</span>     {
<span style="color: #606060">  11:</span>         <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">string</span> uploadFolder;
<span style="color: #606060">  12:</span>         <span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">string</span> awsAccessKeyId = <span style="color: #006080">"KEY"</span>;
<span style="color: #606060">  13:</span>         <span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">string</span> awsSecretAccessKey = <span style="color: #006080">"SECRETKEY"</span>;
<span style="color: #606060">  14:</span>         <span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">string</span> uploadBucket = <span style="color: #006080">"TESTBUCKET"</span>;
<span style="color: #606060">  15:</span>  
<span style="color: #606060">  16:</span>         <span style="color: #0000ff">public</span> _Default()
<span style="color: #606060">  17:</span>         {
<span style="color: #606060">  18:</span>             uploadFolder = Server.MapPath(<span style="color: #006080">"upload/"</span>);
<span style="color: #606060">  19:</span>         }
<span style="color: #606060">  20:</span>         <span style="color: #0000ff">protected</span> <span style="color: #0000ff">void</span> Button1_Click(<span style="color: #0000ff">object</span> sender, EventArgs e)
<span style="color: #606060">  21:</span>         {
<span style="color: #606060">  22:</span>             <span style="color: #0000ff">if</span>(FileUpload1.FileBytes.Length &gt; 0)
<span style="color: #606060">  23:</span>             {
<span style="color: #606060">  24:</span>                 MessageLabel.Text = String.Format(<span style="color: #006080">"File uploaded: {0}, {1}"</span>, 
<span style="color: #606060">  25:</span> FileUpload1.FileName, FileUpload1.FileBytes.Length);
<span style="color: #606060">  26:</span>  
<span style="color: #606060">  27:</span>                 <span style="color: #0000ff">string</span> fileName = FileUpload1.FileName;
<span style="color: #606060">  28:</span>                 <span style="color: #008000">// System.IO Byte Array</span>
<span style="color: #606060">  29:</span>                 WriteBinaryFile(FileUpload1.FileBytes, fileName);
<span style="color: #606060">  30:</span>                 <span style="color: #008000">// S3 Byte Array</span>
<span style="color: #606060">  31:</span>                 WriteBinaryFileS3(FileUpload1.FileBytes, fileName);
<span style="color: #606060">  32:</span>             }
<span style="color: #606060">  33:</span>         }
<span style="color: #606060">  34:</span>  
<span style="color: #606060">  35:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteBinaryFileS3(<span style="color: #0000ff">byte</span>[] bytes, <span style="color: #0000ff">string</span> savingPath)
<span style="color: #606060">  36:</span>         {
<span style="color: #606060">  37:</span>             ThreeSharpConfig config = <span style="color: #0000ff">new</span> ThreeSharpConfig();
<span style="color: #606060">  38:</span>             config.AwsAccessKeyID = awsAccessKeyId;
<span style="color: #606060">  39:</span>             config.AwsSecretAccessKey = awsSecretAccessKey;
<span style="color: #606060">  40:</span>             <span style="color: #0000ff">string</span> testBucketName = <span style="color: #006080">"sometestfolder"</span>;
<span style="color: #606060">  41:</span>  
<span style="color: #606060">  42:</span>             IThreeSharp service = <span style="color: #0000ff">new</span> ThreeSharpQuery(config);
<span style="color: #606060">  43:</span>             <span style="color: #0000ff">using</span> (ObjectAddRequest request = 
<span style="color: #606060">  44:</span> <span style="color: #0000ff">new</span> ObjectAddRequest(testBucketName, savingPath))
<span style="color: #606060">  45:</span>             {
<span style="color: #606060">  46:</span>                 request.LoadStreamWithBytes(bytes);
<span style="color: #606060">  47:</span>                 <span style="color: #0000ff">using</span> (ObjectAddResponse response = service.ObjectAdd(request))
<span style="color: #606060">  48:</span>                 { }
<span style="color: #606060">  49:</span>             }
<span style="color: #606060">  50:</span>         }
<span style="color: #606060">  51:</span>  
<span style="color: #606060">  52:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> WriteBinaryFile(<span style="color: #0000ff">byte</span>[] bytes, <span style="color: #0000ff">string</span> savingPath)
<span style="color: #606060">  53:</span>         {
<span style="color: #606060">  54:</span>                 <span style="color: #0000ff">using</span> (var writingStream =
<span style="color: #606060">  55:</span>                     <span style="color: #0000ff">new</span> FileStream(savingPath, FileMode.OpenOrCreate))
<span style="color: #606060">  56:</span>                 {
<span style="color: #606060">  57:</span>                     writingStream.Write(bytes, 0, bytes.Length);
<span style="color: #606060">  58:</span>                     writingStream.Flush();
<span style="color: #606060">  59:</span>                     writingStream.Close();
<span style="color: #606060">  60:</span>                 }
<span style="color: #606060">  61:</span>         }
<span style="color: #606060">  62:</span>     }
<span style="color: #606060">  63:</span> }
```

Now I know what my signature needs to be for IFileSystem’s WriteBinaryFile() method, and I have implementations that work for both S3 and Windows. I also know the implementation-specific properties/configuration each implementation will need, specifically the upload folder for System.IO and the S3 keys and bucket name for S3.

Note that I’m making use of the [Affirma ThreeSharp Amazon S3 library](http://www.codeplex.com/ThreeSharp) in the above code, available for free on CodePlex.

**Next Steps**

The next step is to throw away my spike solution and go back and TDD my IFileSystem to provide direct support for WriteBinaryFile. Then I need to get my [ugly GetImageOrFlashData() method](/ifilesystem-dependency-inversion-part-1) under test, apply some Dependency Injection (via the Strategy pattern) to it, and hopefully I’ll then be able to flip a switch in my application and have the uploaded file go directly to Amazon S3 (without ever hitting my server’s disk) or to my server’s disk.

(Note that later we may decide it’s wiser to always upload to server disk, and then persist to S3/Azure/Cloud storage using a separate worker process. For now that’s a premature optimization and we’re just going to work on getting the simple, synchronous case to work first).