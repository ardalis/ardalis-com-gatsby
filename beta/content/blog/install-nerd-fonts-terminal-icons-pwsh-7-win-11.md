---
title: How to Install Nerd Fonts and Icons in PowerShell 7 on Windows 11
date: "2025-07-22T00:00:00.0000000"
description: Want those slick terminal icons and glyphs you keep seeing in screenshots? Here's the definitive guide to getting Nerd Fonts and terminal icons working with PowerShell 7 and Windows Terminal on Windows 11.
featuredImage: /img/nerd-fonts-powershell-terminal-icons.png
---

If you're setting up a polished dev terminal experience with icons, custom fonts, and PowerShell 7 on Windows 11, here's a step-by-step guide that actually works. We'll install a Nerd Font, configure PowerShell 7 properly, and enable terminal icons in directory listings — all without pulling your hair out. If video is more your thing, [check out my YouTube video on prettying up your terminal with terminal icons](https://youtu.be/TpHcEsPIOhw?si=YmQTIi6rLwB02Cbe).

---

## 🚫 What *Not* to Do

Before we dive in, here are a few things that **didn't work** and might trip you up:

- ❌ **Don't use `Ctrl + Click +`** in Windows Terminal to open a new tab after install Powershell 7 — it likely opens **PowerShell 5.1**, not PowerShell 7.
- ❌ Don't assume `ls` will show icons just because you installed a Nerd Font — PowerShell 7 uses a new formatting engine.
- ❌ Don't include `PS C:\Users\YourName>` when pasting commands — only paste the command part.

---

## ✅ Step 1: Install PowerShell 7

If you have a new Win11 OS, it most likely has PowerShell 5 running by default. You can check by running:

```powershell
$PSVersionTable.PSVersion
```

Try running Start>pwsh which should show something like this if you run the above command:

![powershell 7 version info](/img/powershell-open-with-pwsh.png)

If it's not PowerShell 7, then install it by running:

```powershell
winget install --id Microsoft.PowerShell --source winget
```

Once installed, open **PowerShell 7** by searching for **"PowerShell 7"** in the Start Menu or running `pwsh`. If you normally just open Windows Terminal, make sure your startup profile is configured to use Powershell, *not* Windows Powershell (which is v5).

![windows terminal default profile](/img/windows-terminal-default-profile-select-powershell.png)

## ✅ Step 2: Install a Nerd Font

You can grab fonts from the web site:

1. Visit [https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)
2. Download a font you like (e.g. **JetBrainsMono**, **FiraCode**, **CascadiaCode**)
3. Extract the `.zip` file
4. Right-click the `.ttf` files and choose **Install for all users**

OR you can install them using PowerShell 7 (but not 5!):

```powershell
Install-NerdFont -Name JetBrainsMono
```

The install command, assuming it works, takes care of downloading and registering the fonts.

## ✅ Step 3: Set Windows Terminal to Use the Nerd Font

1. Open **Windows Terminal**
2. Click the down arrow → **Settings**
3. Select your **PowerShell 7 profile** (probably just called Powershell)
4. Under **Appearance > Font face**, enter:

```powershell
JetBrainsMono Nerd Font
```

(or your nerd font of choice)

![terminal settings powershell nerd font](windows-terminal-default-profile-select-powershell)

5. Save and restart the terminal (start - run - pwsh)

## ✅ Step 4: Install Terminal-Icons for `ls` Output

In **PowerShell 7**, run the following (in an admin prompt) to install and enable terminal icons in directory listings:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
Install-Module PowerShellGet -Force -AllowPrerelease
Import-Module PowerShellGet -Force
Install-PSResource -Name Terminal-Icons -TrustRepository -Force
Import-Module Terminal-Icons
```

Then test it - launch a new window using start - run - pwsh.

```powershell
ls
```

You should now see icons for files and folders 🎉! Example:

![terminal icons ls output](pwsh-7-nerd-fonts-terminal-icons-working.png)

## ✅ Step 5: Make It Stick with Your PowerShell Profile

To automatically load `Terminal-Icons` and start in your preferred folder every time PowerShell launches:

```powershell
notepad $PROFILE
```

Add these lines at the bottom (change the Set-Location to wherever you'd prefer to start when a new powershell terminal opens):

```powershell
Import-Module Terminal-Icons
Set-Location"C:\dev"
```

Save and restart your terminal.

## 🧠 Bonus: Set PowerShell 7 as the Default Shell in Windows Terminal

If you didn't do this already, set up Windows Terminal so it default to PowerShell 7:

1. Open **Windows Terminal > Settings**
2. Go to the **Startup** section
3. Set **Default profile** to **PowerShell** (which points to PowerShell 7)

## ✅ Done!

You now have a fully configured PowerShell 7 terminal with:

- ✅ Nerd Font rendering
- ✅ Icon-enhanced `ls` output
- ✅ A consistent working folder (`C:\dev`)
- ✅ Clean, modern developer vibes 😎

Let me know if you want to go further with Oh My Posh or Starship for a fully themed and functional prompt.

## Resources

- [Nerd Fonts Repo](https://github.com/ryanoasis/nerd-fonts)
- [Nerd Fonts Website](https://www.nerdfonts.com/font-downloads)
- [Terminal Icons](https://github.com/devblackops/Terminal-Icons)
- [YouTube: Pretty Up Your Windows Terminal by @ardalis](https://www.youtube.com/watch?v=TpHcEsPIOhw&ab_channel=Ardalis)

