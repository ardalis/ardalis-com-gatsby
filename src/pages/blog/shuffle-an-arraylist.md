---
templateKey: blog-post
title: Shuffle an ArrayList
path: blog-post
date: 2005-01-27T03:19:00.568Z
description: I have a need to randomly order the contents of a collection which
  has as its underlying container an ArrayList.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ArrayList
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I have a need to randomly order the contents of a collection which has as its underlying container an ArrayList. Googling took more effort than I expected to come up with anything useful, but did yield [this link](http://www.dotnetmonster.com/Uwe/Forum.aspx/dotnet-csharp/30025/shuffling-an-arraylist). Working from there, I came up with this method, which differs in a few ways:

<!--EndFragment-->

```
public void ShuffleInPlace()
{
ArrayList source = this.InnerList;
Random rnd = new Random();
for (int inx = source.Count-1; inx > 0; inx–)
{
int position = rnd.Next(inx+1);
object temp = source[inx];
source[inx] = source[position];
source[position] = temp;
}
}
```

<!--StartFragment-->

The main improvements are these:

1. The original used ArrayList.Length which wasn’t defined, so I converted to ArrayList.Count.
2. The original was a static and took an ArrayList as a parameter (named source) — I refactored it to work as an instance method within the collection.
3. The original had a bug in it where it generated the random number. I corrected it by adding +1 to the rnd.Next() call. You can reproduce the bug by shuffling a 3-element array with the original algorithm. The item that begins in position 2 will never be in position 2 after shuffling (and I think the same is true for positions 1 and 3, but now that I’ve fixed it I don’t care enough to verify that).

<!--EndFragment-->