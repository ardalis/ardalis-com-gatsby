---
templateKey: blog-post
title: JavaScript let const and var
date: 2018-02-13
path: blog-post
featuredpost: false
featuredimage: /img/javascript-let-const-and-var.png
tags:
  - javascript
  - tip
category:
  - Software Development
comments: true
share: true
---

In the latest version of JavaScript, there are several ways to declare variables: **let**, **const**, and of course, **var**. If you've been using JavaScript for a while, you're familiar with var, which has been a part of the language from the start. The two new keywords added with EcmaScript 6 (ES6) are let and const, and they offer different scoping than var. I'll start with my recommendation on when to use each of these, and then I'll back that up with a bit on how they work at the end.

## Prefer const Over let Or var

You should prefer const when declaring variables in JavaScript (ES6+). If you are assigning a value to a variable, and you're not going to be reassigning that value, const is the safest choice and communicates this intent. You should avoid reusing variables for different purposes; instead, use multiple different well-named variables if you need to represent multiple values. You should take advantage of the fact that while declaring an object with const doesn't actually make it immutable (you can still change its properties, etc.), it does at least protect the instance from being reassigned. Another reason to prefer const over var is that it is block scoped, not function scoped. That means you won't accidentally add const-defined variables to the global scope if you define them within a block (such as part of an if statement or loop) but not within a function.

## Use let For Loop Control Variables

Follow the first rule and use const wherever you can. But there are some cases where you can't, like when you're writing a loop. In that case, you should default to using let. Let is block scoped just like const, but can be re-assigned, as is required by looping constructs like for loops.

## Avoid var

If you're writing JavaScript using functions and are generally taking advantage of scoping, you'll probably want to avoid var as a general rule. It's more likely to introduce scoping issues and is less intention-revealing than the newer keywords const and let in most scenarios. If you're in a block in which you're going to assign a variable exactly once, then there's no reason not to use const.  If you need a variable to be re-assigned as part of a loop construct, choose let, which is block scoped. If you need a variable that isn't block scoped and/or that you're going to want to re-assign, then first consider whether your design is a good one, and then use var if you determine it is. However, use of var in these scenarios should certainly be the exception, not the rule.

[Wes Bos writes more on this topic, and links to some differing viewpoints.](http://wesbos.com/javascript-scoping/)

Check out my podcast, [Weekly Dev Tips](http://www.weeklydevtips.com/), to hear a new developer productivity tip every week. You can also [join my mailing list](/tips) for similar (but different!) tips in your inbox every Wednesday!
