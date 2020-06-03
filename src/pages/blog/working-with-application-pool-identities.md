---
templateKey: blog-post
title: Working with Application Pool Identities
path: blog-post
date: 2010-07-07T14:11:00.000Z
description: There a new feature of IIS called Application Pool Identities that
  was apparently introduced with SP2 of Windows Server 2008.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Application Pool
category:
  - Software Development
comments: true
share: true
---
There a new feature of IIS called Application Pool Identities that was apparently introduced with SP2 of Windows Server 2008. There's a nice overview of [Application Pool Identities here](http://learn.iis.net/page.aspx/624/application-pool-identities), which is the basis for this post, which is just my notes on the feature.

If you're setting up new web sites and application pools in IIS on Windows Server 2008, it's likely they'll default to ApplicationPoolIdentity, like this:

![Application Pools](/img/iis-application-pools.png)

This is all well and good, and for the most part you don't need to care about how this works behind the scenes or why it's different than the other bazillion different esoteric accounts you've had to know about over the last 10 years when setting up IIS for ASP.NET (IUSR_MACHINENAME, NETWORKSERVICE, IUSR, etc.). The most recent installment in IIS user best practices, before ApplicationPoolIdentity, was NETWORKSERVICE:

> *NETWORKSERVICE is a built-in Windows identity. It doesn't require a password and has only user privileges; that is, it is relatively low-privileged. However, a problem arose over time as more and more Windows system services started to run as NETWORKSERVICE. This is because services running as NETWORKSERVICE can tamper with other services that run under the same identity. Because IIS worker processes run third-party code by default (Classic ASP, ASP.NET, PHP code), it was time to isolate IIS worker processes from other Windows system services and run IIS worker processes under unique identities.*

Got that? The NETWORKSERVICE account was low-privileged, so it was a best practice to use it. But unfortunately, since so many apps followed this practice, it became likely that NETWORKSERVICE would have too much access to a variety of applications/processes, so something new had to be used.

Enter Application Pool Identities. On IIS7.5 on Windows Server 2008 R2, your application pools will run with their own individual identity, each of which is actually a [virtual account](http://technet.microsoft.com/en-us/library/dd548356.aspx)created with the same name as your application pool. You may see these accounts in the ACLs for the files in your web site, and you'll need to know how to reference them yourself if you want to configure security settings for your site correctly (e.g. to allow users to upload files to your web application). **They are not actually users or accounts, so they will not show up as a user in the Windows User Management Console.**

For example, if you look at the Security settings for a particular filesystem object in your web application, you might see something like this:

![Security Settings](/img/app-pool-security.png)

Note, though, that if you go looking for these users on the server, you won't find them. If you choose to change permissions by clicking Edit, then Add, then change the location to your server (if it defaults to a domain), then Advanced, and finally Find Now (yes, that's a lot of buttons), you WON'T SEE THESE ACCOUNTS:

![Select Users or Groups](/img/users-and-groups.png)

So where are they and how do you add them?

You have to know the secret, which is to prefix Application Pool Identities with

`IIS AppPool\`

Thus to grant rights to the DefaultAppPool you need to use

`IIS AppPool\DefaultAppPool`.

If your application pool is named mywebsite.com, then your identity would be

`IIS AppPool\mywebsite.com`

When they appear in your ACL list, the IIS AppPool won't be listed. This is to ensure greater confusion on your part, because you don't have enough things to try and remember as a web developer and/or server administrator. If you type in the correct value and then click Check Names, it will remove the IIS AppPool prefix and underline the account name for you, like so:

![Before Check Names](/img/iis-apppool-identity.png)

![After Check Names](/img/iis-apppool-identity-after-check-names.png)

Hope this helps! For more info I suggest reading this [article on Application Pool Identities](http://learn.iis.net/page.aspx/624/application-pool-identities).

*Also, don't forget you can follow me via [twitter](http://twitter.com/ardalis), or [email](/tips)!*
