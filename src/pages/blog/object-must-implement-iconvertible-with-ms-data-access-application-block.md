---
templateKey: blog-post
title: Object Must Implement IConvertible with MS Data Access Application Block
path: blog-post
date: 2003-08-18T22:59:00.000Z
description: "Ran into this bug today.  I’m not the first, as a quick google search found:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IConvertible
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Ran into this bug today. I’m not the first, as a quick google search found:

[Google group thread.](http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=01ff01c2f849%24283ca7c0%243001280a%40phx.gbl&rnum=10&prev=/groups%3Fq%3Dobject%2Bmust%2Bimplement%2BIConvertible%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26selm%3D01ff01c2f849%2524283ca7c0%25243001280a%2540phx.gbl%26rnum%3D10)

[Ted Graham also wrote about it, specifically for Access](http://weblogs.asp.net/tgraham/posts/7031.aspx).

I think I’m close to finding the actual bug in the C# version of the DAAB, but I don’t have time to totally fix it just yet. However, I did find a workaround that I hope will help some folks. I was calling a stored procedure like so:

<!--EndFragment-->

```
return SqlHelper.ExecuteDataset(ConnectionString, “usp_ListAuthors”, sqlArgs).Tables[0];
```

<!--StartFragment-->

All I did to fix it was switch to another overload:

<!--EndFragment-->

```
return SqlHelper.ExecuteDataset(ConnectionString, CommandType.StoredProcedure, “usp_ListAuthors”, sqlArgs).Tables[0];
```

<!--StartFragment-->

Simply specifying the CommandType fixed it. I’m sure the other version has a bug in it – if you have the exact fix, I’d love to hear it.

Thanks!

<!--EndFragment-->