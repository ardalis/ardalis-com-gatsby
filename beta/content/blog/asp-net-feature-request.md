---
title: ASP.NET Feature Request
date: "2004-04-10T08:43:00.0000000-04:00"
description: If you're not aware, a great feature coming in ASP.NET 2.0 allows user profile data to be stored based on a simple config section, with strong typing and design time Intellisense.
featuredImage: /img/asp-net-mvc-logo.jpg
---

If you're not aware, a great feature coming in ASP.NET 2.0 allows user profile data to be stored based on a simple config section, with strong typing and design time Intellisense. Thus, you can modify the pieces of information you wish to store about a user, and immediately get Intellisense, strong typing, etc.

However, the Roles feature continues to use string literals to describe roles, such as

**if(User.IsInRole("Admins"))**

In a future version, I would like to see a roles config section in which strongly typed roles could be defined. Then, an overload of IsInRole(System.Web.Security.Role) could be added which would look something like:

**if(User.IsInRole(Roles.Admins))**

I suggested this to [Scott Guthrie](http://weblogs.asp.net/scottgu) at the MVP Summit, and I believe it's on the 'To-Do' list, though for what future version I don't know. Any thoughts on this feature? Love it? Problems with it? Just don't care? Note that the string literal methods would remain for backward compatibility.

