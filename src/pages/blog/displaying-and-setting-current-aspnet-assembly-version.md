---
templateKey: blog-post
title: Displaying and Setting Current ASPNET Assembly Version
path: blog-post
date: 2017-11-15T20:27:00.000Z
description: >
  When you’re building web applications and you’re setting up continuous
  integration and delivery pipelines, it’s worthwhile to know which particular
  version of the application is deployed to a given environment. 
featuredpost: false
featuredimage: /img/manifestversioning.png
tags:
  - cd
  - ci
  - dotnet
  - VSTS
category:
  - Software Development
comments: true
share: true
---
When you’re building web applications and you’re setting up continuous integration and delivery pipelines, it’s worthwhile to know which particular version of the application is deployed to a given environment. One of the easiest ways to share this information is from the application itself. Many sites will display build or version information in their footer or on a particular page. You can do this fairly easily in ASP.NET Core using this bit of code:

```
AssemblyVersion = @Microsoft.Extensions.PlatformAbstractions.PlatformServices.Default.Application.ApplicationVersion;
```

Displaying this on a Razor Page can be done simply by settings a property on the PageModel class (remember to have your page model inherit from PageModel) like so:

```
public class IndexModel : PageModel
{
    public string AssemblyVersion { get; set; }

    public void OnGet()
    {
        AssemblyVersion = typeof(RuntimeEnvironment).GetTypeInfo()
            .Assembly.GetCustomAttribute<AssemblyFileVersionAttribute>().Version;

        AssemblyVersion = @Microsoft.Extensions.PlatformAbstractions.PlatformServices.Default.Application.ApplicationVersion;
    }
}
```

Then on the Razor Page, specify the model and display the AssemblyVersion property wherever you like:

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
@section Scripts {
    @{await Html.RenderPartialAsync("_ValidationScriptsPartial");}
}
</body>
</html>
```

Now that you know how to display the version, what about setting it? You can manually specify the version in your project file as a property:

```
<PropertyGroup>
  <TargetFramework>netcoreapp2.0</TargetFramework>
  <Version>2.0.0.0</Version>
</PropertyGroup>
```

However, it’s most valuable to be able to specify a build number based on a CI build, so you’ll likely want to update this value as part of your build process. If you’re using Visual Studio Team Services, you can install an extension from the Marketplace, like the [Manifest Versioning Build Tasks](https://marketplace.visualstudio.com/items?itemName=richardfennellBM.BM-VSTS-Versioning-Task) extension.

![](/img/manifestversioning.png)

When you click Install, it will prompt you to choose the VSTS account to install it into. Once installed, you can access it as a build task. First, it’s a good idea to update the Build number format for your project so that it follows a 1.2.3.4 style, instead of the default that includes a YYYYMMDD date format:

![](/img/buildnumberformat.png)

Next, add a Task to your Build to Version .NET Core Assemblies, specifying as the Version Number the build number:

![](/img/versionassembliestask.png)

In this simple scenario I’m specifying my full version in the BuildNumber variable, but of course you could also use some logic to just append a build number suffix to a version number that’s set in your project, etc. I’ll leave these more advanced scenarios for another article, but here’s [a brief StackOverflow answer describing how VersionPrefix and VersionSuffix work](https://stackoverflow.com/a/42615574) that you may find helpful.