---
templateKey: blog-post
title: Comments in Code Indicate Functions Trying To Escape
path: blog-post
date: 2008-05-01T01:37:29.145Z
description: I interviewed a couple of college students earlier this week for
  internship positions with Lake Quincy Media, and one of them reminded me of my
  own college days when we were graded in part based on how well commented our
  code was.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - comments
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I interviewed a couple of college students earlier this week for internship positions with [Lake Quincy Media](http://lakequincy.com/), and one of them reminded me of my own college days when we were graded in part based on how well commented our code was. In school, comments are typically there as a “check the block” measure to ensure that the professor doesn’t take off points for not having them, but in the real world comments can actually serve a good purpose. One of the things you learn with experience is the difference between comments as a waste of space that clutters up your code files and comments that are actually meaningful. However, for the purpose of this post, I’m going to look at a specific case, which is comments that indicate an [Extract Method refactoring](http://www.refactoring.com/catalog/extractMethod.html) is needed.

Consider the following code fragment:

<!--EndFragment-->

```
// format the label based on balance
if(Customer.Balance >= 0)
{
    CustomerBalanceLabel.ForeColor = "Blue";
}
else
{
    CustomerBalanceLabel.ForeColor = "Red";
}
```

<!--StartFragment-->

This is somewhat contrived but it’s an example of the kind of minimal commenting one often sees as a sort of “I’m supposed to add comments so here’s one to meet that obligation” style. Really anyone reading this code should be able to figure out what the if block is doing in short order, but the comment is useful at least inasmuch as it lets you know this is all about formatting. One disadvantage of this style of comment is that it doesn’t indicate where the formatting code ends. Presumably there will be another comment later on, beginning a new set of logic, but often that’s not the case and it’s up to whomever is reading the code to figure out the scope of the comment.

In this case, the comment provides a big clue as to the method name of the method we’ll extract. We might choose to call it FormatCustomerBalanceLabel() and pass it in an instance of Customer if required (if it’s not already scoped to the whole class). After refactoring, the code might look like this:

<!--EndFragment-->

```
FormatCustomerBalanceLabel();
...

private void FormatCustomerBalanceLabel()
{
    if(Customer.Balance >= 0)
    {
        CustomerBalanceLabel.ForeColor = "Blue";
    }
    else
    {
        CustomerBalanceLabel.ForeColor = "Red";
    }
}
```

<!--StartFragment-->

The original version required 9 lines of code in the original method and a comment to explain what was happening. The refactored version requires only one line of code and no comment is necessary since the name of the function makes it obvious what the code is doing. Something I notice most new graduates (and students) tend to do is create very large functions, and this refactoring is one way to get away from that. Ideally, you should be able to view any function in your application on your screen in its entirety without scrolling. If you have to scroll (or, God forbid, print it out on several pages) to read the entire thing, odds are good that it’s difficult to understand and you’re going to spend more time than necessary trying to comprehend it (and you’ll be more likely to introduce bugs). And don’t even get me started on the testability of small, discrete functions versus huge monolithic functions.

<!--EndFragment-->