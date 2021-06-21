---
templateKey: blog-post
title: Improving Method and Function Clarity
date: 2021-06-22
description: When you look at a method or function, it should have a name that describes what it does. Naming things is hard but important, and probably the most important thing you can do when you design a method or function is give it a good name.
path: blog-post
featuredpost: false
featuredimage: /img/improving-method-function-clarity.png
tags:
  - programming
  - naming things
  - code quality
  - quality
category:
  - Software Development
comments: true
share: true
---

(Originally sent to my [weekly tips subscribers](/tips) in March of 2019)

When you look at a method or function, it should have a name that describes what it does. Naming things is hard but important, and probably the most important thing you can do when you design a method is give it a good name.

The second-most important thing you can do is make the thing it's supposed to do incredibly obvious in the code itself. What you don't want is a method that says "DoX" and then when you go to read it the method says:
Check if this state is Foo
Check if this other state is Bar
Check this other argument to make sure it's at least 42
Do this seemingly unrelated thing
Do the thing
Do another unrelated thing
Return an error in an else block from a check
And from another check
And from the first check
Return success if you got here
It takes a fair bit of investigative work for someone reading this code to discover "Do the thing" in a deeply nested if statement 50 lines deep into the method, surrounded by all that other crap. If you want your methods to be more clear, keep them short and keep them focused on the happy path. That is, the thing they're all about doing when everything goes right.

How do you do that? Well, first, keep them short. No, shorter than that, even.

Second, avoid else statements. If you have to do validation in the method, use the guard clause pattern so you can exit immediately if values are invalid. If you can quickly return a value in some cases, do that early in the method as well, again without an else clause - just return.

Third, use wrapper functions. If you absolutely must catch an exception as part of this method, move the body of the try block into its own method so the only thing in the calling method is the try-catch. Name both methods appropriately.

There are other tricks you can do but at the end of the day the method's name and what it does should match and both should be extremely obvious to anyone reading the code, not buried in deeply nested conditional constructs.
