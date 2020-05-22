---
templateKey: blog-post
title: Dont Forget Block Selection Using Alt in Visual Studio
path: blog-post
date: 2012-11-18T21:18:00.000Z
description: So do you ever find yourself wanting to try out some code you found
  on the Internet (via Copy Paste Programming, but in a spike or test project,
  naturally!), and unfortunately when you copy the code it includes a bunch of
  line numbers? Like the code from this sample on testing Entity Framework
  stuff?
featuredpost: false
featuredimage: /img/testclass.png
tags:
  - selection
  - tips and tricks
  - visual studio
category:
  - Software Development
comments: true
share: true
---
So do you ever find yourself wanting to try out some code you found on the Internet (via [Copy Paste Programming](http://deviq.com/copy-paste-programming), but in a spike or test project, naturally!), and unfortunately when you copy the code it includes a bunch of line numbers? Like the code from this sample on [testing Entity Framework stuff](http://www.andrewconnell.com/blog/archive/2012/05/02/isolating-integration-tests-with-ef4-x-code-first-amp-mstest.aspx)?

```
  1: [TestClass]
 
  2: public class TestRunDatabaseCreator {
 
  3:  4:   public const string DATABASE_NAME_TEMPLATE = "CPT_CDS_{0}";
 
  5:
```

Of course, [some code highlighting tools make this a little easier for you, and Scott Hanselman shows off some options.](http://www.hanselman.com/blog/HowToPostCodeToYourBlogAndOtherReligiousArguments.aspx) But in this case, the post was made some time ago, so I don’t think we can rely on the author to change how they’ve chosen to post the code itself. There’s always the manual option, which I know I’ve done plenty of times. That is, type del del del del del downarrow, del del del del del downarrow, … repeat. That gets old fast – there should be a better way.

Fortunately, there is, and it’s been around for a long time. I was just reminded of it today, and thought I’d share for those of you who don’t know about it. Just use the block selection option in Visual Studio, which you get by holding down Alt while selecting with the mouse. Take some code like this:

![](/img/testclass.png)

Highlight with the mouse while holding alt:

![](/img/testclass-2.png)

And hit delete. Problem solved.

Share this if it helped you, and happy coding!