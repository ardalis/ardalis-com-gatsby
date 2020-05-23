---
templateKey: blog-post
title: Automatically Detect Expiring HTTPS SSL Certificates
date: 2019-05-08
path: /automatically-detect-expiring-https-ssl-certificates
featuredpost: false
featuredimage: /img/automatically-detect-expiring-https-ssl-certificates.png
tags:
  - C#
  - domains
  - https
  - production tests
  - security
  - ssl
  - tls
  - xunit
category:
  - Software Development
comments: true
share: true
---

All too often we hear about a site going down or suffering problems because they've let their public x509 certificate expire. SSL certificates, which are required for HTTPS to work for secure connections using TLS to domains, expire after a number of years. Often, the team or individual who purchased and installed the initial HTTPS certificate is no longer in that role by the time the expiration occurs. If the company hasn't put in place safeguards, or [outsourced their SSL protection to a cloud service](https://ardalis.com/add-https-to-any-site-for-free), they may not realize the certificate needs to be renewed until it's already expired.

I tweeted a tip about one way dev teams can help avoid this scenario, which got some traction (more RTs for reach appreciated):

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Pro Tip: Part of your automated test suite is one that hits your prod domains and fails if their certs expire in less than 30 days.</p>— Steve "ardalis" Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1125571717819191296?ref_src=twsrc%5Etfw">May 7, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Most dev and/or devops teams have automated tests running frequently. Typically these tests only run against the source code of the projects they're stored with, but there's nothing to prevent tests from making requests to real world resource, like your company's public web site. Production tests are similar to health checks and can inform the team when things have gone wrong, or will soon if left unchecked.

It's quite easy to configure a test that will run through one or more domains and will fail if any of their certificates are either currently invalid or are going to expire soon (say, within 30 days). When that test fails, it will alert the dev team that trouble is coming soon, and they can fix the problem or escalate it to whomever can fix it within the organization.

## The Code

I wrote this up using my preferred platform of C#/xUnit/.NET Core, but if you have a similar approach using node or something else, please post your code in the comments or make a pull request to my GitHub repo.

[![xUnit code listing showing how to verify an SSL certificate has at least 30 days remaining.](/img/CertCheckTest-1024x858.png)](/img/CertCheckTest.png)

Get the code at [GitHub.com/ardalis/CertExpirationCheck](https://github.com/ardalis/CertExpirationCheck)

## Get the Code

You can [download or copy/paste the code from its GitHub repository](https://github.com/ardalis/CertExpirationCheck). Be sure to give it a star if you found it helpful.

## What Happens When It Expires?

Here is a short list of reasons why you don't want your certificate to expire:

- [What Happens When You Don't Renew Your SSL](https://www.globalsign.com/en/blog/what-happens-when-you-dont-renew-your-ssl/)
- [Expired certificate broke all Firefox add-ons](https://www.techspot.com/community/topics/expired-certificate-broke-all-firefox-add-ons.253739/) (5 May 2019)
- [80+ .gov site SSL/TLS Certificates Expired During Shutdown](https://www.thesslstore.com/blog/80-gov-ssl-tls-certificates-have-expired-during-the-shutdown/) (11 Jan 2019)
- [Ericsson Outage: Expired cert knocks millions of UK phones offline](https://www.thesslstore.com/blog/expired-certificate-ericsson-o2/) (8 December 2018)
