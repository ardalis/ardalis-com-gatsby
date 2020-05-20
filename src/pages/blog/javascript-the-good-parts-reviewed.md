---
templateKey: blog-post
title: JavaScript The Good Parts Reviewed
path: blog-post
date: 2012-11-10T22:19:00.000Z
description: "Finished up Douglas Crockford’s JavaScript: The Good Parts this
  week. It definitely helped me improve my understanding of JavaScript, which
  I’ve been using since it was new, but always like a C programmer, and only
  recently like a JavaScript programmer."
featuredpost: false
featuredimage: /img/javascript-the-good-parts-500x360.jpg
tags:
  - book
  - javascript
  - review
category:
  - Software Development
comments: true
share: true
---
[](http://bitly.com/VJr2eG)Finished up Douglas Crockford’s [JavaScript: The Good Parts](http://bitly.com/VJr2eG) this week. It definitely helped me improve my understanding of JavaScript, which I’ve been using since it was new, but always like a C programmer, and only recently like a JavaScript programmer. I really appreciated Crockford’s honest, no-holds-barred analysis of JavaScript’s design and language choices. It had me chuckling more than once. I also appreciated that the book, at only 150 pages including the index, is devoid of fluff. There’s just enough repetition between chapters to ensure certain points are made and made well.

![](/img/cat.gif)

The book makes frequent use of [railroad diagrams](http://en.wikipedia.org/wiki/Syntax_diagram), which I’ve seen before but not nearly so widely used as in this book. I found these sometimes helpful, but I’ll admit that I skipped the full 10 page appendix full of them when I’d reached the end of the book. I’m not sure they did a great deal to improve my grasp of JavaScript, but I appreciated the attention to detail, and I know I can refer to them if I’m stuck wondering why a particular bit of JavaScript isn’t behaving the way I would expect (which is probably the way it would in, say, C#).

The book isn’t that old (published in May, 2008), but it does predate some of the newer JavaScript testing tools available online. For instance, Chapter 1 suggests that the reader can easily run JavaScript programs by creating a simple HTML file, and a program.js file, and then opening the HTML file in a browser. This of course still works, and it’s important to let people know this option is available, but I think if the book were re-released today, it would be improved if it pointed the user at a tool like [JSFiddle](http://jsfiddle.net/), where one can work interactively without the need to deal with files. For example, here’s [Hello World implemented on JSFiddle](http://jsfiddle.net/wHxhK) (probably for the millionth time). It’s worth noting that JSFiddle also supports JSLint, which I believe Crockford wrote, and which is covered in the book as well.

I made a few notes as I read the book. I particularly liked on page 3, where Crockford writes, “If you want to learn more about the bad parts and how to use them badly, consult any other JavaScript book.” I think I may have discovered a bug in the p. 6 railroad diagram, which appears to include an unnecessary ‘/’ following the opening ‘/*’ of a comment. I don’t see it listed in the book’s [errata](http://oreilly.com/catalog/errata.csp?isbn=9780596517748), but since the only place go from the ‘/’ is into an ‘any character except * and /’ block it seems the diagram would work equally well without the ‘/’. I may be missing a nuance of the syntax, though.

Chapter 4 covers Functions, and includes some interesting bits on function currying (which was new to me) and memoization, with examples of how to use this in your JavaScript code. Chapter 9 discusses Style, and notes, “Surprisingly, perhaps, we should also avoid features that are often useful but occasionally hazardous. Such features are attractive nuisances, and by avoiding them, a large class of potential errors is avoided.” Page 95 goes on to say, “And even if style doesn’t matter, isn’t one style as good as any other?” which I believe is another typo not listed in the errata (doesn’t should be does). The points are well made, however, especially “It turns out that style matters in programming for the same reason that it matters in writing. It makes for better reading.”

One of JavaScript’s bad parts requires that one use the K&R style of curly bracing in order to avoid bugs with return statements. This is noted in the Style chapter, and covered in detail in my favorite part of the book: Appendix A: Awful Parts. Semicolon insertion is one such awful part, and is responsible for the aforementioned return statement bug. If you write

return\
{\
status: true\
};

instead of\
return {\
status: true\
};

The first version will return undefined, while the latter returns a new object with a status of true. I also thought it was interesting that you can actually redefine the global variables for undefined and NaN, as they are not, in fact, constants or reserved words. Crockford writes “That should not be possible, and yet it is. Don’t do it.” 

There are many reasons why == is a Bad Part, explained in Appendix B: Bad Parts (along with a number of other Bad Parts). Despite the book’s name, I appreciate these appendices showing me which parts aren’t so good, and why. Finally, Appendix E is devoted to JSON, and includes a fully functional parse utility that avoids the need to use the (not so secure) eval() method.

Overall, very good book. I appear to have a later printing \[2011-04-08] that includes some of the errata from the book’s web site. My JavaScript-fu still isn’t as good as my C#, but I have a much better appreciation for JavaScript now, and a much better understanding of how to use it properly. I’d definitely recommend this book if you’re a JavaScript programmer, or a C# programmer looking to get better at JavaScript.