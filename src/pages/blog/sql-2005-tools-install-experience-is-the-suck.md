---
templateKey: blog-post
title: SQL 2005 Tools Install Experience is the suck
path: blog-post
date: 2008-03-21T13:26:22.264Z
description: "Just finished building a couple of ultimate developer rig machines
  for the office for Brendan and me, and was adding software today. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - sql2005
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Just finished building a couple of [ultimate developer rig](http://www.diditwith.net/2008/01/18/TheUltimateDeveloperRigFinalBuild.aspx) machines for the office for Brendan and me, and was adding software today. So I installed Office, Visual Studio 2008, and then SQL Server 2005. I'd forgotten that **installing SQL 2005 client tools seems to require sacrificing a chicken under the right lunar conditions** in order to get it right! I've blogged about [this same issue](http://ardalis.com/blogs/ssmith/archive/2007/09/24/Installing-SQL-2005-Management-Studio.aspx) before, but apparently it gets \[sarcasm]better\[/sarcasm] with x64.

I did my due diligence and searched for the answer after the [previous steps Brendan outlined](http://ardalis.com/blogs/name/archive/2007/09/24/Installing-SQL-Server-Management-Studio-with-SQL-Server.aspx) failed with Vista 64 and SQL 2005 x64. I found [a blog entry that sounded promising](http://codingreflection.com/wordpress/?p=371), that involved running setup.exe with the SKUUPGRADE=1 parameter. This failed.

But I did find [the answer](http://blogs.neudesic.com/blogs/pete_orologas/archive/2006/10/12/416.aspx)! **The trick is to browse to the Tools folder and run SqlRun_Tools.exe directly**.

This WORKS! Here's the full path, on my CD (MSDN):

**{drive}ENGLISHSQL2005DEVELOPERSQL Server x64ToolsSetupSqlRun_Tools.exe**

Whew. Glad to get that working. But let's revisit the process of installing, and compare the Visual Studio install experience with the SQL Client Tools install experience. We'll start with Visual Studio.

**Visual Studio 2008 Install Experience**

1) Put in DVD\
2) Click the Install Visual Studio link\
3) Click Next a couple of times. Verify your license key. Pick what to install. Next.\
4) Everything it needs gets installed in N minutes without restarts or user intervention.\
5) Stick a fork in it – it's done.

**SQL Server 2005 Install~~Hell~~Experience**

1) Put in MSDN DVD\
2) Tell browser it's ok to show active content in it so the menu comes up.\
3) Scratch head about which version of Developer you want to install – pick one (SQL Server 2005 Developer Edition – 64-bit Extended (English)).\
4) Opens up Windows Explorer in the root folder with no further instructions.\[d:ENGLISHSQL2005DEVELOPER] Also there are no executables in this folder, no MSI files, and three subfolders (SQL Server Itanium, SQL Server x64, SQL Server x86). WTF? Didn't I just tell you I wanted 64-bit non-Itanium?\
5) \*Guess\* that SQL Server x64 folder is where you'll actually find the installer.\
6) Nope. Found folders for Servers and Tools. What was I trying to install again? Oh hell, let's try Servers.\
7) \*Guess\* that Setup.exe is what we want here. Run it. This part actually works. Mostly. Except it won't install my client tools. And it says IIS isn't installed. So I install it, but it still doesn't see it. I let it finish. I reboot. I try it again. It still can't see it. I say screw it I still need management studio because that failed.\
8) Go back to step 6 and pick Tools.\
9) Run Setup.exe. It fails saying the tools are already installed (SQL Express comes with Visual Studio, remember). Say Next. Modal dialog telling me I fail. Look for back button so I can tell it to just go ahead and overwrite the install. There isn't one. Click Cancel. It reminds me how dumb I am to try and do this.\
10) Go Google for while about this issue.\
11) Figure out that if you just go to the SETUP folder under TOOLS and then click SqlRun_Tools.exe, it will actually install the tools. Wonder to oneself why the SETUP.exe file in the TOOLS folder doesn't just call this to begin with and save me the trouble.\
12) Poke something sharp in eye to distract from pain of SQL Server install process

Seriously, I **love** the install experience for Vista. I **love** the install experience for Office. I **love** the install experience for Visual Studio. Please send the SQL installer team off to remedial installer training with any of these teams!

[![kick it on DotNetKicks.com](<>)](http://www.dotnetkicks.com/kick/?url=http%3a%2f%2faspadvice.com%2fblogs%2fssmith%2farchive%2f2008%2f03%2f21%2fSQL-2005-Tools-Install-Experience-is-the-suck.aspx)

<!--EndFragment-->