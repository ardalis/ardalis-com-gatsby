---
templateKey: blog-post
title: Interesting Slide Deck on Software Design
path: blog-post
date: 2008-09-16T02:17:00.000Z
description: Just found Allen Holub’s Everything You Know Is Wrong presentation,
  via the Yahoo DDD group. It makes a great case for favoring interfaces over
  inheritance and avoiding property getter/setters in favor of delegating work
  to the object being referenced (such that you don’t need to know its
  properties – just the net result of the operation).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - software
category:
  - Uncategorized
comments: true
share: true
---
Just found Allen Holub’s [Everything You Know Is Wrong presentation](http://www.holub.com/publications/notes_and_slides/Everything.You.Know.is.Wrong.pdf), via the [Yahoo DDD group](http://groups.yahoo.com/group/domaindrivendesign/message/8298;_ylc=X3oDMTM0ZDBla3BjBF9TAzk3MzU5NzE0BGdycElkAzgxMTY5MjMEZ3Jwc3BJZAMxNzA1MDA3MTgxBG1zZ0lkAzgzMTkEc2VjA2Z0cgRzbGsDdnRwYwRzdGltZQMxMjIxNTMzNTg2BHRwY0lkAzgyOTg-). It makes a great case for favoring interfaces over inheritance and avoiding property getter/setters in favor of delegating work to the object being referenced (such that you don’t need to know its properties – just the net result of the operation). The interface discussion is similar to some of my [recent posts](/interfaces-and-testing)[on the subject](/delaying-decisions). The last slide also references his book, [Holub on Patterns](http://www.amazon.com/exec/obidos/ASIN/159059388X/aspalliancecom), which I hadn’t seen previously but will have to add to my reading list.

I have to admit that while I’ve been on board with favoring composition and interface inheritance over implementation inheritance, I hadn’t ever heard that “Getters are Evil” before reading this deck. Very interesting stuff.