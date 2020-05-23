---
templateKey: blog-post
title: Upgrading from ASPNET Core RC1 to RC2 Guide
path: blog-post
date: 2016-05-15T11:34:00.000Z
description: There are a number of breaking changes between ASP.NET Core RC1 and
  RC2. If you have existing apps targeting RC1, here are some things you should
  expect to change in order to upgrade the apps to RC2.
featuredpost: false
featuredimage: /img/aspnetcore-1.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
There are a number of [breaking changes](https://github.com/aspnet/announcements/issues) between ASP.NET Core RC1 and RC2. If you have existing apps targeting RC1, here are some things you should expect to change in order to upgrade the apps to RC2. Consider this an “unofficial” guide.

**Update**: The[official docs have a bunch of great content on this as well](https://docs.asp.net/en/latest/migration/rc1-to-rc2.html) – this was just my own personal notes that worked for my projects.

**NuGet Sources**

Make sure you’re configured to use the correct NuGet feed(s) for the RC2 sources. Once RC2 officially ships, the official, standard NuGet source should work, but until then you may need to use manually specify the correct source using the nuget command line (nuget sources) or a NuGet.config file. ~~As of now you should be using:~~

* ~~<https://www.myget.org/F/aspnetrc2/api/v3/index.json>~~

**Update**: The RC2 packages are all on nuget.org now, so you can use your usual nuget.org package source.

You can browse to that link to see the available packages and their respective versions. You can specify this source in Nuget.Config file like this one (note the other two sources shown are commented out):

```
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
    <!--<add key=".NET Core" value="https://dotnet.myget.org/F/dotnet-core/api/v3/index.json" protocolVersion="3" />-->
    <!--<add key="aspnetrc2" value="https://www.myget.org/F/aspnetrc2/api/v3/index.json" protocolVersion="3" />-->
  </packageSources>
</configuration
```

**dotnet CLI**

Make sure you have installed the latest dotnet command line interface (CLI), using the .NET Core SDK. You can find the [dotnet CLI installer appropriate to your OS here](https://github.com/dotnet/cli).

**project.json**

The project.json file structure has changed in a number of subtle ways. You’ll of course need to change the versions of all of the packages you’re using, and change the references to any that use “Microsoft.AspNet” to be “Microsoft.AspNetCore” (see below for more of this). The current rc2 version that is working for me is “1.0.0-rc2-20801” but I expect this number will change to another string upon release (e.g. “1.0.0-rc2” or “1.0.0-rc2-final”).

Note: commands are gone.

Here is an example of a working project.json file (from the [dependency injection docs](https://docs.asp.net/en/latest/fundamentals/dependency-injection.html)):

```
{
  "version": "1.0.0-*",
 
  "dependencies": {
    "Microsoft.NETCore.App": {
      "version": "1.0.0-rc2-3002702",
      "type": "platform"
    },
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
    "Microsoft.EntityFrameworkCore.InMemory": "1.0.0-rc2-final",
    "Microsoft.EntityFrameworkCore.Tools": {
      "version": "1.0.0-preview1-final",
      "type": "build"
    },
    "Microsoft.Extensions.CodeGeneration.Tools": {
      "version": "1.0.0-preview1-final",
      "type": "build"
    },
    "Microsoft.Extensions.CodeGenerators.Mvc":  {
      "version": "1.0.0-preview1-final",
      "type": "build"
    },
    "Microsoft.Extensions.Configuration.EnvironmentVariables": "1.0.0-rc2-final",
    "Microsoft.Extensions.Configuration.Json": "1.0.0-rc2-final",
    "Microsoft.Extensions.Configuration.UserSecrets": "1.0.0-rc2-final",
    "Microsoft.Extensions.Logging": "1.0.0-rc2-final",
    "Microsoft.Extensions.Logging.Console": "1.0.0-rc2-final",
    "Microsoft.Extensions.Logging.Debug": "1.0.0-rc2-final",
    "Microsoft.VisualStudio.Web.BrowserLink.Loader": "14.0.0-rc2-final"
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
    "Microsoft.Extensions.CodeGeneration.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": [
        "portable-net45+win8+dnxcore50",
        "portable-net45+win8"
      ]
    },
    "Microsoft.Extensions.SecretManager.Tools": {
      "version": "1.0.0-preview1-final",
      "imports": "portable-net45+win8+dnxcore50"
    }
  },
"frameworks": {
    "netcoreapp1.0": {
      "imports": [
        "dotnet5.6",
        "dnxcore50",
        "portable-net45+win8"
      ]
    }
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
}
```

**Namespaces**

Do a search for “Microsoft.AspNet.” in your project to find all of the namespaces that use this string, and replace them with “Microsoft.AspNetCore.” This will fix the bulk of the compile errors you will encounter immediately. Don’t forget to look in your views, including _ViewImports.cshtml, for additional references to namespaces that need updated that the compiler won’t catch (you’ll encounter these problems at runtime).

“Microsoft.Framework” has been renamed to “Microsoft.Extensions”. This affects packages and namespaces like DependencyInjection and Logging.

“Microsoft.AspNet.Identity.EntityFramework” is now “Microsoft.AspNetCore.Identity.EntityFrameworkCore”.

**global.json**

You can remove the “sdk” section. Typically it will just list the projects (e.g. “projects” : \[“src”,”test”]).

**Startup.cs**

Remove references to UseIISPlatformHandler.

Remove the public static void main entry point. You’ll add a Program.cs file (see below).

Remove minimumLevel property from loggerFactory (it’s specified per logger type now), if set.

Change any reference to LogLevel.Verbose (to Information or Debug).

If building configuration, you can use AddJsonFile(“file.json”,optional: true, reloadOnChange: true) instead of calling .ReloadOnChanged() off of your call to builder.Build().

Access to the root of the application is now through IHostingEnvironment.ContentRootPath.

If configuring Entity Framework, change call in ConfigureServices from AddEntityFramework to AddDbContext.

If using services.Configure<T>(Configuration.GetSection(“sectionName”) you need to reference Microsoft.Extensions.Options.ConfigurationExtensions and add a `using Microsoft.Extensions.DependencyInjection;` if you aren’t already doing so.

Below is an example Startup.cs:

```
using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace DependencyInjectionSample
{
    public class Startup
    {
        public Startup(IHostingEnvironment env)
        {
            // Setup configuration sources.

            var builder = new ConfigurationBuilder()
                .SetBasePath(env.ContentRootPath)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true);

            if (env.IsDevelopment())
            {
                builder.AddUserSecrets();
            }
            builder.AddEnvironmentVariables();
            Configuration = builder.Build();
        }

        public IConfigurationRoot Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            // Add Entity Framework services to the services container.
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseInMemoryDatabase()
            );

            // Add Identity services to the services container.
            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();

            // Add MVC services to the services container.
            services.AddMvc();

            // Register application services.
            services.AddTransient<IEmailSender, AuthMessageSender>();
            services.AddTransient<ISmsSender, AuthMessageSender>();
        }

        // Configure is called after ConfigureServices is called.
        public void Configure(IApplicationBuilder app,
            IHostingEnvironment env,
            ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole();
            loggerFactory.AddDebug();

            // Configure the HTTP request pipeline.

            // Add the following to the request pipeline only in development environment.
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
                app.UseBrowserLink();
            }
            else
            {
                // Add Error handling middleware which catches all application specific errors and
                // sends the request to the following path or controller action.
                app.UseExceptionHandler("/Home/Error");
            }

            // Add static files to the request pipeline.
            app.UseStaticFiles();

            // Add cookie-based authentication to the request pipeline.
            app.UseIdentity();

            // Add MVC to the request pipeline.
            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
```

**Entity Framework**

If you’re using Entity Framework, you’ll need to update your DbContext class to accept an options parameter in its constructor and pass it to its base, like so:

```
public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
  : base(options)
  {
  }
```

Call AddDbContext in Startup as mentioned above.

Change namespace from “Microsoft.Data.Entity” to “Microsoft.EntityFrameworkCore”.

Migrations will need to be updated. For instance, “.HasAnnotation(“Relational:Name”, “name”)” is now simply “.HasName(“name”)”. Likewise, HasAnnotation(“Relational:TableName”, tableName) should be updated to ToTable(tableName).

References to “Microsoft.AspNet.Identity.EntityFramework” will need to be changed to “Microsoft.AspNetCore.Identity.EntityFrameworkCore”.

Table names will now use the DbSet name, not the Type name, so you may run into issues especially around pluralization. See [here for resolutions](http://stackoverflow.com/questions/37493095/entity-framework-core-rc2-table-name-pluralization).

**Program.cs**

You should add a Program.cs file to configure your web app. Here’s an example:

```
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
 
namespace MvcMovie
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var host = new WebHostBuilder()
                .UseKestrel()
                .UseContentRoot(Directory.GetCurrentDirectory())
                .UseIISIntegration()
                .UseStartup<Startup>()
                .Build();
 
            host.Run();
        }
    }
}
```

**Razor**

Change validation summary tag helpers from asp-validation-summary=”ValidationSummary.All” to asp-validation-summary=”All”. Likewise change “ValidationSummary.ModelOnly” to “ModelOnly”.

Add to form tags asp-route-returnurl=”@ViewData\[“ReturnUrl”]” if you wish to use this functionality (and be sure to set this in ViewData).

Don’t forget to change _ViewImports.cshtml. Its reference to TagHelpers should be\
@addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers

(and change the reference to Identity to use AspNetCore as well)

Properties – launchSettings.json

You need to change the environment variable name used to set the environment to Development in launchSettings.json. Here’s a sample of the file:

```
"iisSettings": {
    "windowsAuthentication": false,
    "anonymousAuthentication": true,
    "iisExpress": {
      "applicationUrl": "http://localhost:3240/",
      "sslPort": 0
    }
  },
  "profiles": {
    "IIS Express": {
      "commandName": "IISExpress",
      "launchBrowser": true,
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    },
    "WebApplication1": {
      "commandName": "Project",
      "launchBrowser": true,
      "launchUrl": "http://localhost:5000",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
```

**API Changes**

There are many small API changes, as well. Please list those that you find in the comments and I will update this list. Here are the ones I’ve encountered myself thus far. You can find the team’s summary of changes listed in the [issues in the Announcements repository on GitHub](https://github.com/aspnet/announcements/issues).

* IFilterFactory: now has a boolean IsReusable property that must be implemented.
* \[FromServices]: this attribute is no longer available; use constructor injection instead ([learn more](https://docs.asp.net/en/latest/fundamentals/dependency-injection.html))
* IActionResult HttpNotFound: this has been renamed NotFound
* IActionResult HttpBadRequest: this has been renamed BadRequest
* ASPNET_ENV environment variable is now ASPNETCORE_ENVIRONMENT
* Microsoft.Extensions.WebEncoders namespace is now System.Text.Encodings.Web (for HtmlEncoder)

**Training**

If you or your team need training on ASP.NET Core, I have a [virtual 2-day ASP.NET Core class scheduled for June](http://ardalis.com/asp-net-core-training-june-2016), and I’m available to schedule a custom class for your team, as well.