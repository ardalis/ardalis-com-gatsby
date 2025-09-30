---
title: Ardalis Specification v9 Released
date: "2025-03-13T00:00:00.0000000"
description: A new major version of the Ardalis Specification library has been released.
featuredImage: /img/ardalis-specification-v9-release.png
---

A new major version of the Ardalis Specification library has been released. This library is used to create and compose specifications for querying data from repositories. It's a key part of the Ardalis Clean Architecture libraries and is used in many applications to help simplify querying logic and make it more testable. If your application suffers from LINQ pollution, with query logic spread through every part of it, this library may help.

Note that 99% of this effort was done by [Fati Iseni](https://github.com/fiseni), who has been doing a great job maintaining and improving this library. I'm grateful for his contributions and leadership on this project.

## What's New in v9

The v9 release of the Ardalis Specification library includes several new features and improvements. This [issue serves as the full release notes](https://github.com/ardalis/Specification/issues/427). Here are some of the highlights:

- Reduce memory footprint
- Update TFMs to latest (dropping net6, net7; adding net8, net9)
- Remove unused `IEntity` interface
- Make Take/Skip non-nullable (reduces memory)
- Remove internal state for Evaluator/Validator (reduces memory)
- Remove internal state for Query builder (reduces memory)
- Improve C# implementation of SQL `LIKE` operator
- Improve in-memory search
- Search validator refactored to zero allocations (reduces memory)
- Improve search EF evaluator (reduces memory)
- Refactor Include evaluator and add caching
- Reduce expression construct size (reduces memory)
- Remove obsolete APIs
- Add TagWith feature
- Add EF IgnoreAutoIncludes feature
- Fix EnableCache key generator to drop trailing hyphen
- Return rows affected from `Update` and `Delete` methods on sample repository implementation

## Breaking Changes

There are a number of small breaking changes in the list above. If you relied on obsolete methods or some of the removed types like `IEntity` you will need to make minor adjustments (and perhaps define your own `IEntity` interface). However for the most part, your existing Specification types will continue to work as they did before.

## How to Get It

You can get the latest version of the Ardalis Specification library from NuGet. The package is named `Ardalis.Specification` and you can install it using the following command:

```
dotnet add package Ardalis.Specification
```

## Learn More

You can see full examples that make use of specifications in the following open source projects:

- [eShopOnWeb](https://github.com/nimblepros/eshoponweb) (MS reference architecture)
- [CleanArchitecture](https://github.com/ardalis/CleanArchitecture) (see sample folder as well)

Be sure to give the package a star and follow it if you want additional updates. And if you have any issues or feature requests, please open an issue on the GitHub repository.

