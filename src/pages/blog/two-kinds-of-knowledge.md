---
templateKey: blog-post
title: Two Kinds of Knowledge
path: blog-post
date: 2008-03-30T12:20:00.000Z
description: "[Rick] posted earlier today about [how he’s having a tougher and
  tougher time remembering the exact syntax and details of how to do relatively
  simple programming tasks], and instead finds that he’s going off to find past
  code he’s written (or blogged about) **all the time**."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASPAlliance
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Rick](http://west-wind.com/weblog) posted earlier today about [how he’s having a tougher and tougher time remembering the exact syntax and details of how to do relatively simple programming tasks](http://west-wind.com/weblog/posts/295840.aspx), and instead finds that he’s going off to find past code he’s written (or blogged about) **all the time**. Is it the early onset of senility, or is this typical? It’s the same for me, and it reminds me of something I learned in high school about things one knows. There are two kinds of knowledge (and this predated the Internet so the latter was not nearly as easily accessed): Things You Know and Things You Know Where To Find.

**Things You Know**

Things you know are stored “by value” in your brain. I call this**intrinsic knowledge**. You actually have the data in there, ready to pull it out at a moment’s notice. This includes a ton of numerical data, like your social security number or phone number, zip code, etc as well as lots and lots of other kinds of data. Your language skills, the names of everyone you know (whose name you can remember  ), etc. This is what most people think of when they think about what they know, and games like Trivial Pursuit are built around this kind of knowledge.

**Things You Know Where To Find**

The second kind of knowledge consists of things you’ve stored “by reference” in your brain. The actual data is **extrinsic knowledge**, but the learned skill the individual possesses is **how to find it**. Today, you may not know your best friend’s phone number, but you know where to find it (in your cell phone). Most people who grew up before the 90s learned how to use a phone book (without a [built in search](http://www.whitepages.com/)!) and encyclopedia (before [wikipedia](http://en.wikipedia.org/wiki/Wikipedia)!). Today of course, you can quickly locate all kinds of things from [trivia](http://www.google.com/search?q=who+won+the+1928+world+series%3F&rls=com.microsoft:*:IE-SearchBox&ie=UTF-8&oe=UTF-8&sourceid=ie7&rlz=1I7ADBF) to [weather](http://www.google.com/search?hl=en&rls=com.microsoft%3A*%3AIE-SearchBox&rlz=1I7ADBF&q=weather+kent+ohio) to [movie times](http://search.live.com/results.aspx?q=kent+ohio+movie+times&mkt=en-us&scope=&FORM=LIVSOP) with a few mouse clicks, and more and more often, from your phone. The need to actually store information has greatly diminished when compared to the need to know how to access information (which can be stored far more efficiently).

**Effects of this Shift on Developers**

More and more, developers rely on the Internet to quickly find answers to their problems. Sites like [ASPAlliance.com](http://aspalliance.com/) and others like them were created by this demand, which of course has its share of pros and cons. On the plus side, developers can move past problems much faster if they don’t have to go trolling through a 3-ring binder with the latest spec from the vendor on the parameter ordering for some API and can instead just grab a sample online. However, this assumes that the sample they found online is actually correct, which oftentimes is a faulty assumption. For one thing, the developer may think that if the code works, it must be correct, but unfortunately there’s more to good code than just compiling and returning the expected result. A lot of examples, especially simple ones, have serious problems with error handling, performance, security, or all of the above and more. A developer who doesn’t have the **innate knowledge** required to see these issues in the code they find may be able to churn out working code at an acceptable pace (for the project and its managers), but the quality of that code will be seriously questionable.

Rick raised the question of how would he do in an interview, if asked to write out from memory the code required to fill a DataSet from an adapter (probably not good, he thought). In my opinion, this is not a terribly useful interview question. In my own interviews, I ask candidates to actually write a working program (a small one), using the tools I expect them to use while on the job (visual studio and full Internet access). Seeing what they’re able to come up with in this environment is far more telling, and lets me evaluate both their intrinsic knowledge and their ability to find what they don’t “just know”. I’m not going to intentionally cripple my developers by cutting them off from the Internet, so interviewing them in that context is a waste of everybody’s time. But I do want to see that they are able to utilize their tools, including the Internet, effectively, and that they are able to properly evaluate and utilize what they find there.

Another useful interview technique is to take some simple code with problems (no exception handling, performance issues, resource leaks, bad need of refactoring, etc. All the crap you find in 90% of the online examples someone will grab) and ask them to fix it. Depending on the level of the candidate, you might just give them that much to go on, or you might ask them to provide some proper error handling or resource cleanup (e.g. the using() statement).

One good way to avoid the risk of using lousy code when searching the Internet is to use your own code. My first articles were all written for my own use, and only later became popular with others online. As a consultant, I wanted to be able to store my own personal notes somewhere I could access them from any client, and so I added them to my column [on ASPAlliance.com as far back as 1998](http://web.archive.org/web/19981201200150/www.aspalliance.com/stevesmith). I got tired of reinventing the wheel with regular expressions, so I created the [Regular Expression Library, regexlib.com](http://regexlib.com/). With the ubiquity of blogs today, it’s a simple thing for any developer to keep their own collection of code snippets and samples available online for their own use, and I think this is a great way to get the best of both worlds. Not only that, but if you’re concerned about how you’ll do in an interview, I think most employers would be impressed by your ability to locate solid examples of how to accomplish typical programming tasks **on your own blog or web site**. I know I would be.

<!--EndFragment-->