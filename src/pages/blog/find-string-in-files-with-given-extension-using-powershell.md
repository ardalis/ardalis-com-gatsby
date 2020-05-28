---
templateKey: blog-post
title: Find String in Files with Given Extension Using PowerShell
path: blog-post
date: 2009-10-10T20:40:00.000Z
description: This week I found myself wanting to search within files of a given
  extension for a particular substring. I often find myself missing UNIX’s grep
  tool. In any event, I tried using the default Windows Vista file search
  dialog, but found that if I wanted to search for “connection” or “database”
  within all files ending with “.cs” or “.config”
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - PowerShell
category:
  - Uncategorized
comments: true
share: true
---
This week I found myself wanting to search within files of a given extension for a particular substring. I often find myself missing UNIX’s grep tool. In any event, I tried using the default Windows Vista file search dialog, but found that if I wanted to search for “connection” or “database” within all files ending with “.cs” or “.config” I was unable to do so. I’m guessing there actually \*is\* a way to do this from the GUI, but after spending a couple of minutes either searching all files for the text “.cs” or else searching for files named “connection” I opted to just do it from the command line using PowerShell.

PowerShell is just freaking amazing. Seriously. Being able to easily store collections of objects in ad-hoc variables (named $something) and then to further be able to pipe the output of anything to anything (using | just like most other shells), you can quickly do some amazing stuff. I use [PowerShell all the time now to make downloading pictures from my camera and organizing them by date easy](https://ardalis.com/wp-content/blog/copy-pictures-to-folders-by-date-taken-with-powershell)

![](/img/given-extention.png)

To get a list of all files with a given extension that contain a given string, you can use the following steps (click on the screenshot to see it full size)

1. Move to the appropriate folder. While not strictly necessary, this will make your life easier. The standard “cd” command from DOS works for this, but remember you can’t do “cd” you have to do “cd ” to move to the root of the current volume.
2. Get a list of all files. This isn’t strictly required but again using an intermediate step like this can ensure you catch any mistakes in your operation earlier. To get a collection of all the files in and below your current folder, use:**$AllFiles = Get-ChildItem –recurse**
3. Next we’ll filter our list to only include files with the extension we want. If we’re looking for all of our C# source files, we would search for extensions that end with “.cs”. Note that the $_ value refers to the current item in the collection as we loop through them applying our filter condition. The “-eq” means “equals”. The full command to create a new collection named $CSharpFiles is:**$CSharpFiles = $AllFiles | where {$_.extension –eq “.cs” }**
4. The next step is again not strictly necessary since we could simply write out the command, but it does show another useful PowerShell feature, namely the ability to alias commands with shorthand strings. For example, the Select-String command is useful for matching files that contain a particular string, but if you’d prefer to just type “ss” for this, you can alias it like so:**Set-Alias ss Select-String**
5. Finally, we’ll use the ss alias on our filtered list of files to find all files containing the string “SqlConnection” which might be useful if you’re trying to ensure nobody is using ADO.NET when they should be using your ORM:**ss SqlConnection $CSharpFiles | format-table Path**

The result will be the paths of all files that contain that string. If you leave off Path from the end of the command, your table will include the line number and the actual Line of the file that matched the string you specified.

So there you go. It took much longer to write this blog post than to figure all of this out in PowerShell and find the files I was after. Here are a couple of links that helped me get here:

* [Select-String and Grep](http://blogs.msdn.com/powershell/archive/2008/03/23/select-string-and-grep.aspx)
* [PowerShell Script to List Files](http://www.computerperformance.co.uk/ezine/ezine133.htm)