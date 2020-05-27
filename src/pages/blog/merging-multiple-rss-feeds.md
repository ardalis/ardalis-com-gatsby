---
templateKey: blog-post
title: Merging Multiple RSS Feeds
path: blog-post
date: 2005-02-17T02:55:56.627Z
description: I’ve been working on a feature for the AspAlliance.com home page
  that would show some news and articles from a variety of sources in a single
  listing. So for the last day or two I’ve been building a couple of classes and
  methods and unit tests, etc. to handle the combining of multiple RSS feeds.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - RSS Feeds
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been working on a feature for the [AspAlliance.com](http://aspalliance.com/) home page that would show some news and articles from a variety of sources in a single listing. So for the last day or two I’ve been building a couple of classes and methods and unit tests, etc. to handle the combining of multiple RSS feeds. Naturally it was only tonight as I’m almost done that I stumble upon [Kent Sharkey](http://weblogs.asp.net/ksharkey)‘s article, [E Pluriblog Unum: Merging RSS Feeds](http://msdn.microsoft.com/asp.net/archive/default.aspx?pull=/library/en-us/dnaspp/html/mergingrssfeeds.asp), just as I’m wrapping up my code and adding support for OPML files.

Here are the two main methods I’m using, which are stateless. There’s no caching implemented yet at this level, but calls to these methods are coming from output cached user controls, so I’m covered there for now. Being a cacheaholic (I wonder if googling that term in a couple of days will yield this blog entry?), I will of course add caching to these methods, probably via an optional overload wrapper method, in the near future.

First, to parse out an OPML file (like this sample one):

<!--EndFragment-->

```
public static string[] GetFeedsFromOpml(string opmlUrl)
{
System.Text.StringBuilder sb = new System.Text.StringBuilder();
XmlTextReader reader = null;
try
{
reader = new XmlTextReader(opmlUrl);
while (reader.Read())
{
if(reader.NodeType == XmlNodeType.Element)
{
switch(reader.Name.ToLower())
{
case “outline”:
if(reader.MoveToAttribute(“xmlUrl”))
{
sb.Append(reader.Value);
sb.Append(” “);
}
break;
}
}
}
return sb.ToString().Trim().Split(‘ ‘);
}
catch{}
finally
{
reader.Close();
}
return new string[] {};
}
```

<!--StartFragment-->

Next, for each URL, grab the actual RSS items using this method:

<!--EndFragment-->

```
public static ArrayList GetRssItems(string[] rssURLs, int maxDescriptionLength, int maxRecordsPerFeed) 
{
ArrayList rssItems = new ArrayList();

foreach (string url in rssURLs) 
{
if (url.Length > 0) 
{
string title = null;
string link = null;
string desc = null;

System.DateTime pubDate = new System.DateTime();
int itemCount = 0;
int maxDescLength = 250;
if(maxDescriptionLength > 0) maxDescLength = maxDescriptionLength;
XmlTextReader reader = null;
try 
{
reader = new XmlTextReader(url);
while ((reader.Read()) && (itemCount < maxRecordsPerFeed))
{
if (reader.NodeType == XmlNodeType.Element) 
{
switch (reader.Name.ToLower()) 
{
case “title”:
title = reader.ReadString();
break;
case “link”:
link = reader.ReadString();
break;
case “description”:
desc = reader.ReadString();
if (desc.Length > maxDescLength) 
{
desc = Framework.Strings.Utility.TrimWholeWord(desc, maxDescLength – 3) + “…”;
}
break;
case “pubdate”:
pubDate = Framework.DateTimes.Rfc822DateTime.FromString(reader.ReadString());
break;
}
}
//After each item end tag create HTML output
if (reader.NodeType == XmlNodeType.EndElement && reader.Name.ToLower() == “item”) 
{
RSSItem item = new RSSItem(title,link,desc,pubDate);
rssItems.Add(item);
itemCount++;
}
}
}
catch {}
finally 
{
reader.Close();
}
}
}
return rssItems;
}
And you’ll need the RSSItem struct:
public struct RSSItem 
{
private string title;
private string link;
private string description;
private System.DateTime pubDate;
public RSSItem(string title,string link,string description, System.DateTime pubDate) 
{
this.title = title;
this.link = link;
this.description = description;
this.pubDate = pubDate;
}
public string Title 
{
get 
{
return this.title;
}
set 
{
this.title = value;
}
}
public string Link 
{
get 
{
return this.link;
}

set 
{
this.link = value;
} 
}
public string Description 
{
get 
{
return this.description;
}

set 

{

this.description = value;
} 

}
public System.DateTime PublicationDate 

{

get 

{

return this.pubDate;

}

set 

{

this.pubDate = value;

} 

}

}
```

<!--StartFragment-->

The second method and the RSSItem class were modified based on [Dan Wahlin’s](http://xmlforasp.net/Dan.aspx) sample, [Combine RSS Feeds and Display Random Items](http://xmlforasp.net/codeSection.aspx?csID=112).

<!--EndFragment-->