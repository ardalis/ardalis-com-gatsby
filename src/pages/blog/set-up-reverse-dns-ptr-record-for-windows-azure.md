---
templateKey: blog-post
title: Set up Reverse DNS (PTR) Record for Windows Azure
date: 2019-04-14
path: /set-up-reverse-dns-ptr-record-for-windows-azure
featuredpost: false
featuredimage: /img/azure-logo.png
tags:
  - azure
  - cli
  - devops
  - dns
category:
  - Software Development
comments: true
share: true
---

Windows Azure offers support for RDNS (PTR) records, which are used to get a hostname from an IP address (the opposite of what DNS does, hence the name). Microsoft has an article that describes [how to set RDNS up](https://azure.microsoft.com/en-us/documentation/articles/dns-reverse-dns-record-operations-cli/), but it assumes you've already installed the [azure CLI tools](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/). Since I'm going through the process from scratch, I thought I'd share the full process here.

You'll need to have npm installed. I already do, so I'm going to skip that step.

Next, you need to install the azure command line interface (CLI). This is different from the Powershell cmdlets that you may have heard of and/or used in the past. It's a different thing, and you can use it from your shell/terminal of choice. Open a command prompt (with npm in the path) and run:

\> npm install azure-cli -g

The next step is to authenticate. Run:

\> azure login

This will prompt you to go to a special device login URL and enter a code and log in, similar to how you may have authenticated on a Roku or other device to authenticate (without entering your credentials into the device itself). Note that this process doesn't require entering credentials in the command line, only in a browser over SSL. [Read more about this process](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-connect/).

Now you have the tools and you're authenticated. The next step is to add RDNS for an IP address you have. You can view your accounts using:

\> azure account list

Then choose the account you'll be working with:

\> azure account set \[ID\]

Now confirm that your reserved-ip appears:

\> azure network reserved-ip list

It's at this point I realize that I need to be in [Resource Manager Mode (read)](https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-azure-resource-manager/), because the command I want to use (public-ip) isn't found. This is achieved with this command:

\> azure config mode arm

Now the public-ip command is available, so start with a list command:

\> azure network public-ip list
No public ip addresses found

Hmm, that's unfortunate. I thought my reserved IP from above would be the same as a public IP (since I can certainly get to that IP from public places...). Looks like adding a public IP is its own step. To do that, we're going to need a few parameters, like our resource group name.

\> azure group list

Note the name of the resource group that will hold the public IP you're about to create. To create a Public IP resource, you need to know its name, the resource group name, the location, the domain prefix (e.g. <domain prefix>.location.cloudapp.net) and the reverse-fqdn (fully qualified domain name) which is the domain you want to associate with the IP address. The command looks like this:

\> azure network public-ip create -n PublicIPName -g ResourceGroupName -l eastus -d domainprefix -s subscriptionID -f foo.contoso.com.

When I ran this command for the first time, I got:

The subscription is not registered to use namespace 'Microsoft.Network'.

## Update (Some Time Later)

… and that's as far as I got with this before I had to move on to something else. This has sat in my Drafts folder for a long time. I'm going to go ahead an publish it in case it's worthwhile for anyone, and apologies for not fully resolving things. If you have questions about how to proceed, ask them in the comments or link to your question on StackOverflow and perhaps others here will help.
