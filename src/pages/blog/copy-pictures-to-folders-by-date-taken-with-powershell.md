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

Of course I searched first for others who had done this – it’s hardly a problem unique to me. I pretty quickly found [someone who not only had gotten it to work but had some pretty nice links to help for those new to PowerShell](https://blogs.msdn.com/hans_vb/archive/2009/01/10/organizing-my-pictures.aspx). Hans of course also linked to the original author, [Kim, and his post on organizing photos into folders by EXIF date taken](http://blogcastrepository.com/blogs/kim_oppalfenss_systems_management_ideas/archive/2007/12/02/organize-your-digital-photos-into-folders-using-powershell-and-exif-data.aspx). A couple of other useful links:

* [Download and Install PowerShell](http://www.microsoft.com/windowsserver2003/technologies/management/powershell/download.mspx)
* [Learn How To Run Scripts](http://www.microsoft.com/technet/scriptcenter/topics/winpsh/manual/run.mspx) (no it doesn’t just work out of the box, but almost)
  * If you grab my file and just type OrgPhotos.ps1 into your PS prompt and it doesn’t work, this link will probably tell you why.

Here’s a link to my working script:

* [OrgPhotos.ps1](http://stevesmithblog.s3.amazonaws.com/OrgPhotos.ps1)

The only hitch I ran into was that it’s been so long since I’ve done anything with PowerShell, I forgot what the extension for it was. I thought maybe it was psl not ps1 (and the font used on the original post didn’t distinguish between the two). P-S-ell sounds more like PowerShell than P-S-one but at any rate if you try to run a .psl file from PowerShell, you’ll simply get an error like:

**Program ‘foo.psl’ failed to execute: No application is associated with the specified file for this operation.**

Easy fix – rename it to foo.ps1. (P-S-one)

Here’s my final version of the script. I also made the paths use YYYY-MM-DD as these sort properly chronologically when windows sorts the folders by filename.

```powershell
# ==============================================================================================
# 
# Microsoft PowerShell Source File -- Created with SAPIEN Technologies PrimalScript 4.1
#
# NAME: OrgPhotos.ps1
#
# UPDATED: Steve Smith
# DATE: 18 January 2009
# COMMENT: Changed file paths and confirmed it works.  Note that file extension must be .psONE not .psELL
#
# AUTHOR:  Kim Oppalfens, 
# DATE  : 12/2/2007
# 
# COMMENT: Helps you organise your digital photos into subdirectory, based on the Exif data
# found inside the picture. Based on the date picture taken property the pictures will be organized into
# c:RecentlyUploadedPhotosYYYYYYYY-MM-DD
# ==============================================================================================
 
[reflection.assembly]::loadfile( "C:WindowsMicrosoft.NETFrameworkv2.0.50727System.Drawing.dll") 

$Files = Get-ChildItem -recurse -filter *.jpg
foreach ($file in $Files) 
 {
   $foo=New-Object -TypeName system.drawing.bitmap -ArgumentList $file.fullname 

#each character represents an ascii code number 0-10 is date 
#10th character is space separator between date and time
#48 = 0 49 = 1 50 = 2 51 = 3 52 = 4 53 = 5 54 = 6 55 = 7 56 = 8 57 = 9 58 = :
#date is in YYYY/MM/DD format
   $date = $foo.GetPropertyItem(36867).value[0..9]
   $arYear = [Char]$date[0],[Char]$date[1],[Char]$date[2],[Char]$date[3]
   $arMonth = [Char]$date[5],[Char]$date[6]
   $arDay = [Char]$date[8],[Char]$date[9]
   $strYear = [String]::Join("",$arYear)
   $strMonth = [String]::Join("",$arMonth) 
   $strDay = [String]::Join("",$arDay)
   $DateTaken = $strYear + "-" + $strMonth + "-" + $strDay
   $TargetPath = "c:RecentlyUploadedPhotos" + $strYear + "\" + $DateTaken
If (Test-Path $TargetPath)
   {
     xcopy /Y/Q $file.FullName $TargetPath
   }
   Else
    {
     New-Item $TargetPath -Type Directory
     xcopy /Y/Q $file.FullName $TargetPath
    }
 } 

```
