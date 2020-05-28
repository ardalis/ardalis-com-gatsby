---
templateKey: blog-post
title: Create Alias to Set Window Title in PowerShell
path: /create-alias-to-set-window-title-in-powershell
date: 2019-05-30
featuredpost: false
featuredimage: /img/create-alias-to-set-window-title-in-powershell-760x360.png
tags:
  - powershell
  - tip
  - tips
  - tips and tricks
category:
  - Productivity
  - Software Development
comments: true
share: true
---
I’ve written previously about [how to set the window title in PowerShell](https://ardalis.com/set-cmd-or-powershell-window-title). Unfortunately, it’s a little complicated. [Recently on twitter, though, Greg MacLellan showed me how to create an alias](https://twitter.com/groogs/status/1129094739800801280) so you can just type `title something` to set the window title. This involves editing your PowerShell profile, which you may not even have, so here are the steps to take to make this happen.

First, determine if you have a profile, and if you don’t, create it. If you know you have one, you can skip down to just editing it.

```
test-path $profile
False
```

Run the command above. If you get False as shown, you don’t have a profile yet. Run the next command. If you got True, skip this next part.

```
New-Item -path $profile -type file -force
```

The above command creates a new empty file in your $profile location so you can edit it. Now just open it in your favorite editor. I’m using VS Code but you can use Notepad or your editor of choice.

```
code $profile
```

Once you have the file open in your editor, add this to it:

```
function Set-WindowTitle {
    $host.UI.RawUI.WindowTitle = [string]::Join(" ", $args)
}
Set-Alias -name "title" -value Set-WindowTitle
```

Once this is done, save the file and open a new PowerShell window. Type this to set the title:

```
title My Cool New Title!
```

If you want an alias that will set the title to the current directory name, which can also be a handy way to know what each window is doing,[check this out](https://gist.github.com/gregmac/81a6c853d3992cdf95fca47bb1bb0b63).