---
templateKey: blog-post
title: Silverlight Hyperlink
path: blog-post
date: 2008-01-17T14:15:11.249Z
description: Playing with Silverlight and needed a simple way to redirect the
  page. This isn't built-in yet but probably will be.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Silverlight
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Playing with Silverlight and needed a simple way to redirect the page. This isn't built-in yet but probably will be. For now, you can call out to the page's script, and for this since I don't want to rely on the page having any particular function defined, I'm just using Eval() and passing in what I need.

So, in a button MouseLeftButtonDown() handler, I've got:

**HtmlPage.Window.Eval("document.location.href='" + url + "';");**

**\*Update\* – This is in fact built in:**

**HtmlPage.Window.Navigate(new Uri(urlString));**\
**// or**\
**HtmlPage.Window.Navigate(new Uri(urlString), targetString);**\
**// or**\
**HtmlPage.Window.Navigate(new Uri(urlString), targetString, targetFeaturesString);**

That's it. That one will let the user Back to the current page, which was what I wanted. If you use location.replace('some url'); instead it will actually eliminate the current page in the browser history and replace it with the new URL, so if you prefer that behavior, use that (might be good on a CheckOut page so the user can't checkout twice).

Now what I would like, to go along with this, is a way to get parameters passed into the silverlight appilcation from its calling page via the path used. For instance, I might refer to my silverlight application as "app.xap?url=http://aspalliance.com" and then in my silverlight application I need a way to get to that url variable in the XAP file's "querystring". I still want access to the host page's QueryString collection, too, though. So it needs to be a different bag of parameter values. Not sure what we'll see here, yet.

**Update: Found this as well.** To get at the QueryString of the XAP package, use this:

**Uri sourceUri = new Uri(App.Current.Host.Source.OriginalString);**\
**string querystring = sourceUri.Query;**

Parsing the Querystring is an exercise for the user. HttpUtility.ParseQueryString (in System.Web) is not ported over to Silverlight. So you have to roll your own. I was going to use an extension method to add it but since HttpUtility is itself a static class, you can't extend it. Thus, I created a new static class, HttpExtensions, and added a ParseQueryString() method to it. Further, NameValueCollection doesn't appear to exist in Silverlight either, but System.Collections.Generic.Dictionary<TKey,TVal> does so I used one of those:

**Dictionary<string, string> queryStringDictionary = HttpExtensions.ParseQueryString(querystring);**

For the code for ParseQueryString, I simply grabbed the ([now open source](http://weblogs.asp.net/scottgu/archive/2008/01/16/net-framework-library-source-code-now-available.aspx)) contents of System.Web.HttpUtility.ParseQueryString.

<!--EndFragment-->