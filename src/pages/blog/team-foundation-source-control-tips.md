---
templateKey: blog-post
title: Team Foundation Source Control Tips
path: blog-post
date: 2006-07-05T03:59:30.138Z
description: "Barry Gervin recently wrote some nice tips for working with source
  control and Team System on a mailing list:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - team system
  - mailing list
  - ""
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Barry Gervin](http://www.objectsharp.com/Barry) recently wrote some nice tips for working with source control and Team System on a mailing list:

> The best guidance is to do a Get on the entire tree just before you begin a new logic of work. Work on it for however long it takes – and then when you are ready to check it in – do another get latest first and make sure you can still build/run tests. This is an important step to properly integrate/merge your changes into the latest (and avoid breaking the build). When you are finally ready to check in, and if you have enabled multiple checkouts – you may still get merge conflicts on the files you are checking in – which will be your final part of the merge process. Resolve those conflicts, check in, and watch the build to make sure all is cool.
>
> If you have a busy tree (i.e. lots of busy devs working against it) this works well. If you were to end up doing a get everytime you decide you have another file to check out…you’d really end up doing a merge/integration at this point and because of cascading changes/dependencies – the merge/integration can be non-trivial – best to do it only once.
>
>
>
> The best practice here is to confine your personal iterations to small, buildable, logical units of work.

He also pointed me to[Buck Hodges post](http://blogs.msdn.com/buckh/archive/2005/08/20/454140.aspx)(which in turn quotes[Doug Neumann](http://forums.microsoft.com/msdn/ShowPost.aspx?PostID=70231), so I’m up to 3 levels of depth in my quote-of-a-quote-of-a-quote-of-a-quote):



> It turns out that this is by design, so let me explain the reasoning behind it. When you perform a get operation to populate your workspace with a set of files, you are setting yourself up with a consistent snapshot from source control. Typically, the configuration of source on your system represents a point in time snapshot of files from the repository that are known to work together, and therefore is buildable and testable.
>
> As a developer working in a workspace, you are isolated from the changes being made by other developers. You control when you want to accept changes from other developers by performing a get operation as appropriate. Ideally when you do this, you’ll update the entire configuration of source, and not just one or two files. Why? Because changes in one file typically depend on corresponding changes to other files, and you need to ensure that you’ve still got a consistent snapshot of source that is buildable and testable.
>
> This is why the checkout operation doesn’t perform a get latest on the files being checked out. Updating that one file being checked out would violate the consistent snapshot philosophy and could result in a configuration of source that isn’t buildable and testable. As an alternative, Team Foundation forces users to perform the get latest operation at some point before they checkin their changes. That’s why if you attempt to checkin your changes, and you don’t have the latest copy, you’ll be prompted with the resolve conflicts dialog.
>
>
>
> <http://blogs.msdn.com/buckh/archive/2005/08/20/454140.aspx>

I agree with some of the comments to Buck’s post that CheckOut/CheckIn don’t really apply in the team system paradigm. I’d like to throw my $.02 behind the “commit” term.

<!--EndFragment-->