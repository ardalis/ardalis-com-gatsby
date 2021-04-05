---
templateKey: blog-post
title: Run a Docker Command to Launch RabbitMQ from a StreamDeck
date: 2021-03-23
description: Because why not?
path: blog-post
featuredpost: false
featuredimage: /img/run-docker-rabbitmq-command-streamdeck.png
tags:
  - programming
  - hardware
  - performance
  - stream deck
  - rabbitmq
  - docker
category:
  - Software Development
comments: true
share: true
---

I'm working on a distributed system demo that relies on RabbitMQ for its inter-app messaging. Not wanting to force users to actually have to *install* RabbitMQ, I'm using Docker to run it. It's really easy to do this. If you've never tried to launch RabbitMQ, complete with its management web app, from a docker command line, try this:

```powershell
docker run --rm -it --hostname ddd-sample-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management
```

Once you've run that, open up localhost:15672 and you should be looking at the management app (user: guest / password: guest by default). It's magic.

That said, you do still have to remember to run it. If your entire app is configured to run in docker, you can set all of this up using something like docker-compose, and eventually that's my plan here as well. But for now I don't have that set up since I want to be able to run it quickly from Visual Studio or dotnet CLI and building it with docker every time takes longer.

Which means I need to remember to run the above command at least once each time I reboot my computer (or kill docker, whichever comes first) before I can run the app(s). This was me, yesterday, remembering this for at least the third time in a week:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">&gt; App won&#39;t start<br><br>Me: WTF? This was working until I rebooted.<br><br>&gt; RabbitMQ not running<br><br>Me: How can I make this easier?<br><br>(spends 20 minutes researching how to add a button to StreamDeck to start RabbitMQ from PowerShell)<br><br>Me: Now I have to blog this. What was I doing again?</p>&mdash; Steve &quot;ardalis&quot; Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1374087936044580866?ref_src=twsrc%5Etfw">March 22, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

If you read that thread you'll see there are a number of solutions, like running RabbitMQ as an actual Windows service and other things that would probably work. You'll also note that I was serious about that whole blogging about it thing...

But I also have a [Stream Deck (affiliate link - thanks for your support)](https://amzn.to/3faKOOO) and it has unused buttons staring at me, making me feel guilty. So I figured I'd make a button to run this command. How hard could it be, really?

Well, it turns out there isn't a built-in PowerShell command, so you have jump through more hoops to make it work. It would be great to just put the command into the Stream Deck button setup, but I didn't find a way to do that. So you're basically forced to create a .ps1 file with the script in it.

I did that, and then configured a button with:

```powershell
powershell.exe -ExecutionPolicy ByPass -File script.ps1
```

But that didn't work for me (though it [seems to have worked for others](https://www.reddit.com/r/ElgatoGaming/comments/9mpbpf/running_powershell_script_with_elgato_streamdeck/)).

It turns out there are [good reasons to use a batch file to call your PowerShell file](https://blog.danskingdom.com/allow-others-to-run-your-powershell-scripts-from-a-batch-file-they-will-love-you-for-it/). So I created such a batch file using the sample from this link that basically parameterizes the previous script and calls it.

This actually worked, but it was completely headless. This might be what you want from your Stream Deck button, to execute PowerShell scripts with no UI at all. But in my case I wanted to be able to see the log output of the RabbitMQ process.

Well, you may or may not know that you can add a console UI to your batch file by simply renaming it from .bat to .cmd, [as suggested here](https://www.reddit.com/r/ElgatoGaming/comments/82iiyy/trying_to_run_a_bat_file_with_stream_deck/). Making that small adjustment got me exactly what I wanted - a dedicated button to start RabbitMQ in a new window with log output.

Here's what the final product looks like in my Stream Deck:

![Stream Deck with Start RabbitMQ key](/img/streamdeck-rabbitmq.png)

And here's the window it produces when pressed:

![Console window launched by Stream Deck with RabbitMQ process running via Docker](/img/docker-rabbitmq-console-from-streamdeck.png)

So that's it! If you have a better way to execute arbitrary powershell (or docker) commands from your StreamDeck, please share it in the comments below. Otherwise, I hope this helped you out.
