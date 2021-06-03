---
templateKey: blog-post
title: Review - Vault Source Control
date: 2003-10-27
path: blog-post
description: Sourcegear's Vault product is designed to replace Visual Source Safe for source control. It keeps the same familiar interface while removing much of the instability of VSS mainly due to Vault's reliance on Sql Server and .NET for its architecture.
featuredpost: false
featuredimage: /img/vault-source-control.png
tags:
  - source control
category:
  - Software Development
  - Productivity
comments: true
share: true
---

## Introduction - What is Vault?

[SourceGear Vault](http://www.sourcegear.com/vault/index.asp) (Version 1.2.2 as of this writing) is a version control system for Windows developers.  If you've used Visual SourceSafe, Vault is a similar (but much better) product.  It is built entirely on the .NET Framework with a SQL Server 2000 backend storage system (as compared to VSS's file system storage system).

A key feature of Vault is its backward compatibility to VSS.  Another is its inherently better reliability, due to the fact that it uses a transactional database for its storage, rather than a file system (which in VSS tends to get corrupted and lose things).  If you've used VSS, or another source control system like CVS or many others, Vault should be pretty familiar.  Vault is made by the same company that sells [SourceOffSite](http://www.sourcegear.com/soscollab/index.asp), a product that allows VSS to work well over the Internet, so these guys have a solid understanding of VSS, including its users and its shortcomings.

Another nice feature of Vault, which I haven't personally taken advantage of as yet, is that it supports access to the repository via Web Services, so you can build solutions around it, extending it as needed to fit into your development process.

#### Screenshot:

![Vault Screenshot](/img/vault-screenshot.gif)

You can find out more about Vault on [its website](http://www.sourcegear.com/vault/index.asp).

## How are we using it?

We using Vault through our web hosting provider, OrcsWeb.  They offer a hosted Vault service (see [details](http://www.orcsweb.com/hosting/sourcegearvault.aspx)).  Thus far this setup has been trouble-free and relatively fast (ok, it's not super-fast, but the speed limitation is due to my bandwidth and the Internet, not anything under my, Orcsweb, or Vault's control as far as I can tell).  One big bonus of Vault over other tools is that it doesn't take forever to initially synchronize because it only compares differences between files, not full files, so less bandwidth is required.

Since most of the actual setup and deployment of the Vault server was done by Orcsweb at AspAlliance's request, I asked them for a quote.  Here's what they said:

*"SourceGear has put together a product that is set to make a difference in the programming development community.  Built entirely using the .NET framework and MS SQL Server as the database there is little doubt that we'll be hearing more about Vault in the weeks and months to come.  My only complaint is lack of phone support but their email support has been great.  Not only is the product easy to use, powerful and stable, but the team behind the scenes have proven over and over to exceed my expectations.  Not only was release 1.0 an exciting product but the changes and new features since then have proven that SourceGear really does have both the vision and ability to make this a product for casual and advanced user alike."*

-**Scott Forsyth**, [ORCSWeb Hosting](http://www.orcsweb.com/)

Currently, ASPAlliance.com is using Vault to store all of the source code for the site, including the [advertising server](http://ads.aspalliance.com/) which runs about 35Million ads per month.  Other open community projects, like [RegExLib](http://regexlib.com/) and [AspAdvice](http://aspadvice.com/), also have their code hosted on our Vault server at OrcsWeb.

Currently we have about 5 developers working with the source, and the most frequent access is by me personally, but it has proven to be a useful collaborative tool.  It's not a panacea for team development, which is still painful with VS.NET for web applications (project files and single DLLs per web app being the main sources of pain), but it is a great way to manage code and ensure that things don't accidentally get deleted, or to roll back major problems that are created unknowingly.

## Conclusion

So now let's talk about some of the things I **don't** like about Vault, lest this seem more like an infomercial and less like a real review.  Fortunately, there aren't too many of these, and most of them resolve around one thing... licensing.

Vault's licensing model is not the most flexible thing in the world.  You'll find their latest pricing sheet [here](http://www.sourcegear.com/vault/vaultpricing.asp).  The starter pack is only $599 for 5 licenses, which is quite reasonable and is what I have.  However, after that it starts getting steep.  For one more developer, you need to pay $399.  In fact, for another 5 licenses (basically, double what you got for $599), you need to pay almost $2000 ($1995 in fact).  This seems to work in reverse to most licensing models, which have relatively steep individual prices but discounts for volume.  I assume that large enterprises can contact SourceGear to get discounts for their hundreds of developers, but small shops with a dozen or so developers are going to have to swallow these costs.

To be fair, the prices aren't that far from what individual licenses for VSS cost, but most developers use the VSS that came with VS.NET (which may have come with their copy of MSDN Universal), so they're not used to seeing that as a separate price to pay.  What's more, with my VSS license, I can connect to anybody's VSS repository, because I have a licensed VSS client.  The other issue I have with Vault is that there are no client licenses.  Every server must have paid licenses for every user account.  So if I have a server for AspAlliance and another server for a client I'm consulting for, I need to pay $399 for a user account on each server (well, somebody has to pay it).  I don't like the fact that I have to pay multiple times for the use of the tool as a client, and I hope they will support client licensing in the future.

Other than that, I don't have a lot bad to say about Vault.  It hasn't eaten any of my files.  It works great with VS.NET.  It does what it's supposed to do.  It's slower than not using any source control, but faster than VSS.  It's being worked on feverishly by the guys at SoureGear, who will answer your emails within 24 hours typically when you post to their [Vault Mailing List](http://lists.sourcegear.com/cgi-bin/mailman/listinfo/vault-list) (a great place to lurk to learn more about what's going on with the product).  They've gone from a 1.0 product to 1.2.2 in the last 9 months or so, with lots of stability and performance improvements along the way.  The upgrades haven't lost any files or data (from my experience), and the latest updates didn't even require upgrading the client.

All in all, I've been very satisfied with Vault, and unless Microsoft releases a very compelling source control solution in the very near future (which seems quite unlikely), I think I'm going to be using Vault for a while.

Originally published on [ASPAlliance.com](http://aspalliance.com/230_Review_Vault_Source_Control).
