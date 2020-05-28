---
templateKey: blog-post
title: Triskaidecaphobia
path: blog-post
date: 2008-04-17T01:51:10.561Z
description: "Office 13 is going to actually be called Office 14, since there
  are some people who assign some negative significance to the number 13 (see
  Triskaidekaphobia). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Microsoft Office
  - Software Development
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Office 13 is going to actually be called Office 14, since there are some people who assign some negative significance to the number 13 (see [Triskaidekaphobia](http://en.wikipedia.org/wiki/Triskaidekaphobia)). Since this is clearly a significant concern in the world of computing, it seems natural to me that other areas of Microsoft’s platform should work harder to avoid this unlucky number.

On a slightly related note, I was glad to see that the Westin Seattle actually is honest about the numbering of its floors, and does \*not\* label the 13th floor 14 in an effort to appease people’s superstitions. [Scott Cate](http://scottcate.com/) and I stayed on the 13th floor this week, and even had the super-duper unluck of having 13 on our door twice (in a palindrome!) in room 1331. However, we were somehow able to escape the imminent doom this would normally portend.

Back to the subject at hand, though, let’s find some other areas in which we can eliminate fear of the .NET framework. To start with, arrays and enumerable collections should automatically skip the 13th index and label it 14 instead. Thus something like this:

**string\[] myStrings = new string\[20];**

**foreach(int i=0;i<myStrings.Length;i++)**\
**{**\
**Console.Write(i + ” “);**\
**}**

**would output**

**0 1 2 3 4 5 6 7 8 9 10 11 12 14 15 16 17 18 19**

To get this to work, you would need to update the CLR or the IEnumerable functions in the base collection classes, but it would be worth it to avoid the evil 13. To implement this yourself, you would need to add in special logic:

**if(i<=12||i>=14)**\
**Console.Write(i + ” “);**

This would still pass the FxCop rule “thou shalt not have the number 13 anywhere in your code” that will need to be added, but really users shouldn’t need to write this themselves. However, static analysis and style warnings really aren’t sufficient to address the importance of something like this. We really need to entire system to grind to a halt at the very mention of the unmentionable 0xD. Thus, we’ll need a new exception, the Triskaidexception. Its use might look like this:

**if(value > 12 && value < 14)**\
**{**\
**throw new Triskaidexception(“Evil number detected!);**\
**}**

But seriously, since the actual product isn’t going to carry the lucky number 13, I think it’s pretty silly to eschew this incremental number in order to avoid superstition. All that does is breed ignorance and superstition further, and in the 21st century, from a company full of a lot of very well-educated and intelligent people, I would hope to see less fear of the potential marketing detriment of others’ superstitions.

<!--EndFragment-->