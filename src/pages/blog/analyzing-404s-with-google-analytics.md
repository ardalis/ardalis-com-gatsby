---
templateKey: blog-post
title: Analyzing 404s with Google Analytics
date: 2018-12-11
path: /analyzing-404s-with-google-analytics
featuredpost: false
featuredimage: /img/google-analytics-custom-404-report-results.png
tags:
  - seo
category:
  - Software Development
comments: true
share: true
---

I've been wanting to analyze broken links coming into my site so that I could add 301 redirects if necessary. I figured I could probably use Google Analytics to analyze 404s and broken links on my site. With a bit of [research](https://www.searchviu.com/en/404-errors-google-analytics/) I was able to get this working as a custom report. I initially tried importing a couple of custom reports I found in the gallery, but none of them worked so I created my own, which took about 2 minutes. Here's a quick step-by-step set of instructions that work regardless of your web site platform. Note that if you'd like to [implement your own middleware to do this using ASP.NET Core, I have a sample that shows how to do that](https://ardalis.com/using-custom-middleware-to-record-and-fix-404s-in-aspnet-core-apps).

## Confirm Your 404 Page Works Correctly

Your 404 page should return a 404 status code and should not change the URL the user was attempting to visit. You can confirm the page is working by opening up developer tools in your browser (usually F12 does this) and looking at the Network tab. Next, go to a path that doesn't exist on your site and look at the very top item in the Network tab. You should see a Status of 404. If you don't, or if the URL doesn't match the link you just typed in, you need to adjust your 404 page for this solution to work. How you do that will vary with your web site's hosting technology.

[![Browser Tools - Network Tab](/img/network-tab.png)](/img/network-tab.png)

**Note the page title** (on the browser tab) for your 404 page. This will be used later.

## Configure Google Analytics

Make sure you have Google Analytics set up and working. Obviously it's required to use Google Analytics to analyze 404s and broken links on your web site.

## Add a Custom Report

Go to your Google Analytics account for your domain and navigate to Customization - Custom Reports.

![Google Analytics - Customization - Custom Reports](/img/google-analytics-customization-custom-reports.png)

Click **New Custom Report**.

Set it up like so:

- Title: 404 Error Page Report
- Report Tab Name: Report Tab
- Type: Flat Table
- Dimensions: Page, Full Referrer, Page Title
- Metrics: Unique Pageviews
- Filters: Include Page Title - Regex - _Nothing found for_
    - Inbound links only: Include - Previous Page Path - Exact - (entrance)
- Views - 1 view selected

Change _Nothing found for_ to some substring that exists in your 404 page's title (perhaps '404' for example). The complete custom report:

[![Google Analytics Custom 404 Report](/img/google-analytics-custom-404-report.png)](/img/google-analytics-custom-404-report.png)

## Run the Report

For a given date range, you should see any 404s caused by inbound links (if you used the (entrance) filter). Here's an example of the output:

[![Google Analytics Custom 404 Report Results](/img/google-analytics-custom-404-report-results.png)](/img/google-analytics-custom-404-report-results.png)

Apparently, a lot of people are looking for the 2011 Software Craftsmanship calendar.

## Fix Broken Links

Your report may include your own links (if you don't use the (entrance) filter) which you can update yourself. For links coming from other sites, usually the best thing to do is to add 301 redirects. How you do this will vary with your web site's platform. In my case I'm hosting this site on Wordpress at SiteGround and they offer a simple way to edit my site's .htaccess file, which lets me add individual 301 permanent redirects for any link I want. For example, if I want [/asdfasdf](/asdfasdf) (shown in the report above) to magically go to this blog post, I can add the following to my .htaccess file:

RewriteRule ^asdfasdf "analyzing\\-404s\\-with\\-google\\-analytics" \[R=301,L\]

I've actually just done this, so click the link or type it in yourself in a new tab and you should find yourself right back here. If you're still using the browser developer tools, you will see in the Network tab that a 301 redirect was performed:

[![Redirect /asdfasdf here](/img/redirect-asdf-here.png)](/img/redirect-asdf-here.png)

[Learn more about modifying the .htaccess file](https://mythemeshop.com/blog/edit-htaccess-file/).

That's it - please post any tips you have to add to this in the comments below. Thanks!
