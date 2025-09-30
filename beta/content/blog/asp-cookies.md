---
title: Cookies With ASP
date: "2000-09-25T00:00:00.0000000"
description: Cookies can be a good method for passing data between pages and especially for retaining data between sessions. Today, it's pretty safe to assume that anyone who is using your site can use cookies, since nearly every site that is non-static makes use of them (including all ASP sites that use sessions). This article covers how to set and read cookies.
featuredImage: /img/cookies-asp.png
---

## Mmmmm, cookies...

Cookies can be a good method for passing data between pages and especially for retaining data between sessions. Today, it's pretty safe to assume that anyone who is using your site can use cookies, since nearly every site that is non-static makes use of them(including all ASP sites that use sessions). It is also possible to set and read cookies using client-side code, but it is a bit more difficult. Reading and writing cookies using Active Server Pages' built in Request and Response objects is incredibly easy.

The cookies collection is a part of the Request and Response objects. They support the standard key-value pairs of all ASP collections, as well as a few additional methods and properties. Note that when setting cookies, you must do so prior to any HTML being sent to the client, because it uses the response object (just like a Response.Redirect, which I'm sure you knew about, didn't you?). That means put this at the top of your ASP page, before any HTML or Response.Writes.

```aspnet
Response.Cookies Properties and Methods:
Response.Cookies("myCookie").Expires ="January 1, 1999"
Response.Cookies("myCookie")("myValue1") = 1
Response.Cookies("myCookie")("myValue2") = 2
Response.Cookies("myCookie")("myValueN") = N

Request.Cookies Properties and Methods:
Response.Write Request.Cookies("myCookie")("myValue1")
'(you can check if it has been set with IsNull:)
If IsNull(Request.Cookies("myCookie")) Then '...
```

You can create cookies that will expire when the user closes down their browser, if you only need to retain data for a short period of time. Sometimes this is the only feasible way to tie together user state, such as when you cannot use forms or querystrings and you don't want the overhead of a Session variable. An easy way to set the Expires field to a relative time in the future(e.g. 1 week from now) is to use VB's DateAdd() function. It takes three parameters: a string for the unit of time ("d" is days), the number of units(integer), and the starting time(use"Now()"). The cookie set on this page lasts for 1 day using this code:

```aspnet
Response.Cookies("Stevenator").Expires = dateadd("d",1,now)
```

One last note. Since the cookies collection does not have to have a series of key/value pairs, it is possible to give the cookie a single value. Be careful with this, because you can overwrite all of the data in your cookie very easily if you do not use the key/value pairs. For example, Response.Cookies("myCookie") = 1 would overwrite all of the data that was set in the example listed up above(1,2,N,etc). A good way to check whether or not the cookie is scalar or a collection is to use the Count method to return how many items it holds.

Originally published on [ASPAlliance.com](http://aspalliance.com/379_Cookies_With_ASP).

