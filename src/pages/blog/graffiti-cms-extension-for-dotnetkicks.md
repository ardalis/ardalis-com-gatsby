---
templateKey: blog-post
title: Graffiti CMS Extension for DotNetKicks
path: blog-post
date: 2008-09-18T16:28:00.000Z
description: I’ve been manually adding DotNetKicks icons to my posts recently to
  try and generate more buzz for them, but that gets old quickly, so about an
  hour ago I decided to figure out how to make this automatic.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Graffiti CMS
category:
  - Uncategorized
comments: true
share: true
---
I’ve been manually adding [DotNetKicks](http://dotnetkicks.com/) icons to my posts recently to try and generate more buzz for them, but that gets old quickly, so about an hour ago I decided to figure out how to make this automatic. My current blog engine is [Graffiti](http://graffiticms.com/), which I really like, and after doing some searching for a pre-existing solution, I pinged [ScottW](http://simpable.com/) on IM about the problem and he set me down the right path within seconds.

**The Problem**

DotNetKicks will display a dynamic image with a count of how many “kicks” a particular post has had. It looks something like this:

[![kick it on DotNetKicks.com](https://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=http%3a%2f%2fstevesmithblog.com%2fblog%2fgraffiti-cms-extension-for-dotnetkicks%2f)](http://www.dotnetkicks.com/kick/?url=http%3a%2f%2fstevesmithblog.com%2fblog%2fgraffiti-cms-extension-for-dotnetkicks%2f)

The HTML for this icon is very simple, and the only dynamic part of it is the URL of the post, which must be fully qualified and URL encoded. The end result HTML needed is something like this

![](/img/grafti-cms1.png)

Using the Graffiti control panel, you can customize views for different areas of your blog very easily. Go to the Presentation tab from the main Control Panel screen, then Themes, and then Personalize. From there you can select a view to edit and start editing. In my case, I’m editing post.view, which looks something like this (click to enlarge):

![](/img/grafti-cms2.png)

Notice that you can mouse over the items at the top of the edit screen, to see what properties they have. The obvious one I needed was $post.Url. What I really needed, though, was something like $post.UrlEncodedFullUrl, because $post.Url uses a non-encoded, relative path (e.g. /blog/post-name/). Further, the current version of Graffiti doesn’t expose the necessary pieces of System.Web to UrlEncode something, so I had to extend it myself.

**Extending Graffiti**

With a bit of help from ScottW, I wrote a Graffiti Extensions library to accomplish my task. It turns out that extending Graffiti is every bit as easy as I’d heard, so I was able to write my extension, deploy it, test it out, and get it 100% working in less time than it’s taken to write this blog post.

The short version of the story goes like this:

* Create a class library that reference Graffiti.Core
* Create a class and add the \[Chalk(“SteveSmith”)] attribute to it
* Create a method Encode that takes and returns a string
* Compile it and drop it into the /bin of your blog site
* Edit a view and you can now use $SteveSmith.Encode($post.Url)

The slightly longer version:

## Extension.cs

```
using System.Web;
using Graffiti.Core;
 
namespace SteveSmith.GraffitiExtensions
{
    [Chalk("SteveSmith")]
    public class Extension
    {
        public static string UrlEncode(string url)
        {
            return HttpUtility.UrlEncode(url);
        }
 
        public static HttpContext Context
        {
            get
            {
                return HttpContext.Current;
            }
        }
         public static string FullUrl(string postUrl)
        {
            return "http://" +
                 Context.Request.Url.Host +
                 VirtualPathUtility.Combine("/", postUrl);
        }
    }
}
```

## Promote.cs

```
using System;
using Graffiti.Core;
 
namespace SteveSmith.GraffitiExtensions{
    [Chalk("Promote")]
    public class Promote
    {
        public string DotNetKicks(string postUrl)
        {
            string encodedUrl =
                 Extension.UrlEncode(Extension.FullUrl(postUrl));
            string dnkFormatString = 
"<a href="http://www.dotnetkicks.com/kick/?url={0}"><img src="https://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url={0}" border="0" alt="kick it on DotNetKicks.com" /></a>";
             return String.Format(dnkFormatString, encodedUrl);
        }
    }
}
```

After compiling and deploying the code, I now have full access to HttpContext so I won’t run into this problem in the future. I also have a simple shortcut for creating DotNetKicks image chiclets, and I can add additional such things to my Promote class as needed for Digg, del.icio.us, etc. Creating such an image now requires the following code in my post.view:

```
$Promote.DotNetKicks($post.Url)
```