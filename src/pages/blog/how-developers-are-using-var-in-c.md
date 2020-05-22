---
templateKey: blog-post
title: How Developers Are Using var in C#
path: blog-post
date: 2011-06-14T19:04:00.000Z
description: "The var keyword was introduced in C# 3.0, and has since gained
  quite a bit of popularity.  There is also a fair bit of contention over how it
  should be used, with posts like this one (with which I happen to agree) being
  not uncommon.  "
featuredpost: false
featuredimage: /img/csharp_logo.png
tags:
  - C#
  - csharp
category:
  - Software Development
comments: true
share: true
---
The var keyword was introduced in C# 3.0, and has since gained quite a bit of popularity. There is also a fair bit of contention over how it should be used, with [posts like this one (with which I happen to agree) being not uncommon](http://www.ben-morris.com/implicitly-unreadable-the-c-var-keyword-and-lazy-code). Over the last week I posted a couple of polls on twitter that asked about specific scenarios in which one might use var, trying to address the two scenarios outlined by the author of that post.

**Scenario One**

This was meant to depict the case where the type would appear twice on one line, and so using var makes the code more succinct while no less clear.

[![image](<> "image")](http://twtpoll.com/r/a3w7j7)

[http://twtpoll.com/r/a3w7j7](http://twtpoll.com/r/a3w7j7 "http\://twtpoll.com/r/a3w7j7")

75% of respondents agree that this is a scenario in which you should use the var keyword. I’ve heard from more than one person (including the article linked in the first paragraph) that *even better* would be if you could instantiate a variable more easily, as in String s = new(); or alternately to not require the type at all on the left:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/5b828ad0a2eb_78E4/image_5.png)

Of course, neither of those options are going to fly with C# (without some significant changes to the compiler), so getting back to “things we can actually do today with C#” we come to the second scenario.

**Scenario Two**

In this scenario I’m going for the case where there is some method that is returning a type, and the type isn’t obvious.

[![image](<> "image")](http://twtpoll.com/r/uqleb8)

[http://twtpoll.com/r/uqleb8](http://twtpoll.com/r/uqleb8 "http\://twtpoll.com/r/uqleb8")

So the question comes down to, should you use var to declare variables that are initialized from a method call such that the type being returned is not obvious? 64% of respondents still favor using var in this case. Personally, I prefer the somewhat more clear red option, since it’s apparent immediately what the type of result is, but obviously I’m in the minority (for this poll) in this case.

**Scenario Three**

The third question was in response to some comments and questions I had about the first scenario. Some folks contended that in the case of var s = new String(); it wasn’t really worth it to use var, but that they would use var if it was a very long, complex, or convoluted type. So that’s what this question was meant to reflect.

[![image](<> "image")](http://twtpoll.com/r/0gppq0)

[http://twtpoll.com/r/0gppq0](http://twtpoll.com/r/0gppq0 "http\://twtpoll.com/r/0gppq0")

In this case 78% (3% more than scenario one) agree that one should use var here. A number of people suggested that a custom type would be better than the ugly Dictionary of Dictionaries that I used in my example, resulting in some of the 3% Other votes (and I agree, but I was just going for a long and complex type, so work with me here). Less than 20% of respondents felt that it was worthwhile to type out the complex type twice on this particular line of code.

A scenario that I’m obviously leaving out is where anonymous types are required. These can only be represented by var, and are the main reason for its introduction into the C# language in the first place. Thus, I didn’t see much value in polling people about its usage in this case.

**Summary**

Although initially there was a fair bit of skepticism about its usage, it appears from these unscientific polls that the var keyword has gained widespread acceptance among C# developers. In fact, its usage has become the rule, rather than the exception, even in scenarios where the actual type of the variable in question is not immediately obvious upon examining its declaration (as in scenario two, above). I personally think that the rise in popularity of dynamic languages like Ruby and JavaScript has a lot to do with this trend, perhaps combined with the widespread acceptance of using a powerful IDE like Visual Studio (as opposed to a plain text editor) that is easily able to provide type information via mouseover or Intellisense. What do you think? How do you prefer to use var, and how does your organization try to enforce var usage among its developers (if at all)?