---
title: VS Code Disable Logging Loading Symbols
date: "2021-05-25T00:00:00.0000000"
description: When you run a VS Code dotnet app by default it will add a bunch of noise to the console about loading symbols. I got tired of searching for how to disable this over and over again so here's a quick tip on this article.
featuredImage: /img/vs-code-disable-logging-loading-symbols.png
---

When I create a new.NET (5) console application and run it in VS Code, I get output like the following:

![console output loading symbols](/img/vs-code-disable-logging-loading-symbols-console-output.png)

This is just a lot of noise that adds no value and I'd like to disable it so I can see the actual output of my program.

Fortunately, there's a simple way to do this - just add a setting in your `launch.json` file:

![launch.json file](/img/vs-code-disable-logging-loading-symbols-launch-json.png)

Here's the relevant setting if you just want to copy/paste it:

```javascript
// add a comma before this,
// perhaps after "stopAtEntry": false"logging": {"moduleLoad": false
}
```

That's it. Once this is done, the same output will look something like this:

![console output after logging is off](/img/vs-code-disable-logging-loading-symbols-console-output-after.png)

## Additional References

- [Original tip I found](https://github.com/Microsoft/vscode-cpptools/issues/1698#issuecomment-374297417)

