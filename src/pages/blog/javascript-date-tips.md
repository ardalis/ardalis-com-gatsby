---
templateKey: blog-post
title: JavaScript Date Tips
path: blog-post
date: 2014-07-18T15:01:00.000Z
description: The other night at the Hudson Software Craftsmanship meeting at the
  Falafel Software training center in Hudson, Ohio, I did the Red Pencil Kata
  using JavaScript.
featuredpost: false
featuredimage: /img/java-script.png
tags:
  - dates
  - javascript
  - tip
category:
  - Software Development
comments: true
share: true
---
The other night at the [Hudson Software Craftsmanship](http://hudsonsc.com/) meeting at the [Falafel Software training](http://falafel.com/training) center in Hudson, Ohio, I did the [Red Pencil Kata](http://stefanroock.wordpress.com/2011/03/04/red-pencil-code-kata) using JavaScript. Although I’ve run into it in the past, I was stuck for a little while (I was the odd man out without a pairing partner to help find these things faster) due to one of JavaScript’s “fun” date conventions. Being a C# developer primarily, there are many small things I have to remember that are different between JavaScript and C# (like [where to declare variables](http://ardalis.com/where-to-declare-variables-in-csharp-and-javascript), for instance). In this case, it was the code for generating a particular date that bit me. At one point, I wanted to generate a date that was over 30 days in the past (relative to the current date, which was 16 July 2014), so I wrote this:

**var day1 = new Date(2014, 6, 14); // javascript**

If I were in C#, this code would have worked fine:

**var day1 = new DateTime(2014, 7, 11); // C#**

You see, the folks who wrote C# were not **insane**, and so they didn’t arbitrarily make the middle ‘month’ parameter 0-based, like the JavaScript folks did. In my kata, it was important that certain things happen around the 30-day window, and of course my silly mistake had created a date that was only 3 days in the past, not 32. Oops. Of course, you should be able to avoid this by using a string, right? That’s what some of my fellow developers suggested. What do you suppose this yields?

**var day1 = new Date(“2014-07-01”); // javascript**

If you answered **30 June 2014**, you’re right! Of course, that’s just what you would expect, too. WAT?

Of course, if you use something hideous like this, it works correctly (in the United States, which expects M/D/Y format):

**var day1 = new Date(“7/14/14”); // javascript**

This, too, will give you what you expect, though it’s a bit verbose:

**var day1 = new Date(“July 14, 2014”); // javascript**

Go ahead and play with these options yourself [here](http://jsfiddle.net/ardalis/kE2JY/1):

<iframe width="100%" height="300" src="https://jsfiddle.net/ardalis/kE2JY/1/embedded/"></iframe>

## Reading Dates (in older browsers)

This has been fixed with ECMAScript 5, but older browsers will still misbehave. If you try to read a zero-padded date, such as “09” for September, using parseInt, you may get an unexpected result because parseInt assumes zero-prefixed strings are in octal format. To avoid this potential issue, always pass in the second parameter to parseInt (for which you’ll typically want to pass a 10). Alternately, you can override parseInt so that if it is called with just one argument it will always use 10 for the radix, on all browsers, as shown [here](http://stackoverflow.com/a/13037858/13729). The fiddle below demonstrates the issue – if you’re using a modern browser, the result of the first operation should be 9. Try it on an older browser and see what you get.

<iframe width="100%" height="300" src="https://jsfiddle.net/ardalis/bUWfA/2/embedded/"></iframe>

Any other date-related tips you’d like to share? I’d love to hear them in the comments.