---
templateKey: blog-post
title: ReportViewer Showing No Data – Solved
path: blog-post
date: 2006-10-24T01:31:37.078Z
description: I had a really weird issue with a ReportViewer. It would show the
  little green AJAX Loading… image but it wouldn’t show any data, just a blue
  background where the output should be.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ajax
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I had a really weird issue with a ReportViewer. It would show the little green AJAX Loading… image but it wouldn’t show any data, just a blue background where the output should be. I knew the data was there because exporting to Excel or PDF showed the data just fine. So I eventually tried it in FireFox instead of IE and managed to see a few rows of data, but not much. That got me thinking that maybe it was a CSS or HTML issue — I’d set the height and width each to 100% because the default view was too small. So I set the height to 1000px and voila! It works. I wasted about 15 minutes of searching on this, so hopefully this will help save a few others some time.

<!--EndFragment-->