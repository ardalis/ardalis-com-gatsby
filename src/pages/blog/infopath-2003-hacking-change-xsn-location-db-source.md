---
templateKey: blog-post
title: InfoPath 2003 Hacking Change XSN Location; DB Source
path: blog-post
date: 2004-02-26T22:01:00.000Z
description: I built a handy InfoPath form to do some data entry for the
  [AspAlliance Ad Network](http://ads.aspalliance.com/) back when it was still
  in beta over the summer of 2003.
featuredpost: false
featuredimage: /img/database.jpg
tags:
  - InfoPath 2003
  - XSN file
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I built a handy InfoPath form to do some data entry for the [AspAlliance Ad Network](http://ads.aspalliance.com/) back when it was still in beta over the summer of 2003. In December, I moved my database server to a dedicated box (with new connection string settings), and around that same time I rebuilt my file server and renamed it as well. Thus, the next time I went to use my handy InfoPath form, it informed me that the XSN file was no longer where I left it. After some searching, I found this helpful article:

[Update the data source for your form](http://office.microsoft.com/assistance/preview.aspx?AssetID=HA010834751033&CTT=1&Origin=EC010231761033&QueryID=Qgw4FCkHi)

and this one, which was less helpful:

<http://www.infopathfaq.com/general.asp>

The first one would have helped if I hadn’t moved my XSN file. It starts off with “In design mode, …” but of course that’s no good when every time you click on the blasted file it never loads in InfoPath, instead it simply says “InfoPath cannot create a new blank form. You cannot fill out forms based on this form template because the file has been moved or copied from its published location.” Searching for help on this message led me to the InfoPathFAQ site, which had some useful tips on what I **could have** done, but nothing to help me now that I had already in fact moved the stupid file. (it’s 3 workarounds were 1: just reconnect to where the file is (uh, can’t do that), 2: Don’t specify a location when you publish a form (but then you always have to send the XSN file with any forms. This would have worked, but I had already specified a name. 3. Do some kind of registry stuff that wasn’t well-explained and again would have to have been done **before** I was in the situation I was in).

Knowing that XSN files are just CAB files and having found a few blog posts mentioning modifications to the contents of these things, I extracted the XSN file using WinRAR (WinZIP works too), opened up the manifest.xsf file in Notepad, and quickly found the two things I was looking for:

1. The publishUrl, an attribute of the <xsf:xDocumentClass /> element, near the top of the file.
2. My connection string, in a connectionString attribute of the <xsf:adoAdapter /> element, toward the bottom of the file.

I made my changes, and that should have been the end, but unfortunately it not that easy to get the changed file back into the XSN package. I tried using WinRAR- no dice. I tried WinZIP 8 — nope. I did some searching for CAB file building and packaging cabinet files and didn’t find what I wanted for a while. Eventually, though, I found the [Microsoft Cabinet Software Development Kit](http://support.microsoft.com/default.aspx?scid=KB;en-us;310618), which includes Cabarc.exe.After dropping Cabarc.exe into my C:WindowsSystem32 folder, I quickly used it to rebuild my XSN file. The syntax is simple if you use it in a folder with nothing in it but the files that need to go into the CAB file:

Cabarc N myInfoPath.xsn \*.\*

And that did the trick once I copied the new XSN file over the old XSN file. All the stupid ‘the file has moved’ errors went away and I was talking to my new database. Yay!

<!--EndFragment-->