---
templateKey: blog-post
title: Bitmask Helper Function
path: blog-post
date: 2004-08-31T13:20:00.000Z
description: "I had a need recently to be able to determine if a given position
  of an integer bitmask was set or not (for example, given the bitmask 0101
  which is 5 in decimal, how would you check if the 4 position is set? "
featuredpost: false
featuredimage: /img/deployment.jpg
tags:
  - Bitmask helper function
category:
  - Software Development
comments: true
share: true
---
I had a need recently to be able to determine if a given position of an integer bitmask was set or not (for example, given the bitmask 0101 which is 5 in decimal, how would you check if the 4 position is set? — this is less obvious for, say decimal 75 — is 16 set?). Here’s the method I came up with, which could be done in one line but is broken into several for clarity and ease of debugging:

**Updated (thanks to Scott Allen):**

```
privateboolIsBitSetSmartWay(intbitmask,intbitpositionvalue)\
{\
// bitmask is an integer bitmask value (e.g. 1111 = 15)\
// bitpositionvalue is a power of 2 (e.g. 1,2,4,8,16)\
return(bitmask & bitpositionvalue) > 0;\
}

privateboolIsBitSetSillyWay(intbitmask,intbitpositionvalue)\
{\
// bitmask is an integer bitmask value (e.g. 1111 = 15)\
// bitpositionvalue is a power of 2 (e.g. 1,2,4,8,16)\
intposition = (int)Math.Round(System.Math.Log((double)bitpositionvalue, 2));\
intshiftedbitmask = bitmask >> position;\
return(shiftedbitmask % 2) == 1;\
}
```

The rounding is in there because the Math.Log of 8 was giving me 2.9999997 or something like that, which (int) was truncating to 2. The basic theory is to shift the bit we want to inspect to the right until it is in the 1s position, and then test to see if the new value is odd or even by MODing it by 2 and checking for a remainder of 1. Anyway, I couldn’t find any built-in way to check a given position of a bitmask, so hopefully this will help somebody else who is looking for the same algorithm.