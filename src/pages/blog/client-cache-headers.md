---
templateKey: blog-post
title: Client Cache Headers
path: blog-post
date: 2008-08-08T03:09:00.000Z
description: Anybody who’s talked to me about web programming in the last 5
  years or so knows that I’m a big fan of caching. However, in most of my
  presentations on ASP.NET caching, I don’t get into the client side of things.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - cache
category:
  - Uncategorized
comments: true
share: true
---
Anybody who’s talked to me about web programming in the last 5 years or so knows that I’m a big fan of caching. However, in most of my presentations on ASP.NET caching, I don’t get into the client side of things. Mainly this is because ASP.NET is a server-side technology and there’s plenty of cool stuff to talk about on the server with regard to caching, and I truly think that’s where the biggest performance wins are to be had (i.e. reducing expensive calls to databases and web services).

That said, a lot of bandwidth can be saved and the perceived performance of individual pages can be greatly improved with some client side caching. What I mean by client side is within the user’s browser, or at the very least, at some proxy server nearer to the user than your web server. The way web servers and browsers determine whether or not to cache a particular request is by inspecting what headers are sent with it. The two most important headers (for caching) are **Expires** and **Cache-Control**.

Cache-Control determines whether or not the content should be cached at all. If it is set to **private**, then intermediate servers like proxy servers will not cache the content because it is (supposedly) meant for a particular user only. For instance, you wouldn’t want to send user Alice her bank account details and then have user Bob make a request to your bank web site through the same proxy server for the same page and have him get back Alice’s account details. However, some things you’re perfectly happy to let proxy servers cache, such as perhaps your 25kb logo that’s on every page of your web application. By making its Cache-Control header **public**, proxy servers may choose to keep a local copy of that file rather than re-fetching it from your web server with each request, saving on both bandwidth and latency. Further, browsers may cache the file as well. In practice, this varies with the browser and it usually helps if you also set the Expires header.

The Expires header should be set to a date, and as long as that date has not passed, proxy servers and browsers may decide to cache the contents of the request locally. Sometimes requests will be made for the content if it has been modified (using the If-Modified-Since header) in which case the server may choose to respond with a [Not Modified 304](http://www.w3.org/Protocols/HTTP/HTRESP.html). This still incurs round trips to the server, but the response only has headers, no body, so it uses minimal bandwidth. This allows browsers and proxy servers to periodically check to see if a resource has expired without having to refetch it in its entirety.

A useful tool for checking the cacheability of various URLs on your sites is [http://ircache.net/cgi-bin/cacheability.py](http://ircache.net/cgi-bin/cacheability.py "http\://ircache.net/cgi-bin/cacheability.py"). This tool will let you see the headers that your resources return and will give you a graphical indication of the cacheability of the resource (green means cacheable; red means not so much). As a best practice, I recommend making all images **immutable***and setting their Cache-Control to public and Expires to a far future date, such as “Sun, 17 Jan 2038 19:00:00 GMT”. If the image needs updated, it should have a new URL and all references to it should be updated. This will ensure images are cached as effectively as possible and ensures that updates to images take effect immediately without waiting for various proxy servers to update their caches.

\*Here I’m using immutable to mean that, once uploaded to a particular URL, the contents of the image never change. Obviously this only applies to static images, and not to dynamic charts, etc.

I’ve also recently been using [Amazon S3](http://www.amazon.com/gp/browse.html?node=16427261) more and more, and have found that [Bucket Explorer](http://www.bucketexplorer.com/) is a nice tool to use with that service. Here’s a [nice tutorial on how to set headers of resources within S3 using Bucket Explorer](http://www.drunkenfist.com/304/2007/12/26/setting-far-future-expires-headers-for-images-in-amazon-s3). Using S3 to host images is also nice because every bucket is a different subdomain (e.g. bucket.s3.amazonaws.com) and so with a couple of different buckets for images, css, javascript one can easily have 3 or 4 different domains involved in the loading of resources for a given page (with all static files coming from S3). Since browsers typically only open 2 requests to a given domain at a time, this means you’ll be able to utilize 8 simultaneous requests for content (best case) which can enable your page to load 4x faster than if it had all of its resources on a single domain (and only 2 simultaneous requests).

**More Resources**

[Using S3 as a CDN (Content Delivery Network)](http://davidcancel.com/2008/05/29/using-amazon-s3-as-a-cdn)[Part 2](http://davidcancel.com/2008/06/04/using-amazon-s3-as-cdn-part-2-cacheability)