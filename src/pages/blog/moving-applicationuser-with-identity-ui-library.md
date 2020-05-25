---
templateKey: blog-post
title: Moving ApplicationUser with Identity UI Library
date: 2018-07-26
path: blog-post
featuredpost: false
featuredimage: /img/ApplicationUserRazorError.png
tags:
  - asp.net core
  - razor pages
category:
  - Software Development
comments: true
share: true
---

One of the new features in ASP.NET Core 2.1 is Razor Class Libraries, which let you compile razor files into NuGet packages. Another that builds on this is the ASP.NET Core Identity functionality as a Razor Class Library. Using this functionality, you can add Identity functionality to your application without having to add all the associated Razor views/pages.

Having done that, if you then move the ApplicationUser class (to another namespace) that many of these pages use, you may encounter an error like this one:

[![ApplicationUser could not be found](/img/ApplicationUserRazorError-1024x83.png)](/img/ApplicationUserRazorError.png)

It says, "The type or namespace name 'ApplicationUser' could not be found (are you missing a using directive or an assembly reference?)". The odd thing about the error is that it's referencing files that aren't in your project, like \_ManageNav.g.cshtml.cs. These are C# classes that have been generated from Razor files, and they're located in your /obj/Debug/Razor/Pages (or similar) folder. Visual Studio isn't very helpful here, since double-clicking on the errors won't open the generated files, and I wasn't able to find any information in VS that would give me the location of the file on disk. However, running 'dotnet build' from the console yielded more information:

[![ApplicationUserRazorFilesError](/img/ApplicationUserRazorFilesError.png)](/img/ApplicationUserRazorFilesError.png)

From this I was able to find the files on disk. But then what? At first I thought I might have to scaffold the files so I could correctly specify the new namespace for ApplicationUser. But then I remembered the \_ViewImports.cshtml file, where you can add using statements that are used by every Razor file.

Initially my \_ViewImports.cshtml file included the Data namespace, where ApplicationUser was defined by default. I'd moved it into Data.Models. Adding @using PROJECTNAME.Data.Models to \_ViewImports.cshtml fixed the issue.

Hope this helps someone else facing this issue.
