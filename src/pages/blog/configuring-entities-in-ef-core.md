---
templateKey: blog-post
title: Configuring Entities in EF Core
date: 2019-07-23
path: /configuring-entities-in-ef-core
featuredpost: false
featuredimage: /img/configuring-entities-ef-core.png
tags:
  - ef core 
  - nuget
category:
  - Software Development
comments: true
share: true
---

I've worked with many clients who are upgrading from EF 6 to EF Core. Many of them are coming from EDMX files, and are wondering what the best approach is in EF Core to configure entities based on the database (or vice versa). Regardless of whether your C# entities are written first or the database is, somewhere you need to have mapping information to let Entity Framework know how it should store and retrieve data representing them.

## Custom Attributes

You can use attributes on your entities, but I don't recommend it. I like to keep my entities as clean as possible, and especially to avoid having any dependencies on implementation details like databases or ORM tools. I also generally structure my .NET Core solutions using [Clean Architecture](https://github.com/ardalis/CleanArchitecture), and any attributes that would be EF-specific would end up breaking my rule of not depending on infrastructure concerns from the Core project (where the entities reside). If you really want to go this route, learn more [here](https://docs.microsoft.com/en-us/ef/core/modeling/relational/columns).

## OnModelCreating

The typical place where most ASP.NET Core developers map their entities to their database is in their DbContext, in the OnModelCreating method. It looks something like this:

protected override void OnModelCreating(ModelBuilder modelBuilder)         {             
    modelBuilder.Entity<Blog>()
        .Property(b => b.Url)
        .IsRequired();
} 

This works fine, but it can grow quite lengthy, as every entity must include any variations from conventions here (and some teams explicitly specify everything, even if EF Core would assume it by convention).

What do you do when this method gets to be 100+ lines long? Your first [refactoring](https://www.pluralsight.com/courses/refactoring-fundamentals) could be to simply extract method and create a bunch of private helper methods:

protected override void OnModelCreating(ModelBuilder modelBuilder)         {
    ConfigureBlog(modelBuilder);
    ConfigurePost(modelBuilder);
    ConfigureTag(modelBuilder);
}

private void ConfigureBlog(ModelBuilder modelBuilder) { ... }
// etc.  

Again, this helps, but now your DbContext is still going to be quite long. Fortunately, EF Core 2+ offers a solution to this: IEntityTypeConfiguration<TEntity>.

## Configuration Files

With separate configuration files, you can create a separate file per entity whose only job is to configure that entity's data mapping. This follows the [Single Responsibility Principle from SOLID](https://www.pluralsight.com/courses/csharp-solid-principles) and further cleans up your DbContext (which also starts to better follow SRP). Basically, your helper methods become small single-purpose classes, which you can put into a folder named Config or something similar in your data access folder.

public class BlogConfiguration : IEntityTypeConfiguration<Blog>
{
    public void Configure(EntityTypeBuilder builder)
    {
        builder.Property(b => b.Url)
            .IsRequired();
    }
}

Some folks will dislike the fact that now there are a bunch of files but realistically you don't end up looking at more than one of them at a time, and you rarely touch them at all once they're set up the first time. To use them, you do still need to call ApplyConfiguration, though:

protected override void OnModelCreating(ModelBuilder modelBuilder)         {
     modelBuilder.ApplyConfiguration(new BlogConfiguration());
     modelBuilder.ApplyConfiguration(new PostConfiguration());
     modelBuilder.ApplyConfiguration(new TagConfiguration());
}

We can fix this, though, with a little reflection and the help of an extension method from the [Ardalis.EFCore.Extensions package](https://www.nuget.org/packages/Ardalis.EFCore.Extensions/).

## Configuration Files with AutoDiscovery

You probably have more than 3 entities in your solution, so that little code snippet above showing calls to ApplyConfiguration is probably dozens of lines long in your actual, real application. And sometimes when you add a new configuration, you may forget to add it to that monstrous list, resulting in issues with EF Core not behaving as you'd expect because you haven't told it how. Trust me, these things get annoying - ask me how I know...

You can fix this by just grabbing all of the configuration files in the current assembly (or whichever one they're in) and calling ApplyConfiguration for each one. If you happen to have more than one DbContext, you can also put the files in separate folders and namespaces and then pass the appropriate namespace in as a filter.

When using this extension method, your OnModelCreating method now just looks like this:

using Ardalis.EFCore.Extensions;
using Microsoft.EntityFrameworkCore

namespace YourNamespace
{
    public class AppDbContext : DbContext
    {
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            builder.ApplyAllConfigurationsFromCurrentAssembly();
        }
    }
}

The extensions package is [open source and available here](https://github.com/ardalis/EFCore.Extensions). The extension method is based on [this StackOverflow answer](https://stackoverflow.com/questions/47013752/bulk-register-ientitytypeconfiguration-entity-framework-core/47263024#47263024), though I've been using a similar one for a while in a few places (mine didn't have the namespace filter, which I thought was a nice addition). Feel free to add issues or PRs if you find anything amiss in your project.

If you want to see these in action in a reference application, have a look at the [eShopOnWeb app](https://github.com/dotnet-architecture/eShopOnWeb) I help maintain for Microsoft. It shows how to build a real application using .NET Core.

**Update:** [Alex Will](https://twitter.com/alwill_dotnet) pointed out to me that there's a built-in extension that does most of this already (not the namespace filter) in EF Core 2.2. It looks like this:

modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly);

My version's slightly shorter, though :). Alex [has a YouTube video showing how to set it all up that you should check out, here](https://www.youtube.com/watch?v=M0_hEnDXSo4).
