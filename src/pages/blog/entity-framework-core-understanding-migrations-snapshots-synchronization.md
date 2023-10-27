---
templateKey: blog-post
title: "Understanding Migrations, Snapshots, and Synchronization in Entity Framework Core"
date: 2023-10-27T08:34:00.000Z
description: "This article delves into how Entity Framework Core keeps your database schema synchronized with your data model using migration files, snapshots, and a special database table. Learn the differences between .designer.cs files and ModelSnapshot.cs and how they complement each other in EF Core."
path: blog-post
featuredpost: false
featuredimage: /img/entity-framework-core-understanding-migrations-snapshots-synchronization.png
tags:
  - Entity Framework Core
  - EF Core
  - Database Migrations
  - .NET
  - SQL Database
  - Model Snapshot
  - Database Synchronization
  - Database Schema
  - SQL Server
category:
  - Software Development
comments: true
share: true
---

# Entity Framework Core: Understanding Migrations, Snapshots, and Synchronization

Entity Framework Core (EF Core) is a powerful tool for managing database schema migrations and synchronization in .NET projects. This article aims to explore the core components that EF Core uses to maintain this sync: migration files, model snapshots, and a special database table. We'll also clarify the roles of `.designer.cs` and `ModelSnapshot.cs` files in migrations.

## Models

One point of confusion I see a lot when discussing EF Core migrations is with "the model." The model or "the current model" being referenced varies quite a bit with context. In one scenario, the "current model" is your C# code in its current most-recently-saved state. If you just added a property called `Name` to an entity class, you're thinking that is your current model. But another *version* of the model is in a snapshot file, and that one is only updated when you create a migration. And another *version* of the model is in the/a database. And *that* one is only updated when you do a database update or deployment. So, keep in mind as you continue reading that there are always several different versions of your model that are in various states, and ultimately should be synchronized by the migration process.

## Migration Files

Migration files are C# classes auto-generated when you create a new migration. These files include two primary methods: `Up()` and `Down()`.

- **`Up()` Method**: Describes the changes to be applied to the database schema.
- **`Down()` Method**: Reverts the changes that were applied by `Up()`.

You can apply these migrations to update your database schema using the `dotnet ef database update` command.

## Model Snapshot

A snapshot file represents the state of your data model when a migration is added. This snapshot is stored in a C# file typically named `YourDbContextModelSnapshot.cs` within your `Migrations` folder. The file provides a detailed, static image of your model's mapping to the database schema. EF Core uses this snapshot to determine what changes have been made to the model since the last migration, allowing new migrations to be generated accurately.

## EF Database Table

EF Core uses a special table called `__EFMigrationsHistory` to keep track of which migrations have been applied to the database. Each row in this table corresponds to a migration that has been applied, with metadata about that migration. EF Core consults this table before applying new migrations to figure out which migrations need to be executed.

This table doesn't store any snapshots itself. It only stores the names of the migrations that have been applied (and those migrations will have state information in them, as we'll see below).

## Designer.cs vs ModelSnapshot.cs

### Designer.cs File

Each migration comes with an auto-generated `.designer.cs` file. This file contains a snapshot of your model as it should look *after* that specific migration's `Up()` method has been applied. It acts as metadata for the migration, providing an image of the expected state of your model following the application of the migration.

## Model Snapshot

The `ModelSnapshot.cs` file is stored within your `Migrations` folder and represents the latest state of your model *after* the most recent migration has been applied. This snapshot serves as a baseline for generating new migrations, allowing EF Core to determine what changes have been made to the model since the last migration, thereby enabling accurate new migrations to be generated.

### Why Both?

1. **Immutability of Past Migrations**: The `.designer.cs` files allow you to keep a history of your model's state at each point when a migration was added. This is useful for rolling back changes.
2. **Ease of Comparison for New Migrations**: The `ModelSnapshot.cs` file acts as a single point of reference for the latest state of your model.
3. **Version Control**: Having both types of files is beneficial in a team environment where multiple developers could be generating migrations.

## Putting It All Together

The diagram below shows the whole process of updating the model in your C# code and then using EF Core migrations to ultimately publish the changes to the database.

~[ef core migrations sequence diagram](/img/ef-core-migrations-sequence.png)

## Conclusion

The `.designer.cs` file serves as an immutable record of the model at the time of a specific migration, while the `ModelSnapshot.cs` file acts as the current state of the model for generating new migrations. Together, they provide a robust mechanism for managing database schema changes in EF Core.

## References

- [EF Core Migrations Overview - Microsoft Docs](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/)
- [How EF Core Works Under the Hood - EntityFrameworkTutorial](https://www.entityframeworktutorial.net/efcore/entity-framework-core.aspx)
- [Database Migrations - Learn Entity Framework Core](https://www.learnentityframeworkcore.com/migrations)

If you're looking for more tips like this, [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
