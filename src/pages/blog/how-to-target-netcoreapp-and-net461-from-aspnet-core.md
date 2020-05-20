---
templateKey: blog-post
title: How to Target netcoreapp and net461 from ASPNET Core
path: blog-post
date: 2016-05-24T06:44:00.000Z
description: The default templates for ASP.NET Core RC2 apps only target
  “netcoreapp1.0”. If you wish to have one app target multiple frameworks, you
  can do so by first adding the new framework to the list in project.json (e.g.
  “net461” for .NET Framework 4.6.1).
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
The default templates for ASP.NET Core RC2 apps only target “netcoreapp1.0”. If you wish to have one app target multiple frameworks, you can do so by first adding the new framework to the list in project.json (e.g. “net461” for .NET Framework 4.6.1). However, once you do this you’ll get an error that Microsoft.NETCore.App is broken and perhaps an error like this one:

> error NU1002: The dependency System.Runtime.Loader 4.0.0-rc2-24027 does not support framework .NETFramework,Version=v4.6.1.

The solution is to move the “Microsoft.NETCore.App” dependency out of “dependencies” and into a new “dependencies” section under the “netcoreapp1.0” key in “frameworks”. Here is a full, working project.json for an ASP.NET Core RC2 app that targets both netcoreapp1.0 and NET461:

`{   "userSecretsId": "aspnet-WebApplication8-6adc3073-3308-4ce9-a4f2-c0eef081e04a",

  "dependencies": {
    "Microsoft.ApplicationInsights.AspNetCore": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Authentication.Cookies": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Diagnostics": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Identity.EntityFrameworkCore": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Mvc": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Razor.Tools": {
      "version": "1.0.0-preview1-final",
      "type": "build"
    },
    "Microsoft.AspNetCore.Server.IISIntegration": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.Server.Kestrel": "1.0.0-rc2-final",
    "Microsoft.AspNetCore.StaticFiles": "1.0.0-rc2-final",
    "Microsoft.EntityFrameworkCore.SqlServer": "1.0.0-rc2-final",
    "Microsoft.EntityFrameworkCore.Tools": {
      "version": "1.0.0-preview1-final",
      "type": "build"
    },
    "Microsoft.Extensions.Configuration.EnvironmentVariables": "1.0.0-rc2-final",
    "Microsoft.Extensions.Configuration.Json": "1.0.0-rc2-final",
    "Microsoft.Extensions.Configuration.UserSecrets": "1.0.0-rc2-final",
    "Microsoft.Extensions.Logging": "1.0.0-rc2-final",
    "Microsoft.Extensions.Logging.Console": "1.0.0-rc2-final",
    "Microsoft.Extensions.Logging.Debug": "1.0.0-rc2-final",
    "Microsoft.VisualStudio.Web.BrowserLink.Loader": "14.0.0-rc2-final",
    "Microsoft.VisualStudio.Web.CodeGeneration.Tools": {
      "version": "1.0.0-preview1-final",
      "type": "build"
    },
    "Microsoft.VisualStudio.Web.CodeGenerators.Mvc": {
      "version": "1.0.0-preview1-final",
      "type": "build"
    }
  },

  "tools": {
    "Microsoft.AspNetCore.Razor.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": "portable-net45+win8+dnxcore50"
    },
    "Microsoft.AspNetCore.Server.IISIntegration.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": "portable-net45+win8+dnxcore50"
    },
    "Microsoft.EntityFrameworkCore.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": [
        "portable-net45+win8+dnxcore50",
        "portable-net45+win8"
      ]
    },
    "Microsoft.Extensions.SecretManager.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": "portable-net45+win8+dnxcore50"
    },
    "Microsoft.VisualStudio.Web.CodeGeneration.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": [
        "portable-net45+win8+dnxcore50",
        "portable-net45+win8"
      ]
    }
  },

  "frameworks": {
    "netcoreapp1.0": {
      "imports": [
        "dotnet5.6",
        "dnxcore50",
        "portable-net45+win8"
      ],
      "dependencies": {
        "Microsoft.NETCore.App": {
          "version": "1.0.0-rc2-3002702",
          "type": "platform"
        }
      }
    },
      "net461": { }
    },

  "buildOptions": {
    "emitEntryPoint": true,
    "preserveCompilationContext": true
  },

  "runtimeOptions": {
    "gcServer": true
  },

  "publishOptions": {
    "include": [
      "wwwroot",
      "Views",
      "appsettings.json",
      "web.config"
    ]
  },

  "scripts": {
    "prepublish": [ "npm install", "bower install", "gulp clean", "gulp min" ],
    "postpublish": [ "dotnet publish-iis --publish-folder %publish:OutputPath% --framework %publish:FullTargetFramework%" ]
  }
}`