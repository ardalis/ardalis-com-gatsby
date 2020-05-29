---
templateKey: blog-post
title: Cache Access Pattern Revised
path: blog-post
date: 2008-07-07T02:40:53.631Z
description: Karl Seguin has an interesting post about using System.Func to
  fight repetitive code blocks, which actually addresses a pain point I’ve had
  for quite some time but had never acted on to fix.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Cache Access
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Karl Seguin](http://codebetter.com/blogs/karlseguin) has an interesting post about [using System.Func to fight repetitive code blocks](http://codebetter.com/blogs/karlseguin/archive/2008/07/03/get-your-func-on.aspx), which actually addresses a pain point I’ve had for quite some time but had never acted on to fix. Whenever one access the Cache or a similar statebag that might or might not contain the value sought after, it is important to check if the value exists first, and if it doesn’t, go and retrieve it from wherever its authoritative repository is (typically the database). This can be done poorly, so I show [the correct way to do](http://aspadvice.com/blogs/ssmith/archive/2004/04/02/1803.aspx) it frequently in my talks about caching or performance. The unfortunate thing about this pattern, however, is that you’re always stuck writing the same code, which gets old after a while (and is prone to error).

Karl shows how one can refactor the object fetching method to accept a callback which is responsible for fetching the object if it is not in the cache/statebag, using Func<T>. The resulting code looks like this:

<!--EndFragment-->

```
<span style="color: rgb(0, 0, 255);">public</span> T Get&lt;T&gt; (<span style="color: rgb(0, 0, 255);">string</span> key, Func&lt;T&gt; ifNullRetrievalMethod)

{

   T item = (T) HttpRuntime.Cache.Get(key);

  <span style="color: rgb(0, 0, 255);">if</span> (item == <span style="color: rgb(0, 0, 255);">null</span>)

   {

       item = ifNullRetrievalMethod();

       Insert(key, item);

   }

   <span style="color: rgb(0, 0, 255);">return</span> item;

}
```

<!--StartFragment-->

Assuming that we want a method that retrieves a user from its ID, and that fetching it from the data store requires a call to _dataStore.GetUserFromId(userId), we can write our data access method like so:

<!--EndFragment-->

```
<span style="color: rgb(0, 0, 255);">public</span> User GetUserFromId(<span style="color: rgb(0, 0, 255);">int</span> userId)
{

   <span style="color: rgb(0, 0, 255);">return</span> CacheFactory.GetInstance.Get(

    <span style="color: rgb(0, 0, 255);">string</span>.Format(<span style="color: rgb(0, 96, 128);">&quot;User.by_id.{0}&quot;</span>, userId), 

    () =&gt; _dataStore.GetUserFromId(userId));

}
```

<!--StartFragment-->

In this example, () => is a parameterless delegate. Essentially we’re wrapping up the little bit of code required to fetch the user (or whatever object) and passing it into the method that is responsible for checking the cache. If the object is not in the cache, the function is executed (otherwise it is ignored).

Looking around a bit more, [Alan Northam](http://devlicio.us/blogs/alan_northam) has a somewhat similar, but more involved [caching pattern here](http://devlicio.us/blogs/alan_northam/archive/2008/03/06/cold-hard-cache.aspx), which does a little more error checking and uses a standard delegate for the retrieveMethod. Be sure to have a look at that as well – it would be easy to modify it to use Func<T>.


<!--EndFragment-->