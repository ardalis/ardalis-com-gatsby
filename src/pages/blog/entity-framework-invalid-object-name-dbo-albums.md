---
templateKey: blog-post
title: Entity Framework Invalid Object Name dbo.Albums
path: blog-post
date: 2011-01-30T10:58:00.000Z
description: "Continuing in working with the MVC Music Store sample application,
  the next thing I ran into after [installing the SQL database by hand], was an
  error on the home page:"
featuredpost: false
featuredimage: /img/music-store.jpg
tags:
  - entity framework
  - error
  - troubleshooting
category:
  - Software Development
comments: true
share: true
---
Continuing in working with the [MVC Music Store sample application](http://mvcmusicstore.codeplex.com/), the next thing I ran into after [installing the SQL database by hand](http://www.codeplex.com/Project/Download/FileDownload.aspx?ProjectName=mvcmusicstore&DownloadId=147007), was an error on the home page saying:

> #### *Invalid object name ‘dbo.Albums’.*
>
> **Description:**An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.\
> **Exception Details:**System.Data.SqlClient.SqlException: Invalid object name ‘dbo.Albums’.\
> **Source Error:**

```
// the albums with the highest count
return storeDB.Album
    .OrderByDescending(a =&gt; a.OrderDetails.Count())
    .Take(count)</font>
```

**Source File:**C:DevScratchMvcMusicStore-v2.0MvcMusicStore-CompletedMvcMusicStoreControllersHomeController.cs**Line:**28

Looking at my database, it looks like this:

![](/img/music-store.png)

Obviously, it should be looking for a table called dbo.Album. This issue is already listed in the [CodePlex discussion for this project](http://mvcmusicstore.codeplex.com/Thread/View.aspx?ThreadId=241884), with the solution described in a forum post on [using EF Code First to change the default plural table name to that of an entity name which is singular](http://social.msdn.microsoft.com/Forums/en-ie/adonetefx/thread/719f3e4d-073b-49fe-9968-945acde27bb7). It turns out the solution is pretty simple, although unfortunately you can’t just right-click and edit the properties of some dbContext file in your solution – you have to write a bit of code.

Specifically in this example, you need to go to your MusicStoreEntities file (the class with the same name inherits from DbContext) and add an override of the OnModelCreating() method. The full class with using statements is shown here:

```
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using System.Data.Entity.ModelConfiguration.Conventions.Edm.Db;

namespace MvcMusicStore.Models;
{
    public class MusicStoreEntities : DbContext
    {
        DbSet<Album> Albums { get; set;}
        DbSet<Genre> Genres { get; set;}
        DbSet<Artist> Artists { get; set;}
        DbSet<Cart> Carts { get; set;}
        DbSet<Order> Orders { get; set;}
        DbSet<OrderDetail> OrderDetails { get; set;}

        protected override OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }
    }
}
```

And with that, the application runs:

![](/img/music-store-1.png)