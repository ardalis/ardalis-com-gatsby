---
templateKey: blog-post
title: Moving a Certificate Between Web Servers
path: blog-post
date: 2010-06-18T14:54:00.000Z
description: I'm in the process of moving [Lake Quincy Media's web
  site](http://lakequincy.com/) from one server to another, and since it uses
  SSL to secure users' data, I had to move the certificate to the new server as
  part of the server move.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - web server
  - iis
  - https
category:
  - Software Development
comments: true
share: true
---
I'm in the process of moving [Lake Quincy Media's web site](https://lakequincy.com/) from one server to another, and since it uses SSL to secure users' data, I had to move the certificate to the new server as part of the server move. Fortunately, this process is quite painless. First, you need to export the certificate to a .pfx file and give it a password, using these steps:

1. Start, Run, MMC (I did it as administrator)

2. Go to File –> Add/Remove Snap-in

3. Click on Certificates and Add

4. You want Local Computer. Click Finish

5. Click OK to close the Add/Remove Snap-in wizard

6. Expand the Certificates (Local Computer) tree.

7. Open the Personal – Certificates section.

8. You should see your certificate(s) listed. Right click the one you want to backup and choose All Tasks –> Export.

9. Follow the wizard to backup the cert to a .pfx file.

10. Choose to ‘Yes, export the private key'

11. Choose to ‘Include all certificates in the certificate path if possible” Do NOT delete the Private Key.

12. Enter a password (and remember it)

13. Save the file. You should see “The export was successful.”

## Importing a .pfx file to restore a certificate

You can go through much the same steps as above, running MMC and adding the snap-in, and then going to the Personal –> Certificates section in the tree view and selecting All Tasks –> Import. Or you simply run the following command from a cmd prompt (again I did so as administrator):

```powershell
certutil -importpfx quincy.pfx
```

After entering your password, you should see the certificate details followed by:

CertUtil: –importPFX command completed successfully.

If you then go into MMC you should see the cert.

Finally, to associate the cert with your IIS7 web site, simply go to the Bindings… menu and add a new binding for https. You will be prompted to select an SSL certificate to use, and you should see your recently restored cert as an option, like so:

![iis site binding](/img/iis-site-binding.png)

That's all there is to it. You should now be able to navigate to your site using https.
