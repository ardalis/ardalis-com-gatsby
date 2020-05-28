---
templateKey: blog-post
title: When To Comment Your Code
path: blog-post
date: 2013-05-09T16:55:00.000Z
description: My opinions on comments in software code have evolved with my
  experience. When I was a teenager first learning to program for real, I rarely
  used comments unless the code was for an assignment, in which case it was a
  forced exercise every bit as much as teachers’ requests to “show your work”
  added verbosity to my math and science problems’ solutions.
featuredpost: false
featuredimage: /img/when-to-comment-your-code-760x360.png
tags:
  - asp.net
  - C#
  - clean code
  - code comments
category:
  - Software Development
comments: true
share: true
---
My opinions on comments in software code have evolved with my experience. When I was a teenager first learning to program for real, I rarely used comments unless the code was for an assignment, in which case it was a forced exercise every bit as much as teachers’ requests to “show your work” added verbosity to my math and science problems’ solutions. Of course, the programs themselves were quite simple, and the languages used (BASIC, Pascal) didn’t really support OOP (not that I knew what that was). And it was important, then, to be able to express the intent of the code in English, if only so the instructor knew what was being attempted. It wasn’t uncommon to receive partial credit for comments describing the approach one would take, not having had enough time to actually write the code itself.

Later on in college, my first course used Scheme and the classic [Structure and Interpretation of Computer Programs](http://mitpress.mit.edu/sicp/full-text/book/book.html) textbook. My first labs included comments not for the instructor, but for my own sake. Scheme is a very different kind of language from those I’d used before, and my lack of familiarity with it necessitated that I describe what esoteric blocks of parentheses were meant to be doing with comments. I still have that textbook, the first edition, which I noted as I wrote this doesn’t even mention comments in its index. The [second edition, which is available online](http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-15.html#%_idx_1836), has only this to say:

> “Semicolons in Scheme code are used to introduce *comments*. Everything from the semicolon to the end of the line is ignored by the interpreter. In this book we don’t use many comments; we try to make our programs self-documenting by using descriptive names.”

*Self-documenting* is an interesting term and relates to the discussion of comments. It even has a (small) [wikipedia entry devoted to the concept](http://en.wikipedia.org/wiki/Self-documenting). The chief objective of self-documenting systems, according to this source, is that they **make source code easier to read and understand**. In my opinion, source code should be written in such a way that its simplicity eliminates the need for most comments. I’ve collected here a number of [quotes](http://www.cs.cmu.edu/~pattis/quotations.html) and excerpts on the subject of comments, and have added my own thoughts to these as well.

> “The most reliable document of software is the code itself. In many cases, the code is the only documentation. Therefore, strive to make your code self-documenting, and where you can’t, add comments.”\
> – *[Daniel Read](http://www.softwarequotes.com/showquotes.aspx?id=684&name=Read,Daniel)* – The Principle of Self-Documenting Code.
>
> “The way to make programs easy to read is not to stuff them with comments… A good programming language ought to be better for explaining software than English. You should only need comments when there is some kind of kludge you need to warn readers about, just as on a road there are only arrows on parts with unexpectedly sharp curves.”
>
> *– P. Graham (in “Hackers and Painters” footnote 9, pg. 224)*

It’s hard sometimes to know what should or should not be commented, especially if you’re inexperienced. What seems worthy of commenting to you might be obvious to someone with a better grasp of the system or programming language you’re working with. Steve McConnell offers some advice on this.

[Code Complete](http://www.amazon.com/exec/obidos/ASIN/0735619670/aspalliancecom), by Steve McConnell, is on my list of [books I consider to be required reading for software developers](https://ardalis.com/favorite-developer-books) today. He notes:

> **Comments should explain the *why* instead of the *how* or *what*.**

Here are two examples of code from Code Complete that illustrate the poor usage of comments:

```
// First Example

//set product to base
product = base;
//loop from 2 to "num"
for ( int i = 2; i <= num; i++ ) {
//multiply "base" by "product"
product = product * base;
}
System.out.println( "Product = " + product );

// Second Example

//compute the square root of Num using the Newton-Raphson approximation
r = num / 2;
while ( abs( r - (num/r) ) > TOLERANCE ) {
r = 0.5 * ( r + (num/r) );
}
System.out.println( "r = " + r );
```

<!--StartFragment-->

McConnell concludes:

> **If the code is so complicated that it needs to be explained, it’s nearly always better to improve the code than it is to add comments.**

One of the simplest ways to achieve this is to name variables and classes consistently and descriptively, in plain English. Another is to keep methods small, well-named, and single-purposed. When you see a method growing out of control, that’s a sign that another method is growing inside of it – use *extract method* to set it free and give it a descriptive name.

When structuring a process, it’s a common practice to start out by writing comments for the steps involved, e.g.:

// Extract the data from the old system

// Transform the data

// Load the data into the new system

This is fine in my opinion as a way to organize one’s thoughts, but the next step isn’t to put 100 lines of code after each comment, it’s to replace each comment with a method name, e.g.:

Extract();

Transform();

Load();

A couple more quotes from Steve McConnell:

> Good code is its own best documentation. As you’re about to add a comment, ask yourself, “How can I improve the code so that this comment isn’t needed?” Improve the code and then document it to make it even clearer.
>
> *– S. McConnell*
>
>
>
> It’s OK to figure out murder mysteries, but you shouldn’t need to figure out code. You should be able to read it.
>
> *– S. McConnell*

**Comment Only What the Code Cannot Say**

[![97thingscover](/img/97thingscover.jpg "97thingscover")](http://www.amazon.com/gp/product/0596809484?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596809484) 

In [97 Things Every Programmer Should Know](http://www.amazon.com/gp/product/0596809484?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596809484), Kevlin Henney writes a small essay on comments, including:

> What of comments that are not technically wrong, but add no value to the code? Such comments are noise.
>
> A prevalence of noisy comments and incorrect comments in a code base encourage programmers to ignore all comments, either by skipping past them or by taking active measures to hide them.
>
> Try to express as much as possible through code. Any shortfall between what you can express in code and what you would like to express in total becomes a plausible candidate for a useful comment. Comment what the code *cannot* say, not simply what it does not say.
>
> [[Read the full essay here](http://programmer.97things.oreilly.com/wiki/index.php/Comment_Only_What_the_Code_Cannot_Say)]

Again, the point is made that comments should not say what code simply does – the code should do that already. If the code isn’t clear, *make it clear*.

If your clothes are smelly, **wash them**, don’t spray Axe body spray all over them to try and communicate that they shouldn’t smell.

My own contribution to the 97TEPSK book is the [Don’t Repeat Yourself principle](https://ardalis.com/don-rsquo-t-repeat-yourself) (I didn’t invent it, I just wrote about it for the book). Comments that say only what the code already makes clear merely add noise and violate the Don’t Repeat Yourself principle. They invite bugs for all the usual reasons that repetition in software attracts bugs, and have the added effect of **drowning out any truly insightful and important comments** by training developers to ignore comments.



**Comments Can Be (and frequently are) Wrong**

…and the only way to know it is to read and understand the code.

> “A comment is of zero (or negative) value if it is wrong.”
>
> *– Kernighan and Plauger, The Elements of Programming Style*
>
> “If the code and the comments disagree, then both are probably wrong.”
>
> *– N. Schryer*
>
> Don’t get suckered in by the comments -they can be terribly misleading: Debug only the code.
>
> *– D. Storer*

Since you can’t trust comments to be correct, and you can’t verify their correctness in any automated fashion (at the time of this writing, I’m unaware of any comment unit testing frameworks), the only way to verify the correctness of comments is to read and understand the code they relate to. If the comment attempts to express what the code does, then if ever the code or the comment changes such that the two are no longer in sync, bugs are bound to occur if the comment rather than the code is used as the basis of understanding what the application does.



**In Software Design**

> There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
>
> *– C.A.R. Hoare*

Which of the above two software designs do you think would require more comments? Interestingly, one quote sees the act of being forced to write comments as being potentially helpful to design:

> Being forced to write comments actually improves code, because it is easier to fix a crock than to explain it.
>
> *– G. Steele*

The assumption seems to be that one need only comment the ugly bits in the code, and so by cleaning them up one avoids the necessity of explaining the ugliness.



**In Communication**

> Omit needless words. Vigorous writing is concise. A sentence should contain no unnecessary words, a paragraph no unnecessary sentences, for the same reason that a drawing should have no unnecessary lines and a machine no unnecessary parts.
>
> *– W Strunk Jr (in The Elements of Style)*

Software source code is written for two audiences: computers and programmers. Computers don’t care what the code looks like, how it’s organized, what things are named, and certainly what the comments say. Programmers, of course, will care about many of these things. By keeping the source code simple and without unneeded noise, we maximize its clarity as an instrument of communication. Note that I’m not suggesting we minimize the number of characters used or anything silly like that. But we should avoid redundancy and repetition and vestigial blocks of text that serve no functional purpose as much as possible, as these cloud the clarity of the code.

> “The most common kind of coding bug, and often considered the least harmful, are documentation bugs (**i.e., erroneous comments**). Although many documentation bugs are simple spelling errors or the result of poor writing, many are actual errors – that is, misleading or erroneous comments. We can no longer afford to discount such bugs, because their consequences are as great as ‘true’ coding errors. Today programming labor is dominated by maintenance. This will increase as software becomes even longer-lived. Documentation bugs lead to incorrect maintenance actions and therefore cause the insertion of other bugs. ”\
> – [Boris Beizer](http://www.softwarequotes.com/showquotes.aspx?id=558&name=Beizer,Boris) – Chapter 2: The Taxonomy of Bugs, Section 3.5. , Software testing techniques by Boris Beizer , ISBN: 0442206720

<blockquote class="twitter-tweet" data-lang="en">
<p lang="en" dir="ltr">"A common fallacy is to assume authors of incomprehensible code will be able to express themselves clearly in comments." - <a href="https://twitter.com/KevlinHenney">@KevlinHenney</a></p>
— Rich Rogers (@RichRogersIoT) <a href="https://twitter.com/RichRogersIoT/status/717381923736326144">April 5, 2016</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8" async=""></script>

**Here Be Dragons**

In addition to expressing *why*, comments should also be used to explain *why not*.

> “Write comments that emphasize potential hazards. ”\
> – *[Steve Maguire](http://www.softwarequotes.com/showquotes.aspx?id=552&name=Maguire,Steve)* – Chapter 5: Candy-Machine Interfaces. , Writing Solid Code: Microsoft’s Techniques for Developing Bug-Free C Programs by Steve Maguire , ISBN: 1556155514

![image](/img/image_3_comment.png "image") Sometimes you’ll find that code needs to be written in a way that might not be intuitive to another programmer (or yourself) at a later date. Maybe it is inconsistent with the usual way things are done, or it appears to be inefficient and in need of optimization, but you know, at this moment, that the consistent or optimized way does not work, while the current implementation does. Here is a great opportunity to say what the code cannot with a comment: why not optimize it?

Like caution signs on roadways, comments can warn of dangers in the codebase. But just like ubiquitous “Are you sure?” windows, too many comments can condition developers to ignore the important warnings along with the noise.

[[more on Here Be Dragons origins](http://en.wikipedia.org/wiki/Here_be_dragons)]



**Comment Therapy**

If you’ve had comment-writing beaten into you to the point where it’s not natural for you to simply write code that expresses what it does clearly, consider these techniques:

> “When you feel the need to write a comment, first try to refactor the code so that any comment becomes superflouus.”\
> – *[Martin Fowler](http://www.softwarequotes.com/showquotes.aspx?id=573&name=Fowler,Martin)*, Refactoring: Improving the Design of Existing Code by Martin Fowler, Kent Beck (Contributor), John Brant (Contributor), William Opdyke, don Roberts , ISBN: 0201485672

And of course, if you really want to know what code does, read (and execute) the tests for the code. If the tests are written in a self-documenting fashion, they should have expressive names that tell you how the code should behave under certain circumstances. Does it throw an exception when you pass in a null parameter? Hmm, well there’s a test called FooShouldThrowExceptionWhenParameterIsNull, and it’s Green, so I’m going to say that yes, at this moment, that’s the behavior. What, there’s no test for that? You know how to fix that, don’t you?

**Comments for Documentation**

Many programming languages support some kind of documentation-extracted-from comments feature. In .NET there are /// <summary>…</summary> XML comments that can be used with NDoc / Sandcastle. In Java there is JavaDoc. If you’re generating such comments, my first question is, is anybody actually reading the generated documentation? My second question is, how useful is it? I’ve probably searched for some documentation on a class hundreds of times only to end up on a website with the auto-generated documentation where it says only the most obvious of information about the class – and provides no examples. [http://msdn.microsoft.com](http://msdn.microsoft.com/) used to be awful in this regard, but has lately gotten much better.

If you’re shipping a framework or a product with a public API, then obviously documentation of what the code does is important. However, in both of these cases only the public interface needs to be described in great detail, and in .NET you can actually [apply your XML comments to an interface, rather than to a class](https://ardalis.com/use-interfaces-for-metadata-and-comments), which I think makes more sense since ideally you want the interface to be the primary way other components interact with your framework and classes, to avoid tight coupling. XML comments on interfaces are also picked up by Intellisense in Visual Studio for classes implementing the interface.



**Clean Code**

[![](<>)](http://www.amazon.com/gp/product/0132350882?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0132350882)In [Clean Code](http://www.amazon.com/gp/product/0132350882?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0132350882), Robert “Uncle Bob” Martin devotes a chapter to Good Comments (chapter 4). Here’s a brief excerpt from the start of the chapter, with which I agree completely:

> The proper use of comments is to compensate for our failure to express ourself\[sic] in code. Note that I used the word *failure*. I meant it. Comments are always failures. We must have them because we cannot always figure out how to express ourselves without them, but their use is not a cause for celebration.
>
> So when you find yourself in a position where you need to write a comment, think it through and see whether there isn’t some way to turn the tables and express yourself in code. Every time you express yourself in code, you should pat yourself on the back. Every time you write a comment, you should grimace and feel the failure of your ability of expression.
>
> Why am I so down on comments? Because they lie. Not always, and not intentionally, but too often.
>
> Truth can only be found in one place: the code. Only the code can truly tell you what it does. It is the only source of truly accurate information.

So, since you can’t trust comments, you have to read the code to know what it does. And since you’re going to have to read (and understand) the code anyway, it’s certainly better to spend the energy and thought making the code simple and clear and readable, rather than trying to explain what a mess of code is attempting to do (or was at some point in the past when the comment was added).

Clean Code also goes on to recommend that boilerplate comments such as licensing/copyright information, change history, and old blocks of code that might someday be useful can all be replaced with proper version control systems and post-build processes that leave the actual source files small and clean. Use the right tool for the job – source control is a much better way to store change history and [vestigial code](https://ardalis.com/principles-patterns-and-practices-of-mediocre-programming) than within the code itself, and no programmer working day-in and day-out should need to trip over legalese that can easily be appended to the top of every file out-of-band or as part of packaging the files for a release.

Clean Code is another book I highly recommend, and is one of [my favorite developer books](https://ardalis.com/favorite-developer-books).

**Summary**

While not strictly evil, comments should generally be avoided where the code can tell what it does as well or better. Good comments tell only what the code cannot express itself, such as why a particular technique was favored or the dangers of optimizing a block of code. Most other kinds of comments are simply noise, and their presence clutters of code, making it more difficult to understand and creating errors when, inevitably, the comments get out of sync with the code they reference. Overuse of comments also tends to make real warnings less noticeable, just as the boy who cried wolf trained the townspeople to ignore is warnings. Consider carefully how and when comments should be used within your codebase.