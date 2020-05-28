---
templateKey: blog-post
title: Vista Network Connection Issue Solved
path: blog-post
date: 2007-06-28T13:31:32.797Z
description: I’ve had Vista running since it came out last November. I’ve had a
  couple of [Maxtor OneTouch II] drives (network type) for the last couple of
  years, and I noticed immediately after installing Vista that I could no longer
  connect to them.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - vista
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve had Vista running since it came out last November. I’ve had a couple of [Maxtor OneTouch II](http://reviews.cnet.com/hard-drives/maxtor-onetouch-ii-300gb/4505-3186_7-31121421.html) drives (network type) for the last couple of years, and I noticed immediately after installing Vista that I could no longer connect to them. I would be prompted for a login and entering in the credentials would fail every time. The same credentials worked fine from my Windows XP machines, but searching for “vista maxtor onetouch cannot connect” etc. yielded nothing.

In a discussion recently on one of the mailing lists I’m on (with lots of people more knowledgeable than I), someone posted a solution to an issue they were having wherein their Vista machine could see some XP machines on the network but not others. I thought perhaps this was related, and renewed my search.

Eureka! I found [the following post on LockerGnome](http://help.lockergnome.com/vista/Mixed-Network-XP-Vista-MacOSX-ftopict34543.html) – which immediately solved my problem.

The issue is that the older network hard drives do not use the same authentication protocol that Vista uses by default. The solution is to modify the security settings in Vista (using secpol.msc or editing the registry) to change the policy from “NTLMv2 Only” to “LM and NTLM – use NTLMv2 if negotiated”. The precise instructions follow, and will also work to enabled file sharing between Vista and Max OS X, according to the LockerGhome post.

*In order to share files with Mac OS X with Windows File Sharing enabled,\
you will need to change the following policy in Windows Vista:\
Start>Run>secpol.msc \[enter]\
Click on “Local Policies” –> “Security Options”\
Navigate to the policy “Network Security: LAN Manager authentication\
level” and double-click it to get its Properties. By default Windows\
Vista sets the policy to “NTVLM2 responses only”. Use the drop-down\
arrow to change this to “LM and NTLM – use NTLMV2 session security if\
negotiated”.\
In Vista Home Premium, you won’t have this tool so per Steve Winograd, do:\
1. Run the registry editor and open this key:\
HKEY_LOCAL_MACHINESYSTEMCurrentControlSetControlLsa\
1. If it doesn’t already exist, create a DWORD value named\
LmCompatibilityLevel\
3. Set the value to 1\
4. Reboot*



Kudos to Malke for the solution!

*Malke\
—\
Elephant Boy Computers**[www.elephantboycomputers.com](http://www.elephantboycomputers.com/)*\
*“Don’t Panic!”\
MS-MVP Windows – Shell/User*

*\[categories: vista]*

<!--EndFragment-->