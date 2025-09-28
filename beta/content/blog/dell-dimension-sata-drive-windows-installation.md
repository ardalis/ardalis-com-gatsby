---
title: Dell Dimension SATA Drive Windows Installation
date: "2007-02-17T11:49:13.3990000-05:00"
description: Last week I had to rebuild a Dell Dimension 9150 with an SATA hard
featuredImage: img/dell-dimension-sata-drive-windows-installation-featured.png
---

Last week I had to rebuild a Dell Dimension 9150 with an SATA hard drive and when I tried to install Windows XP I received an error saying txtsetup.oem not found when I tried to provide the drivers on a USB floppy drive. I searched for a while and found nothing terribly helpful so I contacted Dell via phone and chat (sat on hold on both – chat answered quicker). Via chat they were able to solve my problem as follows:

1) Reboot and hit F2 on the Dell screen\
2) Go to the SATA Operation section\
3) Change to Combination SATA/PATA mode.\
4) Reboot and re-attempt windows install

Windows XP was then able to see the drive without my having to use a floppy drive and F6 to specify/provide the drivers.

\[categories: dell;SATA]

