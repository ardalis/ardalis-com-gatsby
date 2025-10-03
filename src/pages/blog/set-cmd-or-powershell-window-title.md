---
templateKey: blog-post
title: Set cmd or PowerShell Window Title
date: 2017-06-07
path: /set-cmd-or-powershell-window-title
featuredpost: false
featuredimage: /img/PowerShellTitle.png
description: As CLI tools become more and more popular, it's not unusual that I find I have more than one command, bash, or PowerShell window open. Often, each window is serving a specific purpose. While I really like that I can integrate a command shell right into Visual Studio Code, when I'm not doing that it's nice to be able to give each window a name that makes sense.
tags:
  - cmd
  - powershell
  - tip
category:
  - Productivity
  - Software Development
comments: true
share: true
---

As CLI tools become more and more popular, it's not unusual that I find I have more than one command, bash, or PowerShell window open. Often, each window is serving a specific purpose. While I really like that I can integrate a command shell right into Visual Studio Code, when I'm not doing that it's nice to be able to give each window a name that makes sense.

## Setting Window Title of Windows cmd Prompt

To set the title on a cmd window, just type:

```
title This is my new title
```

Here's the result:

[![cmd window set title](/img/cmd-title.png)](/img/cmd-title.png)

## Setting Window Title of PowerShell Window

For PowerShell, it's not quite as simple. You need to run the following command:

```powershell
$host.UI.RawUI.WindowTitle = "New Title"
```

The good news is that you get statement completion, so you can just type the first letter of each item after $host (except WindowPosition shows up before WindowTitle, so hold shift-tab to cycle to the next completion option). Or just bookmark this tip and come back when you forget. If you know you saw it on my blog, you can narrow down your google search by throwing 'ardalis' in there - that's what I do to find my own tips since I can't remember them all, either.

When I'm working on the documentation for ASP.NET Core, I sometimes have multiple windows devoted to running the documentation locally, and working with git. I might have a window like this one:

[![PowerShell Window Title](/img/PowerShellTitle.png)](/img/PowerShellTitle.png)

The nice thing about this approach is that if you have more than one PowerShell (or other shell) window running in the task bar, you can easily differentiate which one you need:

[![PowerShell TaskBar Windows](/img/PowerShellWindows.png)](/img/PowerShellWindows.png)

I haven't worked as much with bash shells, but if you're looking to do something like this there, I think [this](https://unix.stackexchange.com/a/104026) might help.

## Set PowerShell Window Title to Current Path

I kind of like the default behavior of my Ubuntu WSL terminal, which is to show me where I am. If you want the same behavior in PowerShell, it's actually pretty straightforward. Just edit your $PROFILE and add a `prompt` function.

1. Open a PowerShell window.
2. Enter `code $PROFILE` (opens VS Code to edit; replace with your text edit of choice)
3. Add the following:

```powershell
function prompt {
    $Host.UI.RawUI.WindowTitle = (Get-Location)
    "PS " + (Get-Location) + "> "
}
```

The prompt function if called every time PowerShell displays the prompt. So in addition to controlling what your prompt look like, you can also use it to perform other actions after each command completes. In this case, it's going to update the title to the present working directory, which in PowerShell is `(Get-Location)`.

## YouTube Short

Want this in [infomercial](https://www.youtube.com/watch?v=qM4zMofsI7w&ab_channel=JaminSchmitt) form? See [Every PowerShell tab looks the same? FIX IT!](https://youtube.com/shorts/kfZswQpDJDw?feature=share)
