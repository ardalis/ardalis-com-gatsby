---
title: Stop Debugging and Start Running in Visual Studio
date: "2024-04-18T00:00:00.0000000"
description: The default way to start or run your application in Visual Studio has always been F5 or the solid green 'play' button. But this attaches a debugger, which is only needed if you're adding breakpoints and stepping through your code. It also can add significant time to the process of running your app. If you're not constantly using the debugger, consider making Ctrl+F5 your default way to launch your apps.
featuredImage: /img/stop-debugging-start-running-visual-studio.png
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/jxfAoUHH400?si=CvrmjUsJsmk15Pol" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

**NOTE:** Watch the video above to see actual timings of starting with and without debugging. Vote for this [feature request to make Run vs Debug more obvious in Visual Studio.](https://developercommunity.visualstudio.com/t/Change-Menu-Text-from-Start-Debugging-/10639783). Thanks!

I work with a lot of different.NET developers as a trainer, architect, and consultant with [NimblePros](https://nimblepros.com). One thing that I'm frequently pointing out to them is the difference in startup speed for their applications when launching from Visual Studio. Many, I would even say most,.NET developers have developed"muscle memory" of hitting F5 (or clicking the"Play" button) in order to launch their applications. And why not? This was the only toolbar button available for many years, and F5 is a simple enough key to remember, and is literally called"Start".

The (potential) problem is, the default start behavior actually means"Debug". Which means launching the Debugger, totally overhauling the UI of Visual Studio in the process, and adding often significant delay to the process.

The alternative is to"Start without Debugging" (also known as"Run" everywhere else but in Visual Studio), which is now available using a hollow"Play" icon on the toolbar as well as via keyboard shortcut, Ctrl+F5.

Which one do you use by default? If you're in the F5/Play by default camp, do me a favor and try Ctrl+F5/Hollow Play with your main app you're always working in and let me know in the comments if it makes a difference. Here's what one (of many) reply on Twitter/X found:

![ctrl+F5 incomparably faster than F5](/img/run-incomparably-faster-visual-studio.png)

If you use the toolbar, think of it like this:

![Start is slow; Start without debugging is fast](/img/start-slow-fast.png)

Personally, I like how Rider does it, which is also how the dotnet CLI works. Just call it **"Run"** if you want to run the app. Call it"Debug" if you want to debug the app.

You don't need to make it overcomplicated, especially for a menu item which should just be a simple verb.

None of this"Start the application but this time don't attach a debugger or do anything else but run it, ok?" menu text. And there's no need to confuse things with"Start the debugger and the application and attach the debugger to it all with this button", either. It's too verbose. It's just more words when **"Debug"** suffices. (Yeah, I know it's really *only*"Start Debugging" and"Start Without Debugging" but that's still obviously more verbose than necessary; I'm exaggerating to make a point)

Visual Studio already has a precedent for this, too, with tests:

![Run Tests or Debug Tests](/img/run-tests-debug-tests-visual-studio.png)

Note that there's not menu option to"Start Tests With Debugger" or"Start Tests Without Debugger" because that's completely unnecessary.

## Help Future Developers

Ok so why do I care, and why should you? My personal mission is to help developers write better code, faster. Starting the program you're writing is almost certainly a part of your development inner loop, and as such [relatively small gains can quickly add up since the activity is occurring so frequently](https://xkcd.com/1205/). And the investment in this case is minimal - literally just a tiny bit of education so developers can be intentional about how they want to run (or sometimes debug) their applications.

It's almost certainly too much of a change at this point for Visual Studio to change the behavior of F5/Play. But what they *could* do is change the menu text, so that it would become clear to developers that one option is for Debugging and the other is for Running. I ran [a poll which you can see (and participate in if you're quick) what my corner of Twitter thought about this](https://twitter.com/ardalis/status/1780290422213915131).

I also opened up [this change request with Visual Studio](https://developercommunity.visualstudio.com/t/Change-Menu-Text-from-Start-Debugging-/10639783), which you can view and vote up if you agree.

## What about VS Code

Visual Studio Code is a weird hybrid of Visual Studio and Rider when it comes to the names and text they use for their menus. Whereas in Visual Studio **running your app** which should be one of the most common things folks do is hidden behind a top level"Debug" menu option, VS Code has a top level menu item called"Run". Makes sense so far.

But then under that menu things look like this:

![vs code run menu](/img/vs-code-run-menu.png)

You might expect that the first and default option under the"Run" menu would be"Run" or"Run the App" but no doubt because of compatibility with Visual Studio it's"Start Debugging" (which doesn't even mention"Run"). And then for the second option it's"Run Without Debugging" which again is just an overly verbose way of saying"Run". Bonus points for using"Run" instead of"Start" for the non-debugging case, but weirdly inconsistent use of"Start" and"Run" in the two options...

For me, I mostly just use the terminal and `dotnet run` or `dotnet watch run` when I'm in VS Code, so these don't make a huge difference in my day to day coding. But some folks in the comments of [my YouTube video on this topic](https://www.youtube.com/watch?v=jxfAoUHH400) asked, so I thought I'd include some info here.


*If you found this useful, consider sharing it with a peer and joining my [weekly dev tips newsletter](/tips) or [subscribe to my YouTube channel](https://youtube.com/ardalis). Cheers!*

