---
templateKey: blog-post
title: REST Commands and Queries in VS Code
date: 2020-02-26
path: /rest-commands-and-queries-in-vs-code
featuredpost: false
featuredimage: /img/rest-commands-and-queries-in-vs-code.png
tags:
  - rest
  - tools
  - vs code
  - web api
category:
  - Software Development
comments: true
share: true
---

Recently in one of our great [devBetter discussions](https://devbetter.com/), [Rick Hodder](https://twitter.com/rickhodder) (go follow him now) shared a cool extension for VS Code. Basically, it lets you turn VS Code into a REST client. Think of it like a combination of Postman and [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15) (or [LinqPad](https://www.linqpad.net/) or SSMS if you prefer).

Now, I like [Postman](https://www.postman.com/). It's a great and powerful tool. But it's a lot more effort to issue a request than, say, running a SQL query in LinqPad or one of the other SQL query tools mentioned. With those tools, you can just put all of your query logic into a file and run it. Or better yet, have multiple queries in the same file, highlight what you want, and just run one of them. It's a great way to quickly interact with a remote server resource (in this case a database).

Enter the [humao.rest-client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) for VS Code. With it, you can add HTTP queries/commands to any file with a .http or .rest extension and run them directly from the VS Code editor, like this:

![VS Code REST Client Screenshot](/img/image-1536x821.png)

A .rest file with requests and responses in VS Code. [View the whole file here](https://github.com/ardalis/ApiEndpoints/blob/master/sample/httpCommands.rest).

Creating the requests is pretty straightforward. You just need to specify the verb (defaults to GET) and endpoint you're hitting. If you need any headers, add them on the next line. If there's a body, add it after that. That's it. You can quickly generate the code you need by issuing requests in your browser from your SPA or your Swagger client and then copy/pasting from the network tab:

![Screenshot of Swagger and Chrome Dev Tools.](/img/image-1-1536x630.png)

Copy requests directly from Chrome Dev Tools Network tab.

## That's great, Steve, but...

"I already just use Postman/Swagger/Fiddler/curl for this..."

Sure. And if that works for you, keep doing that. This isn't about convincing you to abandon what works for you. I still use those tools, too, when it makes sense. What I really like about this tool is:

- It's very lightweight. I already have VS Code. I don't need to install another standalone application.
- It works with plain text files. They're very easy to copy/paste, edit, and version control.
- Did I mention version control? The plain text files can easily be kept with your API or its tests in your source repository.
- Being able to see and execute multiple queries in one file is nice when you're trying to manage a bunch of endpoints at once, as opposed to the much busier interfaces of other tools.

In the course of playing around with this extension, I also discovered there are actually quite a number of REST client extensions available for VS Code. I haven't done an exhaustive review of all of them, so if you're well-versed in another and want to share why you like it (or not), feel free to comment below.

Thanks!
