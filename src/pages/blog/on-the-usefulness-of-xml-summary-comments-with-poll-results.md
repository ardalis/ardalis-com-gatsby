---
templateKey: blog-post
title: On the Usefulness of Xml Summary Comments with Poll Results
path: blog-post
date: 2011-06-13T19:10:00.000Z
description: Last week I hosted a quick poll on Twitter about how useful a
  particular XML comment was for a particular class. The code looked like this.
featuredpost: false
featuredimage: /img/vote.png
tags:
  - xml comments
category:
  - Software Development
comments: true
share: true
---
Last week I hosted [a quick poll on Twitter](http://twtpoll.com/r/z47mls) about how useful a particular XML comment was for a particular class. The code looked like this:

```
<span style="color: #008000">/// &lt;summary&gt;</span><br /><span style="color: #008000">/// Repository for handling Users.</span><br /><span style="color: #008000">/// &lt;/summary&gt;</span><br /><span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> UserRepository : Repository&lt;User&gt;<br />
```

The poll actually got 355 votes, which is pretty impressive. In hindsight I should have added an option relating to generating documentation, or updated the “necessary evil” option to include documentation as a valid reason for having these, since a large number of comments pointed to documentation as a motivation for this. Or intellisense. Personally I don’t see how the above would provide me with anything useful either as documentation or via intellisense, and I know it frustrates me to no end when I go to MSDN or a help file and I find this level of documentation on a public framework or API. However, the vast majority of developers aren’t developing public frameworks or APIs, so I think the need for generating docs is certainly a minority case.

Here’s the results from the poll:

![image](<> "image")

Two people actually thought the comment was “essential” to understand the code. I’m not surprised that this is a small number. I would be inclined to ask the two who answered this, “Really?” I just don’t get it. Sorry.

4% of respondents found the comment useful. I’m assuming they’re also some of the ones who noted things like “The comment is practical for Intellisense.” I’m not sure how it’s terribly useful for increasing one’s understanding of the code (except those 2 respondents above).

About a quarter of respondents felt the comment block was a “necessary evil” because they favored requiring such comments to ensure that comments were written for classes that actually merited them. Again I’m guessing that many of these respondents also felt it was a necessary evil because of the documentation generation and/or Intellisense factor. 7% voted “Other” and I’m guessing many of these feel the same way, so I would unscientifically say that about 30% of respondents feel that the comment block, while probably not ideal in terms of what it’s saying, is useful in general because of the benefits it yields in some fashion outside of the scope of reading this code (e.g. documentation or intellisense).

64% of respondents felt the comment was a complete waste. A few disagreed that it obscured the ability to read the code, and I can understand that. My reason for including that in the response was that I’ve often had to deal with code bases that include so many required comments on every little field that it’s almost impossible to see the actual code among the clutter. In that kind of scenario, I see such comments as being obscuring, rather than clarifying, the intent of the code (and in case it’s not obvious, I voted for this option myself). I’ve written about [when you should comment your code](/when-to-comment-your-code) before, as well as one way that you can [reduce the friction from these kinds of comments by putting them on your interfaces, not your implementations](/use-interfaces-for-metadata-and-comments).

**Can Our IDE Fix This, Please?**

I do agree that Intellisense if a wonderful tool, and that generated documentation that lives near the code is a good thing. However, I don’t think comments are necessarily the best way to achieve this. Considering that we’re talking about C# code, it’s almost a given that we’re talking about Visual Studio for our IDE. Thus, it would be pretty easy to build something that leveraged the tool to specify the comments and/or other documentation, without having to force the user to deal directly with verbose XML or bloat their code with many lines of non-running code. Imagine if the experience for dealing with code documentation and Intellisense mirrored Intellisense itself. That is, if you were to mouse over a class, method, or property (or select it and use a keyboard shortcut), the current help would appear in a tooltip. In addition to showing the documentation, it would, if you were hovering over the declaration of the item in question, allow you to edit the current documentation. You would make your edits in a small dialog using a rich editor, not direct XML markup, and save them with with a click or keyboard shortcut. This documentation would be stored somewhere – I’m not too picky about where. Probably the most sensible location would be in a side-by-side file with the class in question, e.g. Foo.cs.xml or Foo.cs.docfile, which Visual Studio would normally keep hidden.

I would love to see richer, more intelligent support for documentation within our tools, and like 2/3 of other developers, I’d like to see an end to useless clutter in my source code in the form of check-the-block XML summary comments.