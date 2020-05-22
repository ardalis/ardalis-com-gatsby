---
templateKey: blog-post
title: Use an Integrated Shell Console Terminal in VS Code
path: blog-post
date: 2017-01-05T04:24:00.000Z
description: "VS Code is a lightweight code editor available for free from
  Microsoft. It’s a great, open-source tool for quick edits, or even for all day
  coding. "
featuredpost: false
featuredimage: /img/vscode-760x360.png
tags:
  - vs code
category:
  - Software Development
comments: true
share: true
---
VS Code is a lightweight code editor available for free from Microsoft. It’s a great, open-source tool for quick edits, or even for all day coding. While I think most users of VS Code are comfortable having it open separately from their command line environment, you can also host an integrated shell (console or terminal) within VS Code itself. This can be nice if you want to use it in full screen mode (or even Zen Mode – try it with ctrl+K Z).

To enable the integrated shell, just use the ctrl+ keyboard shortcut (that’s control backtick, not apostrophe). This should launch your default shell. If you’re on Windows, this will be a standard command prompt, but you can adjust it to use Powershell or even Bash if you’d like. To try it out, follow these steps:

1. Open a command window where you have both ‘dotnet’ and ‘code’ in your path
2. Create a new directory and change directories into it
3. Run ‘dotnet new’
4. Run ‘code .’ (code space period) VS Code should launch in the current folder.
5. Hold ctrl+. VS Code should open its terminal window.
6. Run ‘dotnet restore’ (or click the Update ribbon that is probably nagging you at the top of VS Code)
7. Run ‘dotnet run’

You should see Hello World! execute within your terminal window integrated within VS Code. Note that this console window runs with the same permissions as VS Code, so if you need administrator privileges you’ll need to use something like `runas.exe` or launch VS Code with elevated permissions.

If you want to change from using a standard `cmd` prompt to using PowerShell, you edit the “terminal.integrated.shell.windows” variable in your settings. Go to File – Preferences – Workspace settings and search for this key. On the right, add the following which will replace the default value:

`// Place your settings in this file to overwrite default and user settings. `\
`{
    "terminal.integrated.shell.windows": "C:\\Windows\\sysnative\\WindowsPowerShell\\v1.0\\powershell.exe"
}`

Now use ctrl+shift+` to add another terminal window (note the `shift` – without it you’ll just switch to your current shell window instead of adding a new one). This time you should see that it’s running PowerShell. You can switch between your different shells using the dropdown (or [bind your own keyboard shortcuts](https://code.visualstudio.com/docs/editor/integrated-terminal)). Close a shell permanently by clicking the trashcan icon.

Below you can see Hello World running in Powershell, with multiple integrated terminals running in VS Code.

![](/img/codeintegratedterminal-300x178.png)