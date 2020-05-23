---
templateKey: blog-post
title: Using Grep to Find Strings in Markdown .md Files on Windows
date: 2019-12-11
path: /using-grep-to-find-strings-in-markdown-md-files-on-windows
featuredpost: false
featuredimage: /img/using-grep-find-strings-markdown-windows.png
tags:
  - grep
  - linux
  - markdown
  - tips and tricks
  - tools
  - windows
  - wsl
category:
  - Software Development
comments: true
share: true
---

I recently needed to find which of a bunch of markdown files had a particular string in them. My initial thought, since I'm on Windows, was to use Windows File Explorer's search dialog. No dice - it found no results when I knew there were some.

I did a quick search for 'windows explorer search markdown files' which led me to [a Super User thread](https://superuser.com/questions/995175/have-windows-explorer-preview-markdown-files) that said I'd have to install a Markdown Preview to do it. And the answers didn't sound promising:

![](/img/image-grep.png)

I really didn't feel like this required me to install One More Thing ™ when I knew this would be so easy if only I could use [grep](https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php).

Then I remembered I'd installed WSL - Windows Subsystem for Linux - which meant I actually had the power of grep available to me!

![](/img/image-1-grep.png)

Find all instances of 'ardalis' in folder 'docs' recursively

In the above terminal window you can see a simple grep command for finding a string in any file in a folder, recursively. The flags `-irn` mean ignore case (-i), recurse subdirectories (-r), and print line numbers of matches (-n). Here's the whole command:

```
grep -irn 'ardalis' docs
```

This runs insanely fast (way faster than any Windows search) and it works just fine with .md Markdown files without having to install anything on your machine. Alternately, if you only wanted to search markdown files and nothing else, say in the current folder, you could do something like this just fine:

```
grep -in 'ardalis' *.md
```

**What are your favorite grep tips, especially on Windows?** Leave your answer in the comments below.

## More Suggestions from Readers

A few readers left comments (below) and some emailed me directly with their own solutions to this problem. Here are a few:

Dan B. writes:

_Another option that I tend to do is create PowerShell commandlets. For example I use:_

function Find-CodeString {  
param (  
\[string\] $Pattern,  
\[string\] $Extension = "cs")

ls ./ -I \*.$Extension -R | sls -Pattern $Pattern  
}

_This will search files with the passed in extension for the word pattern. I use an alias of fcs so I don't have to type the entire command name._

_Anytime I have to type a PowerShell command out more than once it usually becomes a commandlet._

_I use 2 primary machines: home and work. A lot of the commandlets I create for work wouldn’t be beneficial to me at home. The ones that would be beneficial at both locations I just manually copy them over. The default profile location for PowerShell is %USERPROFILE%\\Documents\\WindowsPowerShell you could technically have this live in OneDrive. It would then be available to you on any machine._

## References

- [Install Windows Subsystem for Linux on Windows 10](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
- [Grep Cheat Sheet](https://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php)
