---
templateKey: blog-post
title: Fiddler for Firefox
path: blog-post
date: 2008-10-16T14:15:00.000Z
description: In my tools talk at DevReach earlier this week I mentioned that I
  use Fiddler with IE and FireBug with Firefox to see HTTP traffic involved in
  loading and working with a given web page/site.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Firefox
category:
  - Uncategorized
comments: true
share: true
---
In my tools talk at DevReach earlier this week I mentioned that I use Fiddler with IE and FireBug with Firefox to see HTTP traffic involved in loading and working with a given web page/site. I said in the talk that Fiddler only works with IE, but that’s not entirely true as Ivo Evtimov was kind enough to point out to me. You can configure Firefox to work with Fiddler, but you have to do so manually each time you want to do it (whereas Fiddler **just works** with IE, and Firebug **just works** with FF).

In order to configure FF to work with Fiddler, you have to set it up as a proxy server. You’ll find this under FireFox’s options, which in FF3 is under Tools -> Options -> Advanced -> Network.

![](/img/fiddler1.png)

Next go to Settings

![](/img/fiddler2.png)

And configure it to use 127.0.0.1 and port 8888 by default. You can check which port Fiddler is listening on by going to Fiddler’s Tools -> Fiddler Options menu and looking at its Listen Port. I have mine set to 8889 because I have other web sites using 8888. Just be sure they match

![](/img/fiddler3.png)

Once you have these set up, you can make requests in FireFox or IE and have all of the traffic captured within Fiddler. However, when you shut down Fiddler you’ll need to manually reset your proxy to No Proxy in FireFox. Also note that if you’re trying to test something on localhost, remove that from the No Proxy For list in FireFox’s settings.

Thanks again to Ivo Evtimov for following up on this!