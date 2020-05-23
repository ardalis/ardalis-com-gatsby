---
templateKey: blog-post
title: Razor Pages Model NullReferenceException
path: blog-post
date: 2017-11-14T20:38:00.000Z
description: "Here’s a quick tip: If you’re adding a new Razor Page to an
  ASP.NET Core 2.0+ project, and you add a codebehind model class, but then when
  you try to use it you get a NullReferenceException, this might be why. First,
  specify the model correctly from the razor page (Index.cshtml):"
featuredpost: false
featuredimage: /img/pay-1036469_1280.jpg
tags:
  - asp.net core
  - razor pages
category:
  - Software Development
comments: true
share: true
---
Here’s a quick tip: If you’re adding a new Razor Page to an ASP.NET Core 2.0+ project, and you add a codebehind model class, but then when you try to use it you get a NullReferenceException, this might be why. First, specify the model correctly from the razor page (Index.cshtml):

```
@page
@model WebProject.Pages.IndexModel
<!DOCTYPE html>
 
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Index</title>
</head>
<body>
    Version: @Model.AssemblyVersion
</body>
</html>
```

If you’re literally adding just one page to your project, you need to make sure you specify the full namespace of the model type, since you don’t have any _ViewStart or _ViewImports files.

Next, and this is what fixed the issue for me, **make sure your model type inherits from PageModel**. Otherwise, it will be null.

Example (Index.cshtml.cs):

```
namespace WebProject.Pages
{
    public class IndexModel : PageModel
    {
        public string AssemblyVersion { get; set; }
 
        public void OnGet()
        {
            AssemblyVersion = @Microsoft.Extensions.PlatformAbstractions.PlatformServices.Default.Application.ApplicationVersion;
        }
    }
}
```

If you just have a POCO instead of a child of PageModel, you’ll get a NullReferenceException when your razor page tries to access a property of your model. Hope this helps! Leave a comment if this was helpful, or if you found this page from a similar error and you got it working.