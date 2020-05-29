---
templateKey: blog-post
title: Add Discord Notifications to ASP.NET Core Apps
date: 2020-04-08
path: /add-discord-notifications-to-asp-net-core-apps
featuredpost: false
featuredimage: /img/add-discord-notifications-aspnetcore-apps.png
tags:
  - clean architecture
  - devbetter
  - discord
  - domain events
  - GitHub
  - messaging
category:
  - Software Development
comments: true
share: true
---

I'm continuing to have fun building out features for the [devBetter](https://devbetter.com/) site, which provides resources for my group coaching members. We meet weekly to answer questions, work through exercises together, and share progress, but we also have a very active Discord server where we do a lot of the same thing throughout the week. As I was working on integrating GitHub actions with deployments to Azure, [I discovered how to add Discord web hooks to this process](https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks). Now a particular channel gets updates based on GitHub activity, including commits and actions like deployments. But I wanted to take that a step further and get notifications from my app itself.

The nature of devBetter is that it's a pretty small, close-knit group without too many active members. Keep that in mind as you read this article. Adding notifications for some of the event triggers I'm describing would not make sense for a very busy public-facing app. However, if you want to see a simple way to wire up domain events and Discord notifications in .NET Core with C#, keep reading.

## Domain Events

My web app is based on (an older version of) my [Clean Architecture solution template](https://github.com/ardalis/cleanarchitecture), available for free on GitHub. It comes with a simple domain events implementation that uses Autofac and is built into the DbContext of that sample. When used with entities and [DDD](https://www.pluralsight.com/courses/domain-driven-design-fundamentals), it takes care of sending events once each entity has been successfully saved to the database.

However, you can also dispatch domain events on demand by using the DomainEventDispatcher directly (as an injected service). That's what I'm doing in this case, since I'm firing these events from scaffolded ASP.NET Core Identity pages in my Web project.

Domain events, by the way, are great because they provide a very simple way for you to decouple "when this happens" and "then this should happen." [Learn more about domain events in my Pluralsight course](https://www.pluralsight.com/courses/domain-driven-design-fundamentals) or [my podcast](https://www.google.com/search?q=domain+events+site%3Aweeklydevtips.com).

## User Actions to Send to Discord

I don't expect to keep all of these triggers turned on, but at least initially I set these up because I was diagnosing some problems my users were reporting. We'd recently set up email confirmation logic in the system and between that and password resets, somewhere things weren't quite working. In the process of troubleshooting the problem, I decided that me knowing any time someone requested a password reset would be useful. Since then, I added a few more. At the time of writing this, I'm sending notifications to a private channel in my Discord server for these three triggers:

- User requested a link to reset their password
- An invalid user requested a link but isn't getting one (non-confirmed users don't get password reset emails sent to them - they need to confirm their email first)
- A new use registered with the system

I already had email notifications configured with SendGrid but something about just posting a message in a Discord felt more immediate and lightweight than one more message in my inbox.

Now, some of you may argue that this kind of thing should just be done using other logging or monitoring solutions. You're not wrong. There are so many ways to approach this problem, and the beauty of using domain events is that you can swap or even add as many different handlers as you want to any of these triggers. Or none at all. It's a very flexible solution.

## Discord Web Hooks in C#

With a bit of searching I found [this class](https://github.com/Hellsing/DiscordWebhook/blob/master/Webhook.cs) that does everything you need in one place. I modified it a bit so that it would work with C# nullable reference types and to add configuration support. My current version should be [here](https://github.com/ardalis/DevBetterWeb/blob/master/src/DevBetterWeb.Infrastructure/Services/Webhook.cs). Here's the full file for review:

```csharp
using Ardalis.GuardClauses;
using Discord;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace DevBetterWeb.Infrastructure.Services
{
    /// <summary>
    /// https://github.com/Hellsing/DiscordWebhook/blob/master/Webhook.cs
    /// This works but I don't like that the service and the state are in the same type; 
    /// services injected via DI should be stateless
    /// </summary>
    [JsonObject]
    public class Webhook
    {
        private readonly HttpClient _httpClient;
        private readonly string _webhookUrl;

        [JsonProperty("content")]
        public string Content { get; set; } = "";
        [JsonProperty("username")]
        public string Username { get; set; } = "";
        [JsonProperty("avatar_url")]
        public string AvatarUrl { get; set; } = "";
        // ReSharper disable once InconsistentNaming
        [JsonProperty("tts")]
        public bool IsTTS { get; set; }
        [JsonProperty("embeds")]
        public List<Embed> Embeds { get; set; } = new List<Embed>();

        public Webhook(IOptions<DiscordWebhookUrls> optionsAccessor)
        {
            Guard.Against.Null(optionsAccessor, nameof(optionsAccessor));
            Guard.Against.NullOrEmpty(optionsAccessor.Value.AdminUpdates, "AdminUpdates");

            _httpClient = new HttpClient();
            _webhookUrl = optionsAccessor.Value.AdminUpdates;
        }

        public Webhook(string webhookUrl)
        {
            _httpClient = new HttpClient();
            _webhookUrl = webhookUrl;
        }

        public Webhook(ulong id, string token) : this($"https://discordapp.com/api/webhooks/{id}/{token}")
        {
        }

        public async Task<HttpResponseMessage> Send()
        {
            var content = new StringContent(JsonConvert.SerializeObject(this), Encoding.UTF8, "application/json");
            return await _httpClient.PostAsync(_webhookUrl, content);
        }

        public async Task<HttpResponseMessage> Send(string content, string username = "", string avatarUrl = "", bool isTTS = false, IEnumerable<Embed>? embeds = null)
        {
            Content = content;
            Username = username;
            AvatarUrl = avatarUrl;
            IsTTS = isTTS;
            Embeds.Clear();
            if (embeds != null)
            {
                Embeds.AddRange(embeds);
            }

            return await Send();
        }
    }
}
```

## Configuration

The only configuration value I need is the URL for the web hook, which includes an ID and Discord Token in it. You get this information in Discord by right clicking on a channel and selecting Webhooks and then Create Webhook.

![](/img/image-2-discord.png)

I store this in Azure's configuration for my app service so it doesn't get checked into source control:

![](/img/image-1024x520.png)

To read the value from configuration, I have a class that maps to a configuration hierarchy:

```csharp
public class DiscordWebhookUrls
{
    public string? AdminUpdates { get; set; }
}

// and in Startup.ConfigureServices:
services.Configure<DiscordWebhookUrls>(Configuration.GetSection("DiscordWebhookUrls"));
```

## Raising Events

There are a few places where I'm raising events. One is when a user requests an email with instructions to reset their password. This is in scaffolded razor pages generated by Visual Studio. Here's the code - the [latest version of the source file is here](https://github.com/ardalis/DevBetterWeb/blob/master/src/DevBetterWeb.Web/Areas/Identity/Pages/Account/ForgotPassword.cshtml.cs).

```csharp
// For more information on how to enable account confirmation and password reset please 
// visit https://go.microsoft.com/fwlink/?LinkID=532713
var code = await _userManager.GeneratePasswordResetTokenAsync(user);
code = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(code));
var callbackUrl = Url.Page(
    "/Account/ResetPassword",
    pageHandler: null,
    values: new { code },
    protocol: Request.Scheme);

_logger.LogInformation("Sending password reset request with URL " + callbackUrl);

await _emailSender.SendEmailAsync(
    Input.Email,
    "Reset Password",
    $"Please reset your password by <a href='{HtmlEncoder.Default.Encode(callbackUrl)}'>clicking here</a>.");

var newEvent = new PasswordResetEvent(Input.Email!);
await _dispatcher.Dispatch(newEvent);

return RedirectToPage("./ForgotPasswordConfirmation");
```

Note just before the last line, I create a new event with the user's email and then I dispatch it. The dispatcher is injected as a service. It uses the dependency injection container, in this case [Autofac](https://autofaccn.readthedocs.io/en/latest/getting-started/index.html), to find all classes that implement `IHandle<T>` and then for a given type of domain event (like `PasswordResetEvent`) it finds all types that implement that interface and calls their `Handle` method.

## Handling Events and Sending Messages to Discord

With most of the work being done by the event dispatcher and the Webhook service, there's not much left to do in the individual handers. That's good, because they should be small and simple. Every one of my Discord notification handlers looks basically like this one:

```csharp
using DevBetterWeb.Core.Events;
using DevBetterWeb.Core.Interfaces;
using DevBetterWeb.Infrastructure.Services;
using System.Threading.Tasks;

namespace DevBetterWeb.Core.Handlers
{
    public class DiscordLogForgotPasswordHandler : IHandle<PasswordResetEvent>
    {
        private readonly Webhook _webhook;

        public DiscordLogForgotPasswordHandler(Webhook webhook)
        {
            _webhook = webhook;
        }

        public async Task Handle(PasswordResetEvent domainEvent)
        {
            _webhook.Content = $"Password reset requested by {domainEvent.EmailAddress}.";
            await _webhook.Send();
        }
    }
}
```

## Getting Messages in Discord

With all of this working, the messages come through in the configured Discord channel pretty much instantly when the user performs a particular action.

![](/img/image-1-1024x234.png)

Caveats and Next Steps

Ok, so this is working and I'm pretty happy with it. One reason why I opted to go this route is that I wanted a quick way to know what was happening in my app service and I wasn't having success getting logging working with it. I'll write that up in a separate article as I've now sorted it out, but I'm also getting more and more into Discord as I spend more time there with my devBetter members.

I don't recommend this as a general purpose logging or monitoring system or for enterprise software. Use something like the [ELK stack (which I cover in my Cloud Native book here)](https://docs.microsoft.com/dotnet/architecture/cloud-native/logging-with-elastic-stack) or App Insights for that. If you want a flexible logging system, check out [Seq](https://datalust.co/seq) as another option. The biggest problem with using this solution with any kind of scale is that [you'll run into Discord rate limits pretty quickly](https://discordapp.com/developers/docs/topics/gateway), and it would be easy for a malicious party to denial-of-service attack you. But for most small internal or hobbyist applications, this approach should work fine.

In terms of next steps, I plan to pick and choose which kinds of notifications I want to receive via email, and which to a Discord channel. I might implement an admin page where I (or other users, eventually) can manage how I want to receive notifications. Maybe each event trigger will give me the option to never get notifications, or to get email, or Discord, or SMS, or who knows what else. And then there's the possibility of multiple channels instead of just one. You can easily go pretty nuts with the complexity here, which might be an interesting modeling and UI/UX challenge to play with.

One more thing. If you're looking for a great, supportive group of people and direct access to me as a mentor, coach, and cheerleader, check out [devBetter.com](https://devbetter.com/). Read a couple of testimonials and see if it sounds like something you'd enjoy and benefit from. If you sign up and aren't happy with your decision for any reason, I'll refund your first month's membership dues.
