---
title: dotnet-ef does not exist
date: "2019-10-09T00:00:00.0000000"
description: If you're trying to run EF Core migrations and getting errors, this post has the most common fix - you need to install the CLI tools for Entity Framework Core.
featuredImage: /img/dotnet-ef-tool-install.png
---

If you're trying to run EF Core migrations using commands like `dotnet ef migrations add NAME` or `dotnet ef database update` and you're getting errors like the one shown in the screenshot above, here's the fix.

You need to install the dotnet-ef tool, ideally globally so you can run it from anywhere. To do so, run this script from a command prompt/terminal window:

dotnet tool install --global dotnet-ef

Once you've done so, you should be able to run your `dotnet ef` commands successfully.

If this helped you, consider sharing this post on your social media to help others discover it. Thanks!

