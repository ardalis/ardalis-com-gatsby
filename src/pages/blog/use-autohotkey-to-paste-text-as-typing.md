---
templateKey: blog-post
title: Use AutoHotKey to Paste Text as Typing
date: 2021-05-18
path: /use-autohotkey-to-paste-text-as-typing
featuredpost: false
featuredimage: /img/use-autohotkey-to-paste-text-as-typing.png
description: Sometimes, especially when recording but also occasionally to get around website password-paste-protections, it's helpful to paste from your clipboard and have the text appear with a delay between each character as if it were being typed. The free AutoHotKey tool and a custom script will solve this for you.
tags:
  - autohotkey
  - recording
  - streaming
  - training
category:
  - Software Development
  - Productivity
comments: true
share: true
---

I've heard about [AutoHotKey](https://www.autohotkey.com/) before but never gotten round to installing it until recently. Basically I had a bunch of text (code) that I wanted to display in chunks as part of [an upcoming Pluralsight course](https://www.pluralsight.com/authors/steve-smith). I didn't want it to just all appear at once, but rather to show as if it were being typed. But actually typing frequently involves typos and backspaces and other distractions. I knew others had solved this problem before, so with a bit of searching I stumbled upon AutoHotKey and a couple of scripts that helped me get going in the right direction. Here's what you need to know.

AutoHotKey is an automation tool that lets you bind arbitrary scripts to hotkeys of your choosing. It's similar (and much older) than what a [Stream Deck](https://amzn.to/3v4ojjQ) (affilate link) lets you do, but as a purely software (and free) solution.

## Get AutoHotKey

The simplest way to [get AutoHotKey on Windows is with Chocolatey](https://community.chocolatey.org/packages/autohotkey). You can see it in my full list of tools used, but to just install what you need, run this:

```powershell
choco install autohotkey
```

You can also [install it from the AutoHotKey web site](https://www.autohotkey.com/) (right on the home page), of course.

## Get a Type Slowly From Clipboard Script

According to the docs, "AutoHotKey doesn't do anything on its own; it needs a script". So, here's a script to get you started. Its purpose is to type from your clipboard with a delay between each character being output. You'll want to save it in a `.ahk` file like `type_clipboard_slowly.ahk`.

```text
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

setkeydelay 70

^+v::GoTo, CMD

CMD:
;Send {Raw}%Clipboard%
vText := Clipboard
Clipboard := vText
Loop Parse, vText, % "`n", % "`r"
{
    Send, % "{Text}" A_LoopField
    Send, % "+{Enter}"
}
return
```

A few things to note about this script:

- By default, scripts use `SendMode Input` which is faster, but ignores `setkeydelay` which is the whole point of this script
- setkeydelay takes an integer; the bigger it is the slower the typing will be
- ^+v is ctrl+shift+v so just like your normal ctrl+v paste, but with shift held
- ; is a comment. Initially I just sent the Clipboard but there were whitespace issues I addressed with the loop

The script is very low level. If you have a lot of text, it just keeps slowly typing it out no matter what window you navigate to. So, play around with it using small amounts of text before you try pasting anything big.

Also, since it's simulating actual keypresses, it will trigger help in your IDE, so things like automatic closing braces or parentheses will be added as the script "types", and this could result in duplicates. I found it worked best sometimes if I just pasted one line at a time.

## Reloading

As you modify the script, you can right click on the AutoHotKey tray icon to reload it before trying it again. I don't claim to be an expert on AHK so obviously if this seems interesting, read their [documentation](https://www.autohotkey.com/docs/AutoHotkey.htm).

Want to see the script in action?

## AutoHotKey Clipboard as Typed Text Demo

```
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
```

![animated gif showing output](/img/ahk-clipboard-as-typed-text.gif)

### Additional References

- [AutoHotKey](https://www.autohotkey.com)
- [AutoHotKey via Chocolatey](https://community.chocolatey.org/packages/autohotkey)
