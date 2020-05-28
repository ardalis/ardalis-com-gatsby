---
templateKey: blog-post
title: The Minimal ASPNET Core 1.1 App
path: blog-post
date: 2016-12-12T04:43:00.000Z
description: In a previous article, I described how to create the minimal
  ASP.NET Core 1.0 app. That is, what’s the smallest amount of code you could
  write to produce an ASP.NET Core application?
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
In a previous article, I described [how to create the minimal ASP.NET Core 1.0 app](http://ardalis.com/the-minimal-aspnet-core-app). That is, what’s the smallest amount of code you could write to produce an ASP.NET Core application?

In this article, I’ll demonstrate how to do the same for ASP.NET Core 1.1. The main difference is in the project file, which has moved from project.json to a .csproj format. If you’re just getting started with .NET Core, install the SDK and tools, first. You can use Visual Studio Code (or any text editor) for these steps. Once you have the SDK and command line tools installed, open a command prompt in an empty folder. Run the following commands:

`dotnet new`

This will create two files, Program.cs and \[foldername].csproj. Next, you need to add a package reference to the project file, to add the built-in ASP.NET Core web server, Kestrel, to the project. Open the .csproj file with Visual Studio Code (or another text editor). Add this code block under the PackageReference element that includes the “Microsoft.NETCore.App” package:

`<PackageReference Include="Microsoft.AspNetCore.Server.Kestrel">   <Version>1.1</Version>
</PackageReference>`

The complete project file after this change should look like this:

`<Project ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">   <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" />
  
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>netcoreapp1.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <Compile Include="**\*.cs" />
    <EmbeddedResource Include="**\*.resx" />
  </ItemGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.NETCore.App">
      <Version>1.0.1</Version>
    </PackageReference>
    <PackageReference Include="Microsoft.AspNetCore.Server.Kestrel">
      <Version>1.1</Version>
    </PackageReference>
    <PackageReference Include="Microsoft.NET.Sdk">
      <Version>1.0.0-alpha-20161104-2</Version>
      <PrivateAssets>All</PrivateAssets>
    </PackageReference>
  </ItemGroup>
  
  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" />
</Project>`

Now modify Program.cs to configure a web host, tell it to use Kestrel, and set up a single response to all requests (to return “Hi”):

`using Microsoft.AspNetCore.Hosting; `\
`using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;

class Program
{
    static void Main(string[] args)
    {
        new WebHostBuilder()
            .UseKestrel()
            .Configure(a => a.Run(c => c.Response.WriteAsync("Hi!")))
            .Build()
            .Run();
    }
}`

Return to your command prompt, and run these commands:

`dotnet restore 
dotnet run`

You should see output like this:



![](/img/minimal-aspnetcore11-program.png)

Open a browser and navigate to localhost:5900. You should see a simple response of “Hi”.