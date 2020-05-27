---
templateKey: blog-post
title: Debuggin Failed Because Authentication is not enabled
path: blog-post
date: 2006-10-04T01:46:40.725Z
description: I ran into this prompt while trying to launch debugging in VS 2005
  using IIS. I quickly found [this MSDN online article] to solve the problem.
  Posting here to help anybody else find it quickly.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I ran into this prompt while trying to launch debugging in VS 2005 using IIS. I quickly found [this MSDN online article](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vsdebug/html/vxtbserrordebuggingfailedbecauseintegratedwindowsauthenticationisnotenabled.asp) to solve the problem. Posting here to help anybody else find it quickly. Basically, go into IIS and turn on Windows Authentication under Directory Security. Here’s detailed steps:

**To enable integrated Windows authentication**

1. Log onto the Web server using an administrator account.
2. From the **Start** menu, open the Administrative Tools Control Panel.
3. In the Administrative Tools window, double-click **Internet Information Services**.
4. In the Internet Information Services window, use the tree control to open the node named for the Web server.

   A **Web Sites** folder appears beneath the server name.
5. You can configure authentication for all Web sites or for individual Web sites. To configure authentication for all Web sites, right-click the **Web Sites** folder and choose **Properties** from the shortcut menu. To configure authentication for an individual Web site, open the **Web Sites** folder, right-click the individual Web site, and choose **Properties** from the shortcut menu
6. In the **Properties** dialog box, select the **Directory Security** tab.
7. In the **Anonymous access and authentication section**, click the **Edit** button.
8. In the **Authentication Methods** dialog box, under **Authenticated access**, select **Integrated Windows authentication**.
9. Click **OK** to close the **Authentication Methods** dialog box.
10. Click **OK** to close the **Properties** dialog box.
11. Close the Internet Information Services window.

<!--EndFragment-->