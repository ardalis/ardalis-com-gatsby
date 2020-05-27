---
templateKey: blog-post
title: Silverlight Server Configuration
path: blog-post
date: 2008-06-17T01:52:34.308Z
description: I went to throw a small Silverlight sample application up on a web
  site to show to a client yesterday and found out the hard way that although it
  is primarily a client-side technology, it doesn’t “just work” when you put the
  files up on the server.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Silverlight
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I went to throw a small Silverlight sample application up on a web site to show to a client yesterday and found out the hard way that although it is primarily a client-side technology, it doesn’t “just work” when you put the files up on the server. My first attempt was to just put the necessary bits on a static file server that has ASP.NET but doesn’t have an easy way for me to configure virtual roots. Unfortunately, the project I was using (in Visual Studio) was configured to use an ASPX test project with its own web.config and /bin folder, neither of which worked outside of the application root. So I figured perhaps I could just get the test page to work as a .htm file, and I renamed it to that from .aspx. Unfortunately, it used the new <asp:Silverlight /> control. So naturally it didn’t work well running as a static htm file. I created a new Silverlight web project in Visual Studio, grabbed the .htm file it creates, and thought I was finally ready when I ran into the issue of IIS not serving up .xap files.

By default, IIS is not configured to serve several of the file extensions that Silverlight requires, such as .xap and .xaml. [Tim Sneath](http://blogs.msdn.com/tims) has a good writeup of what you need to do to [get IIS configured correctly to host Silverlight files and applications](http://blogs.msdn.com/tims/archive/2008/03/18/configuring-a-web-server-to-host-silverlight-content.aspx) – it’s pretty simple and you only have to do it once.

The only other issue I encountered for this application was with loading image files from the web. Apparently you cannot load .GIF images like this:

ImageSource mySource = new System.Windows.Media.Imaging.BitmapImage(new Uri(<http://www.google.com/intl/en_ALL/images/logo.gif>));

The result is a Sys.InvalidOperationException: ImageError #4001: AG_E_NETWORK_ERROR. The solution I found was to use a .PNG formatted image. I haven’t discovered a workaround for directly accessing GIF files over HTTP yet using this method. Apparently issues with GIF images have been documented by [others](http://silverlight.net/forums/t/6939.aspx) [previously](http://forums.microsoft.com/msdn/ShowPost.aspx?PostID=3165231&SiteID=1).

<!--EndFragment-->