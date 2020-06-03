---
templateKey: blog-post
title: Integrate GitHub and Discord with Webhooks
date: 2020-04-30
path: /integrate-github-and-discord-with-webhooks
featuredpost: false
featuredimage: /img/integrate-github-discord-webhooks-760x360.png
tags:
  - discord
  - github
  - webhooks
category:
  - Software Development
comments: true
share: true
---

I've started using Discord more and more for things like my [private group coaching program focused on software developers](https://devbetter.com). It's worked quite well and is completely free for our needs. You can easily add bots and notifications from other system, [including your own ASP.NET web applications](/add-discord-notifications-to-asp-net-core-apps), using web hooks.

One of the easier ways to configure notifications from things you care about as a developer to your Discord server is with GitHub web hooks. [There's great write-up on how to do this here](https://gist.github.com/jagrosh/5b1761213e33fc5b54ec7f6379034a22), which I'm basically enhancing here for my own purposes (and in case that resource ever disappears).

## Configure Discord Webhooks

First, you need to have a Discord server. If you don't have one, you can set one up for free. Once you have a server set up, I recommend configuring a text channel just for your GitHub notifications:

![discord text notification channel](/img/discord-notification-text-channel.png)

You can tweak the settings on the channel to control who should or shouldn't have access to it. Then, click on Webhooks menu option and create a new webhook:

![discord text notification channel](/img/discord-edit-webhook.png)

The important thing is the URL at the bottom. Copy that to your clipboard. Then you can exit out of the settings and just watch the channel, which should start to have content automatically added to it once you complete the next steps.

## Configure GitHub Webhooks

Now go to GitHub, sign in, and navigate to one of your repositories from which you'd like to receive notifications in Discord. Click on Settings and choose the Webhooks menu:

![configure github webhooks](/img/configure-github-webhooks.png)

Although nothing really jumps out and says it, GitHub is the producer of events and Discord is the consumer. Discord provides the URL for the Webhook, and you provide this URL to GitHub so that GitHub can make requests to this URL whenever something of interest happens.

Next, choose Add webhook from the GitHub settings page.

![github add webhook](/img/github-add-webhooks.png)

Paste in the URL from Discord. Add /github to the end of it. Be sure to change the Content type to application/json. Change the radio button to “Send me everything” and then click the Add webhook button.

At this point, you should be notified whenever anything happens with this repository. You can always dial it down later if it gets to be too much noise. To test it out, try starring and unstarring your repository, or adding a comment to an issue. Any of these should trigger notifications in your Discord channel.
