---
templateKey: blog-post
title: VaryByCustom Caching By User
path: blog-post
date: 2007-10-29T12:17:48.104Z
description: Ran into an interesting bug today with one of my applications. A
  user control that provides messages based on a user’s account was showing the
  wrong information to other users in our testing.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Ran into an interesting bug today with one of my applications. A user control that provides messages based on a user’s account was showing the wrong information to other users in our testing. The user control was set up with an output cache directive and a VaryByParam=”*” setting, yet it was showing other users’ messages (one in particular) to basically everybody – not good. The funny thing was, it was only doing it on one server instance, not on localhost, despite its having the same code and same database.

Well, we quickly figured out that this was a caching issue. The problem was that everywhere in the application, the account the user is accessing is specified with an ID in the querystring, so the VaryByParam=”*” should do the trick. Everywhere, that is, but one page: the very first page the user encounters and, coincidentally, the one with the problem.

To correct the issue, we (as in [Brendan](http://aspadvice.com/blogs/name)) added a VaryByCustom=”userName” attribute to the OutputCache directive, like so:

<!--EndFragment-->

```
<%@ OutputCache Duration=”99999″ VaryByParam=”*” VaryByCustom=”userName” %>
```

<!--StartFragment-->

Then, to make the VaryByCustom work, the final step is to add the following to Global.asax:

<!--EndFragment-->

```
public override string GetVaryByCustomString(HttpContext context, string arg)
{
if (arg == “userName”)
{
return context.User.Identity.Name;
}
return string.Empty;
}
```