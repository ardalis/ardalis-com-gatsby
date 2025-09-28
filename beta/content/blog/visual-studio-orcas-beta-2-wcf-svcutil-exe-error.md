---
title: Visual Studio Orcas Beta 2 WCF svcutil.exe Error
date: "2007-07-28T08:01:34.7710000-04:00"
description: >
featuredImage: img/visual-studio-orcas-beta-2-wcf-svcutil-exe-error-featured.png
---

If you run into trouble using svcutil.exe with the Beta 2 release of Visual Studio /.NET FX, try this:

sn-exe -Vr svcutil.exe

It wasn't signed in this drop (it will surely be at RTM). Alternately I've been told you can copy the svcutil.exe file from the previous beta.

