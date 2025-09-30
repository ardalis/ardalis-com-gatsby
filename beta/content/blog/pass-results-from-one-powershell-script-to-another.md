---
title: Pass Results from One PowerShell Script To Another
date: "2011-02-05T22:35:00.0000000-05:00"
description: If you're using PowerShell but want to keep your scripts DRY, you may want to factor common functions into their own scripts, and then call these scripts from multiple other scripts.
featuredImage: /img/code-quality.png
---

If you're using PowerShell but want to keep your scripts [DRY](https://deviq.com/don-t-repeat-yourself/), you may want to factor common functions into their own scripts, and then call these scripts from multiple other scripts. This is pretty easy to do. For instance, if you have an array of values that you want to use as inputs for several scripts, you could create a file like this one:

**Colors.ps1**

```powershell
function Colors
{
 return "Red","White","Blue"
}
```

Now, to use this in another PowerShell script, you simply need to load it by using a. and then assign the result to a variable after a semicolon (;). Like so:

**ListColors.ps1**

```powershell
..Colors.ps1;$result=Colors

foreach($c in $result)
{
 $c
}
```

That's all you need to do to pass results from one PowerShell script file back to another. Of course, if you wanted Colors.ps1 to also display the colors on its own, you could simply add the loop within that file, like so:

**Colors.ps1 (updated)**

```powershell
function Colors
{
 return"Red","White","Blue"
}

foreach($c in Colors)
{
 $c
}
```

With this in place, any scripts that depend on Colors.ps1 will output the colors using the loop in Colors.ps1, so running ListColors.ps1 now would result in two sets of colors being displayed.

