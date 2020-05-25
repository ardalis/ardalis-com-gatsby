---
templateKey: blog-post
title: Friendly Error Page App_Offline.htm
path: blog-post
date: 2005-10-06T13:34:56.659Z
description: In ASP.NET 2.0, while you’re in the process of updating your site,
  you can expose a friendly error page by including a file called
  app_offline.htm in your site’s root.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Error
category:
  - Uncategorized
comments: true
share: true
---
In ASP.NET 2.0, while you’re in the process of updating your site, you can expose a friendly error page by including a file called **app_offline.htm** in your site’s root. If this file exists, all requests to the site will be redirected to this page. The only way to get around this is to delete the file. The usage scenario for this is for site maintenance, and it can be easily included as part of a deployment script, where this is the first file added and the last file deleted during the deployment. You can read more about this feature [here](http://msdn2.microsoft.com/en-us/library/f735abw9).

**Excerpt**:

### To take a Web application offline before deployment

1. Create a file called App_offline.htm and place it in the root of your target Web site.
2. Put a friendly message in the App_offline.htm file to let clients know that you are updating the site.

   While the App_offline.htm file exists, any request to the Web site will redirect to the file.

   | ![Note](<>)Important |
   | -------------------- |
   |                      |

Remember to remove the App_offline.htm file after you are finished copying files.