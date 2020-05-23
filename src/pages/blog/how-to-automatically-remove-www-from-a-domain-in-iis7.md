---
templateKey: blog-post
title: "How To: Automatically Remove www from a Domain in IIS7"
path: blog-post
date: 2014-06-12T15:52:00.000Z
description: "I recently moved the DevMavens.com site from one server to another
  and needed to ensure that the www.devmavens.com domain correctly redirected to
  simply devmavens.com. "
featuredpost: false
featuredimage: /img/iis-manager.png
tags:
  - iis
  - seo
category:
  - Software Development
comments: true
share: true
---
I recently moved the [DevMavens.com](http://devmavens.com/) site from one server to another and needed to ensure that the **www.devmavens.com** domain correctly redirected to simply **devmavens.com**. This is important for SEO reasons (you don’t want multiple domains to refer to the same content) and it’s generally better to use the shorter URL (www is ***so*** 20th century) rather than wasting 4 characters for zero gain.

My friend and IIS guru Scott Forsyth pointed me to [his blog post on how to set up IIS URL Rewriting](http://weblogs.asp.net/owscott/archive/2009/11/27/iis-url-rewrite-rewriting-non-www-to-www.aspx). To get started, you simply [install IIS Rewrite from this link](http://www.iis.net/expand/URLRewrite) using the super awesome Web Platform Installer. You should get something like this when you’re done with the install:

![](/img/web_platform.png)

If you already have IIS Manager open, you may need to close it and re-open it before you see the URL Rewrite module. Once you do, you should see it listed for any given Site under the IIS section:

![](/img/iis-manager.png)

Double click on the URL Rewrite icon, and then choose the Add Rule(s) action. You can simply create a blank rule, and name it “Redirect from www to domain.com.” Essentially we’re following the instructions from Scott Forsyth’s post, but in reverse since he’s showing how to add 4 useless characters to the URL and I’m interested in removing them.

After adding the name, we’ll set the Match Url section’s Using dropdown to Wildcards and specify a pattern of simply * to match anything.

In the Conditions section we need to add a new condition with an Input of {HTTP_HOST} such that it should match the pattern www.devmavens.com (replace this with your domain).

Ignore the Server Variables section.

Set the action to Redirect and the Redirect URL to **http://devmavens.com/{R:0}** (replace with your domain). The {R:0} will be replaced with whatever the user had entered. So if they were going to **http://www.devmavens.com/default.aspx** they’ll now be going to **<http://devmavens.com/default.aspx>**.

The complete Inbound Rule should look like this:

![](/img/inbound-rule.png)

That’s it! Test it out and make sure you haven’t accidentally used my exact URLs and started sending all of your users to devmavens.com! Be sure to read[Scott’s post](http://weblogs.asp.net/owscott/archive/2009/11/27/iis-url-rewrite-rewriting-non-www-to-www.aspx)for more information on how to use[regular expressions](http://regexlib.com/)for your rules, and how to set them up via web.config rather than IIS manager.