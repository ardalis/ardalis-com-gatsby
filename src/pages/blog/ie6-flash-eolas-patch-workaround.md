---
templateKey: blog-post
title: IE6 Flash Eolas Patch Workaround
path: blog-post
date: 2006-03-08T13:07:27.277Z
description: "I’ve been dealing with the IE6 Eolas Patch that was released last
  week (February 28) via Windows Update as an optional download. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IE6
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been dealing with the IE6 Eolas Patch that was released last week (February 28) via Windows Update as an optional download. This patch affects IE by forcing the user to click on any active content (Flash being the one I’m concerned with here) to activate it before the use can interact with the content. Since I don’t want my Flash movies to alter their behavior in response to this patch, I’m interested in a workaround. The official KB article from Microsoft on this topic can be found at <http://msdn.microsoft.com/library/default.asp?url=/workshop/author/dhtml/overview/activating_activex.asp>. In it, you’ll learn that you can work around this issue if you use an external script file and document.write (or build using the DOM) your <object> tag. If you simply place an <object> tag in your HTML, or create it using inline script within the HTML page, it will require activation. I’m not sure why this distinction now exists, but I assume it’s because of a loophole that was found in the [Eolas patent case](http://news.com.com/2100-1032_3-5106129.html). Unfortunately, there is a catch with all of these workarounds — they do NOT work if the user has Script Debugging enabled in IE (meaning they have unchecked the Disable Script Debugging option in the Advanced Tab of the Internet Options Control Panel — incidentally, it’s really stupid to have a checkbox for a “Disable” option which defaults to true. Call it Enable and leave it unchecked).

I did some Googling on the issue as I prepared to implement my fix and found [Richard Leggett’s post](http://richardleggett.co.uk/blog/index.php/2006/03/01/ie6hatesflash) with some good links and useful comments. In particular, the comments led me to the [Flash Object](http://blog.deconcept.com/flashobject) site, which looks like a very promising tool that I’m going to immediately implement in my solution (and which, I believe, will also eliminate most of the issues with the patch). A related page has a good amoung of information on the [IE Eolas Patch and surrounding issues](http://blog.deconcept.com/2005/12/15/internet-explorer-eolas-changes-and-the-flash-plugin).

What I have not found, but would really like to see, is a way for IE users who have script debugging enabled to avoid this unwanted behavior. Since I run web developer websites, I expect that a large number of my users will have Visual Studio installed, which by default turns on Script Debugging (er, I’m sorry, it disables the Disable Script Debugging option). So even if I use Flash Object or any other workaround, most of my users are going to remain affected by this annoying “feature”. I’d appreciate a comment from anybody who finds a workaround that will work for IE users with Script Debugging turned on.

<!--EndFragment-->