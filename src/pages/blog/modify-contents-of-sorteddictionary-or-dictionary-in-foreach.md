---
templateKey: blog-post
title: Modify Contents of SortedDictionary or Dictionary in foreach
path: blog-post
date: 2006-10-20T01:36:50.750Z
description: So I’m working with a Dictionary (and later a SortedDictionary)
  today and I want a simple list of URLs and their HTTP status codes, so I
  create the dictionary as Dictionary<string,int> urlStatuses.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - dictionary
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

So I’m working with a Dictionary (and later a SortedDictionary) today and I want a simple list of URLs and their HTTP status codes, so I create the dictionary as Dictionary<string,int> urlStatuses. Then I write some code that looks like this:

foreach(string url in urlStatuses)\
{\
urlStatuses\[url] = GetStatus(url);\
}

Of course this doesn’t work, because you cannot modify a dictionary within a foreach. From the [docs](http://msdn2.microsoft.com/en-us/library/ms132244.aspx):\
**\
*The foreach statement of the C# language (for each in C++, For Each Visual Basic) hides the complexity of enumerators. Therefore, using foreach is recommended, instead of directly manipulating the enumerator.***

***Enumerators can be used to read the data in the collection, but they cannot be used to modify the underlying collection.***

The heart of this issue is that you can’t change the value of the int in the collection except by directly modifying the collection itself. If the value had been a class with some property, then you could easily change it by doing something like:

urlStatuses\[url].Status = GetStatus(url);

One solution to this issue would be to use an array, but I wanted to be able to build up this list without having to worry about resizing it. Another option would be a simple List<T>, where T is a custom class UrlStatus that includes properties for the url and status code. However, it seemed overly complex for me to determine if a given URL was already in the list, and I only wanted unique URLs. So in the end I sort of combined this approach with my original approach, yielding this:

<!--EndFragment-->

```
public class LinkStatus

{
public LinkStatus(string url)
{
this.Url = url;
}
private string _url;
public string Url
{
get { return _url; }
set { _url = value; }
}
private int _status = 0;
public int Status
{
get { return _status; }
set { _status = value; }
}
public override string ToString()
{
return String.Format(“{0}:{1}”, this.Status, this.Url);
}
}
```

<!--StartFragment-->

Then in my other class, I define my collection, and an AddLink method:

<!--EndFragment-->

```
protected static SortedList<string, LinkStatus> _linkTable;
public static SortedList<string, LinkStatus> LinkTable
{
get

{
if (_linkTable == null) _linkTable = new SortedList<string, LinkStatus>();
return _linkTable;
}
}
public static void AddLink(string url)
{
if (!LinkTable.ContainsKey(url))
{
LinkTable.Add(url, new LinkStatus(url));
}
}
```

<!--StartFragment-->

And finally, I loop through the links:

<!--EndFragment-->

```
foreach (string url in LinkTable.Keys)
{
if (LinkTable[url].Status == 0)
{
// Get Status Here
LinkTable[url].Status = status;
}
}
```

<!--StartFragment-->

There is probably an easier way to do this that doesn’t involve using the URL as both the key for the dictionary and an item in LinkStatus (if nothing else I could have made LinkStatus include only one property – Status — but that seemed like even more of a hack than this). Does someone have an elegant solution for how to build up a simple list of strings and integers, then loop through the strings and assign values to each string’s integer. It also needs an efficient mechanism for adding strings such that no duplicates are added.

<!--EndFragment-->