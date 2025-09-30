---
title: VS 2005 Code Snippets
date: "2006-02-21T08:14:54.6960000-05:00"
description: I've recently been learning more about code snippets in VS 2005,
featuredImage: img/vs-2005-code-snippets-featured.png
---

I've recently been learning more about code snippets in VS 2005, and I've found some nice resources online. Basically, if you haven't done anything with Code Snippets, they are a simple, extensible way for you to perform a relatively complex task within the IDE with just a few keystrokes. For example, let's say you want to write a try-catch-finally block. Normally there's a lot of repetitive code there, as you type try{ … } catch (Exception ex) { … } finally { … }. With code snippets, you can (by default in C#) just type try and then hit tab (twice, at least in my setup) and it will automatically create the try-catch block for you. For a try-finally it's tryf. There is no trycf for try-catch-finally, but they're easy to write yourself, so perhaps I'll write one later today if I have time.

You can find a bunch of code snippets others have written at [GotCodeSnippets.net](http://www.gotcodesnippets.net/default.aspx). You can learn more about how they work from this [.NETRocks show](http://www.dotnetrocks.com/default.aspx?showID=131), which includes several useful links to more information at the bottom of the page.

