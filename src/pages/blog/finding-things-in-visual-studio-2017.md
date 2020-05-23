---
templateKey: blog-post
title: Finding Things in Visual Studio 2017
date: 2018-03-14
path: blog-post
featuredpost: false
featuredimage: /img/vs-go-to-all-pascal-search.png
tags:
  - tip
  - visual studio
category:
  - Software Development
comments: true
share: true
---

I'm a proponent of small, single-purpose files for most things in software applications. This helps follow certain [SOLID principles, like Single Responsibility and Interface Segregation](http://bit.ly/SOLID-OOP). It also means my applications tend to have a large number of files. This isn't a problem unless you have a hard time working with lots of files. Fortunately, there are tools that make it easier to work with many files. The first one is the lowly directory/folder. Be comfortable using folders to organize your files, ideally around [the feature they provide to the user](https://ardalis.com/api-feature-folders), not the kind of file they happen to be. This will help you deliver software as a series of [vertical slices](http://deviq.com/vertical-slices/) and makes it easier to work within a single folder when working on a feature. The second tool, though, is a multi-find tool in Visual Studio 2017 that's accessed by default using Ctrl+t. **It's called "Go to All".**

## Find All The Things with Go To All!

The Go to All dialog in Visual Studio is triggered by default with the Ctrl+t shortcut. When it comes up, it defaults to searching in a wide variety of places (hence the 'All' moniker), but you can easily narrow it down with a keyboard shortcut.

![vs-go-to-all-window](/img/vs-go-to-all-window.png)

If you don't have anything selected when you trigger Go to All, you'll see the default behavior shown above. However, if you have a term selected, Go to All will appear pre-populated with the term and will immediately display the results for it:

[![vs-go-to-all-term](/img/vs-go-to-all-term.png)](/img/vs-go-to-all-term.png)

What's even cooler, though, is the UI for filtering down the selection. See, sometimes you know you're looking for a file, while other times you want a type. And still others you want a member. You can trigger any of these filters and more using the icons at the top of the dialog, but you can also specify these filters using a single character prefix. Type '?' to see the full list:

[![vs-go-to-all-help](/img/vs-go-to-all-help.png)](/img/vs-go-to-all-help.png)

As you can see from the image above, you can prefix your search with 'f' for Files, 'm' for Members, or 't' for Types. You can also jump to a specific line number by prefixing it with ':' or search symbols using the '#' filter. In the past, I've made heavy use of Resharper's Ctrl-n and Ctrl-shift-n shortcuts to go to files and types, or sometimes the Solution Explorer Ctrl+; search option. Now I only need to use one Ctrl+(something) shortcut for all of these things.

### What about long names?

Naming things is tough. Longer names are more descriptive and clear in many cases, but can be a hassle to type out.  Fortunately, search tools like Go to All support Pascal-Case searching. What this means is that instead of having to type out all or most of a long name like `ToDoItemCompletedEvent` you can instead just type some or all of the capitalized letters, like `TDIC`:

[![vs-go-to-all-pascal-search](/img/vs-go-to-all-pascal-search.png)](/img/vs-go-to-all-pascal-search.png)

### Preview Result

Another nice feature (that you can turn off if you don't like it) is that you can see the result in a preview tab. Visual Studio preview tabs open in response to single-clicking documents in Solution Explorer, and also are the default experience for Go to All. As you adjust your filter or change which result is selected (using mouse or arrow keys), the selected result will open in a preview tab so you can immediately see it. This can be very useful as well, and often is sufficient to be able to see what you're looking for.

[![vs-go-to-all-preview-tab](/img/vs-go-to-all-preview-tab-1024x409.png)](/img/vs-go-to-all-preview-tab.png)

## Summary

Obviously the ability to search for things has been around for a long time and hardly seems worth writing about. However, the integrated navigation experience of the Go to All dialog in Visual Studio is the kind of hidden gem that I think many developers are both unaware of and would find helpful on a regular basis. Let me know if I missed anything important and if you feel like this feature is one you'll use (or not).

_/img shown here are from my [Clean Architecture solution starter kit for ASP.NET Core apps](https://github.com/ardalis/CleanArchitecture)._
