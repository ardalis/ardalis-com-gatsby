---
templateKey: blog-post
title: The 4 Stages of Learning Design Patterns
path: blog-post
date: 2011-05-13T19:48:00.000Z
description: Design patterns are general, reusable solutions that occur in
  software design, which can usually be adapted to fit into a number of
  different situations and applications.
featuredpost: false
featuredimage: /img/background-2462434_1280.jpg
tags:
  - design patterns
  - learning
category:
  - Software Development
comments: true
share: true
---
[](http://www.flickr.com/photos/duaneschoon/4530185934)[Design patterns](http://en.wikipedia.org/wiki/Design_pattern_%28computer_science%29) are general, reusable solutions that occur in software design, which can usually be adapted to fit into a number of different situations and applications. Recently, I recorded [a screencast interview with Carl Franklin on Commonly Used Design Patterns for dnrTV](http://www.dnrtv.com/default.aspx?showNum=194), and one of the things we discussed was the stages of learning design patterns. I noted that, at least for myself, I’d found that I tended to go through four distinct phases during my learning process when it came to these patterns. I’ve found it valuable to enumerate these stages, because if we can recognize where we are in our learning process, it can help us to evaluate whether our decision to use a pattern is based on its true applicability to the situation, or merely is a consequence of our own knowledge (or lack thereof) of the pattern.

I’ve numbered the stages starting with zero, not just to be programmer-geeky, but also because the initial stage really does represent zero knowledge.

**Stage Zero – Ignorance**

> *You used what? Never heard of it.*

The first stage is basically the complete lack of knowledge. You’re unaware of design patterns, or at least the particular pattern in question. If someone else mentions it in conversation, you’re simply lost, unless you ask for some clarification as to what they mean by the term. Naturally at some point, every programmer must start at stage zero when it comes to design patterns, as with every other concept they’ve had to learn at some point along the way. It’s worth recognizing that you’re at this stage and making an effort to at least move up to Stage One with regard to design patterns in general, so you’re better prepared to discuss software with your peers and able to determine whether any particular patterns have value in your specific work.



**Stage One – Awakening**

> *Wow, I just learned about how using the XYZ pattern can greatly improve the design of my applications. I’m not really sure where to add it to my code, but now I’m going to be looking for places to use it.*

The easiest transition in the learning curve is of course the move from Ignorance to basic Awakening. At Stage One, you’ve heard of the pattern, and maybe you’ve used it in a non-production manner, but you’re still not sure when and where to really use it in a real application. However, you’re now able to converse with others about the pattern by name in a somewhat intelligent fashion, and you’re better prepared to learn more about the pattern and recognize its use when you see it used by others (e.g. in articles, presentations, or open source projects). For some, perhaps even many, patterns, it’s reasonable for you to remain at Stage One until you’re confronted with a design challenge that a particular pattern is well-suited to addressing. Hopefully when that happens, you’ll consider the possibility that a design pattern may apply to the problem, and then you’ll explore the patterns to see learn which one might best apply. Applying the pattern to your problem will almost certainly raise your level of understanding of it. Alternately, you can learn as much as you can about as many patterns as you can before you’ve encountered a real need for them. This approach works well, too, but often quickly leads to the Stage Two level of knowledge.



**Stage Two – Overzealous**

> *I totally get the XYZ pattern and am just loving it. I’m adding it everywhere I can shoehorn it into my code. My design’s gonna be awesome, now, for sure!*

We all do this – it’s not really related to programming or design patterns. Once we learn something and we get comfortable with a new technique, we want to use it everywhere we can. Carl mentions that this is commonplace in music. I’ve certainly found myself in this stage with design patterns, as well as in my martial arts studies and elsewhere. Avoid getting stuck in a rut with any one pattern, or falling into the [Golden Hammer](/principles-patterns-and-practices-of-mediocre-programming) trap. Recognize that you may be in this stage when you’re designing and refactoring your code. Are you applying a pattern because it’s truly needed and improves the design, or just because you can and this particular pattern is comfortable for you?



**Stage Three – Mastery**

> *Over time, the application’s design began to exhibit certain negative characteristics such as repetition. It was clear that applying the XYZ pattern would alleviate the issue, so I applied it via some refactoring steps and tested the application to ensure its behavior remained unchanged.*

You’ll know when you’ve really mastered a particular pattern when you can see the patterns evolving out of your code, rather than being forced upon it. Or when you are confident enough in your design and refactoring skills to not apply the pattern up front, knowing that you can do so if and when it’s warranted (remembering YAGNI). It’s not necessary that you master every design pattern – I don’t think many developers do. However, you should try to master those patterns that you find yourself using frequently, whether through conscious choice or merely by coincidence. Read up on how the pattern is used from a variety of different books or videos. Go through a kata or two with the intent of applying the pattern to the problem. Discuss the pattern with your peers at a user group, conference, or online. Write your own articles or blog posts about how you’ve found the pattern to be applicable in your work. All of these are tools you can use to master the design patterns that you use the most, ensuring that you get the most out of their use, and avoid overusing them.



**Resources**

* [Common Design Patterns screencast on dnrTV](http://www.dnrtv.com/default.aspx?showNum=194) (covers 6 common patterns)
* Book: [Design Patterns](http://amzn.to/95q9ux) – The Gang of Four reference.
* Book: [Head First Design Patterns](http://amzn.to/aA4RS6) – The best book I’ve read on learning design patterns. Very practical and enjoyable. [My review](/head-first-design-patterns).
* Book: [Design Patterns in C#](http://amzn.to/bqJgdU)
* Online Training: [PluralSight Pattern Library](http://www.pluralsight-training.net/microsoft/olt/Course/Toc.aspx?n=patterns-library) – Over 20 different patterns covered in over 9 hours of training
* Wikipedia: [http://en.wikipedia.org/wiki/Design\_pattern\_%28computer_science%29](http://en.wikipedia.org/wiki/Design_pattern_%28computer_science%29 "http\://en.wikipedia.org/wiki/Design_pattern\_%28computer_science%29") – includes a nice list of patterns
* [Design Patterns PDF Quick Reference](http://www.mcdonaldland.info/2007/11/28/40)
* [Alternatives to the Singleton Design Pattern](http://aspalliance.com/2028_Alternatives_to_the_Singleton_Design_Pattern)