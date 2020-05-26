---
templateKey: blog-post
title: Copy Pictures To Folders By Date Taken with Powershell
path: blog-post
date: 2009-01-18T09:25:00.000Z
description: For about the millionth time, I was downloading the photos from my
  digital camera and organizing them into folders by date… by hand. I’ve tried a
  few different tools to do this in the past and have always ended up going back
  to a manual process for one reason or another.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - PowerShell
category:
  - Uncategorized
comments: true
share: true
---
For about the millionth time, I was downloading the photos from my digital camera and organizing them into folders by date… by hand. I’ve tried a few different tools to do this in the past and have always ended up going back to a manual process for one reason or another. So this time I grew fed up (again) with the inanity of the process and decided I’d use PowerShell to accomplish the task, as it seems made for the job.

Of course I searched first for others who had done this – it’s hardly a problem unique to me. I pretty quickly found [someone who not only had gotten it to work but had some pretty nice links to help for those new to PowerShell](https://blogs.msdn.com/hans_vb/archive/2009/01/10/organizing-my-pictures.aspx). Hans of course also linked to the original author,[Kim, and his post on organizing photos into folders by EXIF date taken](http://blogcastrepository.com/blogs/kim_oppalfenss_systems_management_ideas/archive/2007/12/02/organize-your-digital-photos-into-folders-using-powershell-and-exif-data.aspx). A couple of other useful links:

* [Download and Install PowerShell](http://www.microsoft.com/windowsserver2003/technologies/management/powershell/download.mspx)
* [Learn How To Run Scripts](http://www.microsoft.com/technet/scriptcenter/topics/winpsh/manual/run.mspx)(no it doesn’t just work out of the box, but almost)
* * If you grab my file and just type OrgPhotos.ps1 into your PS prompt and it doesn’t work, this link will probably tell you why.

Here’s a link to my working script:

* [OrgPhotos.ps1](http://stevesmithblog.s3.amazonaws.com/OrgPhotos.ps1)

The only hitch I ran into was that it’s been so long since I’ve done anything with PowerShell, I forgot what the extension for it was. I thought maybe it was psl not ps1 (and the font used on the original post didn’t distinguish between the two). Pea-ess-ell sounds more like PowerShell than pea-ess-one but at any rate if you try to run a .psl file from PowerShell, you’ll simply get an error like:

**Program ‘foo.psl’ failed to execute: No application is associated with the specified file for this operation.**

Easy fix – rename it to foo.ps1.

Here’s my final version of the script. I also made the paths use YYYY-MM-DD as these sort properly chronologically when windows sorts the folders by filename.

```
<span style="color: #606060">   1:</span> <span style="color: #008000"># ==============================================================================================</span>
<span style="color: #606060">   2:</span> <span style="color: #008000"># </span>
<span style="color: #606060">   3:</span> <span style="color: #008000"># Microsoft PowerShell Source File -- Created with SAPIEN Technologies PrimalScript 4.1</span>
<span style="color: #606060">   4:</span> <span style="color: #008000"># </span>
<span style="color: #606060">   5:</span> <span style="color: #008000"># NAME: OrgPhotos.ps1</span>
<span style="color: #606060">   6:</span> <span style="color: #008000"># </span>
<span style="color: #606060">   7:</span> <span style="color: #008000"># UPDATED: Steve Smith</span>
<span style="color: #606060">   8:</span> <span style="color: #008000"># DATE: 18 January 2009</span>
<span style="color: #606060">   9:</span> <span style="color: #008000"># COMMENT: Changed file paths and confirmed it works.  Note that file extension must be .psONE not .psELL</span>
<span style="color: #606060">  10:</span> <span style="color: #008000">#</span
 
>
<span style="color: #606060">  11:</span> <span style="color: #008000"># AUTHOR:  Kim Oppalfens, </span>
<span style="color: #606060">  12:</span> <span style="color: #008000"># DATE  : 12/2/2007</span>
<span style="color: #606060">  13:</span> <span style="color: #008000"># </span>
<span style="color: #606060">  14:</span> <span style="color: #008000"># COMMENT: Helps you organise your digital photos into subdirectory, based on the Exif data </span>
<span style="color: #606060">  15:</span> <span style="color: #008000"># found inside the picture. Based on the date picture taken property the pictures will be organized into</span>
<span style="color: #606060">  16:</span> <span style="color: #008000"># c:RecentlyUploadedPhotosYYYYYYYY-MM-DD</span>
<span style="color: #606060">  17:</span> <span style="color: #008000"># ============================================================================================== </span>
<span style="color: #606060">  18:</span>  
<span style="color: #606060">  19:</span> [reflection.assembly]::loadfile( <span style="color: #006080">"C:WindowsMicrosoft.NETFrameworkv2.0.50727System.Drawing.dll"</span>) 
<span style="color: #606060">  20:</span>  
<span style="color: #606060">  21:</span> $Files = Get-ChildItem -recurse -<span style="color: #0000ff">filter</span> *.jpg
<span style="color: #606060">  22:</span> <span style="color: #0000ff">foreach</span> ($file <span style="color: #0000ff">in</span> $Files) 
<span style="color: #606060">  23:</span> {
<span style="color: #606060">  24:</span>   $foo=New-Object -TypeName system.drawing.bitmap -ArgumentList $file.fullname 
<span style="color: #606060">  25:</span>  
<span style="color: #606060">  26:</span> <span style="color: #008000">#each character represents an ascii code number 0-10 is date </span>
<spa
 
n style="color: #606060">  27:</span> <span style="color: #008000">#10th character is space separator between date and time</span>
<span style="color: #606060">  28:</span> <span style="color: #008000">#48 = 0 49 = 1 50 = 2 51 = 3 52 = 4 53 = 5 54 = 6 55 = 7 56 = 8 57 = 9 58 = : </span>
<span style="color: #606060">  29:</span> <span style="color: #008000">#date is in YYYY/MM/DD format</span>
<span style="color: #606060">  30:</span>   $date = $foo.GetPropertyItem(36867).value[0..9]
<span style="color: #606060">  31:</span>   $arYear = [Char]$date[0],[Char]$date[1],[Char]$date[2],[Char]$date[3]
<span style="color: #606060">  32:</span>   $arMonth = [Char]$date[5],[Char]$date[6]
<span style="color: #606060">  33:</span>   $arDay = [Char]$date[8],[Char]$date[9]
<span style="color: #606060">  34:</span>   $strYear = [String]::Join(<span style="color: #006080">""</span>,$arYear)
<span style="color: #606060">  35:</span>   $strMonth = [String]::Join(<span style="color: #006080">""</span>,$arMonth) 
<span style="color: #606060">  36:</span>   $strDay = [String]::Join(<span style="color: #006080">""</span>,$arDay)
<span style="color: #606060">  37:</span>   $DateTaken = $strYear + <span style="color: #006080">"-"</span> + $strMonth + <span style="color: #006080">"-"</span> + $strDay
<span style="color: #606060">  38:</span>   $TargetPath = <span style="color: #006080">"c:RecentlyUploadedPhotos" + $strYear + "</span>" + $DateTaken
<span style="color: #606060">  39:</span> If (Test-Path $TargetPath)
<span style="color: #606060">  40:</span>   {
<span style="color: #606060">  41:</span>     xcopy /Y/Q $file.FullName $TargetPath
<span style="color: #606060">  42:</span>   }
<span style="color: #606060">  43:</span>   Else
<span style="color: #606060">  44:</span>    {
<span style="color: #606060">  45:</span>     New-Item $TargetPath -Type Directory
<span style="color: #606060">  46:</span>     xcopy /Y/Q $file.FullName $TargetPath
<span style="color: #606060">  47:</span>    }
<span style="color: #606060">  48:</span> } 
<span style="color: #606060">  49:</span>  

```