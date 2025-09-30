﻿---
title: Working with Lazy Loading in Entity Framework Code First
date: "2011-10-02T07:38:00.0000000-04:00"
description: Entity Framework 4 has Lazy Loading built-in and enabled by
featuredImage: /img/computer-2157100_1280.jpg
---

Entity Framework 4 has [Lazy Loading](http://martinfowler.com/eaaCatalog/lazyLoad.html) built-in and enabled by default. Here's a quick bit of code to show you how to work with this feature. To get started with this, simply create a new Console Application and in nuget (Package Manager Console), run this command:

**install-package EntityFramework.Sample**

This will install a simple blog post example. Copy and paste the following into your Program.cs file (replace everything):

```csharp
using System.Collections.Generic;
using System.Linq;
using System.Text;
```

I have three test cases shown here. If you run the program (after adding a post using the commented add a post code) you should see this output:

By default, Entity Framework 4 uses Lazy Loading. You can disable it with this code:

`context.Configuration.LazyLoadingEnabled = false;`

Once this is done, dependent collections like the Comments property of a Post in our example will be null if they are not specifically included. If you know you need to include a dependent collection or property, you can do so with the.Include() method when you reference the DbSet, like so:

`foreach (var post in context.Posts.Include("Comments"))`

With Lazy Loading enabled (again, the default case), there is no need to specify the Include if you're OK with the fact that in this example 2 calls will be made to the database:

**Call One (List Posts – click to enlarge)**

**Call Two (List Comments for single post)**

Now, let's say you want to [disable lazy loading by default](http://stackoverflow.com/questions/2967214/disable-lazy-loading-by-default-in-entity-framework-4) (i.e. you don't want to have to remember to set the property every time you instantiate a context). This is quite simple if you're using EF Code First and you have a DbContext like the BlogContext in this sample. Simply add a constructor and in the constructor disable Lazy Loading, like so:

```csharp
public BlogContext(): base()
{
 this.Configuration.LazyLoadingEnabled = false;
}
```

That's it! Now you know how to work with Lazy Loading in Entity Framework 4.

