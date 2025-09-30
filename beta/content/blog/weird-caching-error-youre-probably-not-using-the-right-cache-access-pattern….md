---
title: Weird Caching Error? You're probably not using the right cache access pattern…
date: "2004-04-02T07:54:00.0000000-05:00"
description: "Scott Cate, who runs [kbAlertz.com](http://kbalertz.com/), among"
featuredImage: img/weird-caching-error-youre-probably-not-using-the-right-cache-access-pattern…-featured.png
---

Scott Cate, who runs [kbAlertz.com](http://kbalertz.com/), among other things, writes about an intermittent error he was getting on his site last fall. Shortly before this, I had written an article on msdn about [Caching Best Practices](http://weblogs.asp.net/ssmith/archive/2003/06/20/9062.aspx), in which I described a caching pattern that should be followed to ensure proper behavior (e.g. no null reference exceptions). Scott was getting intermittent errors about 1 every 50,000 page views (which is certainly hard to duplicate by stepping through the code…). Luckily, the problem was solved by applying my caching pattern, which was the first "in the wild" report I had seen of my pattern actually fixing a known bug (which thrilled me). So anyway, read about Scott's experiences [here](http://scottcate.mykb.com/Article_5CB26.aspx).

