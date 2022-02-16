---
templateKey: blog-post
title: Generate SSH RSA Key Pairs on Windows with WSL
date: 2022-01-20
description: SSH keys provide an alternate way to authenticate with many services like GitHub. Creating them on Windows is simple using Windows Subsystem for Linux (WSL).
path: blog-post
featuredpost: false
featuredimage: /img/generate-ssh-rsa-keys-windows-wsl.png
tags:
  - windows
  - linux
  - wsl
  - ssh
  - rsa
category:
  - Software Development
comments: true
share: true
---

Secure Shell Protocol (SSH) keys provide an alternate way to authenticate with many services like GitHub. Creating them on Windows is simple using Windows Subsystem for Linux (WSL).

## Windows Subsystem for Linux

First you'll need to have WSL running on your computer. [Set up WSL for Windows](https://docs.microsoft.com/en-us/windows/wsl/install).

## Generate SSH RSA Key Pair

Open a WSL terminal (Start -> WSL -> Enter) and enter the following command:

```powershell
ssh-keygen
```

It will ask you where to save the key - just hit enter and use the default `(/home/username/.ssh/id_rsa)`.

Enter your passphrase (or just hit enter) and confirm it.

Your key files will be generated.

![WSL Terminal showing commands](/img/wsl-ssh-keygen.png)

## Find the Keys in Windows

The easiest way to find the keys on your Windows file system is to run `explorer.exe .` from the appropriate directory. As you can see in the image above, change directory to your home folder (`/home/ssmith` in my case). Then run explorer to launch File Explorer.

![File Explorer Showing Files in Folder](/img/ssh-key-folder.png)

## Protect Your Private Key

The `id_rsa` file contains your private key. Keep it secure and don't share it with anyone.

The `id_rsa.pub` file is your public key. As such, you can share it with any app with which you wish to authenticate.

If you wish to [use SSH with GitHub, start here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

## Summary

It's easy to set up SSH keys on Windows using WSL and the `ssh-keygen` command. Refer to this article next time you need to do so. Thanks!
