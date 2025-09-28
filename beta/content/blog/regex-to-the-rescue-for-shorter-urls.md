---
title: Regex To The Rescue For Shorter URLs
date: "2003-11-05T18:24:00.0000000-05:00"
description: I've been redesigning AspAlliance.com off and on for the last
featuredImage: img/regex-to-the-rescue-for-shorter-urls-featured.png
---

I've been redesigning [AspAlliance.com](http://aspalliance.com/) off and on for the last several months, and I made a few more changes this morning. The big one that is noticeable to the general public is the URLs. Instead of having to link to articles via a viewer ASPX page and a series of querystring values, it is now sufficient to simply append the article ID to the end of the domain name (after a slash), like so:

<http://aspalliance.com/1> (article ID 1, which is my Excel Reports in ASP article).

The nice thing about this is that it uses Context.RewritePath, so there is no Response.Redirect and the user never sees the actual URL of the page handling the request. The regex I'm using is here:

<http://regexlib.com/REDetails.aspx?regexp_id=456>

The actual code looks like this:


```
string originalUrl = Request.Url.ToString();
// Check for article shortcuts (e.g. http://aspalliance.com/1 )
string newUrl = AspAlliance.Web.Core.HttpRedirect.GetRedirect(originalUrl);
if(newUrl!= originalUrl)
{
System.Uri myUri = new System.Uri(newUrl);
Context.RewritePath(myUri.PathAndQuery);
}

// GetRedirect:

System.Text.RegularExpressions.Regex regex =
new System.Text.RegularExpressions.Regex(@".com/(d+)$",
(System.Text.RegularExpressions.RegexOptions.Compiled |
System.Text.RegularExpressions.RegexOptions.IgnoreCase));
System.Text.RegularExpressions.MatchCollection matches = regex.Matches(badRequest);
if(matches.Count > 0)
{
string id = matches [0].Value.Replace(".com/",");
int aId;
try
{
aId = Int32.Parse(id);
return"http://aspalliance.com/articleviewer.aspx?aId=" + id;
}
catch
{}
}
return badRequest;
```

