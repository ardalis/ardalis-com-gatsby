---
templateKey: blog-post
title: "Hello, MongoDB - Getting Started with Mongo and dotnet 8"
date: 2024-02-15
description: "Discover how to seamlessly integrate .NET Core applications with MongoDB using Docker. Learn to perform basic CRUD operations with MongoDB from within a .NET Core app, all through straightforward, easy-to-follow steps. Whether you're looking to enhance your current project or start a new one, this guide provides the essential knowledge to bridge .NET Core with MongoDB in a Dockerized environment."
path: blog-post
featuredpost: false
featuredimage: /img/hello-mongodb-getting-started-mongo-dotnet.png
tags:
- .NET Core
- MongoDB
- Docker
- Database Integration
- CRUD Operations
- Software Development
- Console Application
- C# Programming
- Docker Containers
- NoSQL Databases
- Software Architecture
- Backend Development
category:
  - Software Development
comments: true
share: true
---

# Integrating .NET Core with MongoDB in a Dockerized Environment

Hello, fellow developers! Whether you're building a new project or integrating into an existing one, this guide is your starting point for a "hello world" level application in the .NET 8 plus MongoDB stack. Let's get to it!

## Prerequisites

Before we begin, ensure you have the following installed on your machine:
- Docker
- .NET SDK (I'm using dotnet 8)

## Step 1: Dockerize MongoDB

First off, let's get MongoDB up and running inside a Docker container. Just run this command (assuming you have docker installed and running)

```bash
docker run --name mongodb -d -p 27017:27017 mongo
```

You should see output similar to this:

![docker run mongo console screenshot](/img/docker-run-mongo.png)

This command sets up MongoDB in a container, mapping the default MongoDB port to the same on your host, making it accessible to your application.

## Step 2: Scaffold a .NET Core Console Application

Now, let's create our .NET application:

```bash
dotnet new console -n HelloMongo
cd HelloMongo
```

Don't forget to add MongoDB's driver to your project:

```bash
dotnet add package MongoDB.Driver
```

## Step 3: The Application Code

Here's where the magic happens. Replace the `Program.cs` content with the following:

```csharp
// See https://aka.ms/new-console-template for more information
using MongoDB.Bson;
using MongoDB.Driver;

Console.WriteLine("Hello, World!");

var client = new MongoClient("mongodb://localhost:27017");
var database = client.GetDatabase("testdb");
var collection = database.GetCollection<BsonDocument>("testcollection");

// Clearing the collection (optional)
await collection.DeleteManyAsync(new BsonDocument());
Console.WriteLine("Collection cleared.");

// Inserting a document
var document = new BsonDocument
            {
                { "name", "Ardalis" },
                { "Company", "NimblePros - Force Multipliers for Dev Teams" },
                { "MvpAwardCount", 20 },
                { "city", "Kent, Ohio" }
            };
await collection.InsertOneAsync(document);
Console.WriteLine("Document inserted.");

// Reading documents
var documents = await collection.Find(new BsonDocument()).ToListAsync();
foreach (var doc in documents)
{
    Console.WriteLine(doc.ToString());
}
```

This snippet demonstrates connecting to MongoDB, inserting, and then reading documents back. Simple, yet powerful! I also included the code for clearing out the collection, so that you can run this multiple times and get the same result each time.

## Step 4: Run Your Application

To see your application in action, run:

```bash
dotnet run
```

Voilà! You've just integrated a .NET Core application with MongoDB, all running smoothly with Docker. You should see something like this:

![hello mongo console output](/img/hello-mongo.png)

## Step 5: Cleaning Up

After you're done, don't forget to clean up your Docker environment:

```bash
docker stop mongodb
docker rm mongodb
```

And that's it! You've now got a solid foundation for integrating .NET Core applications with MongoDB.

## Get the Code

You can grab the latest version of the code directly from its [GitHub repo](https://github.com/ardalis/MongoDbDotNetHelloWorld).

## References

- [.NET SDK](https://dotnet.microsoft.com/download)
- [MongoDB Docker Hub Page](https://hub.docker.com/_/mongo)
- [MongoDB.Driver NuGet Package](https://www.nuget.org/packages/MongoDB.Driver/)

**Keep Improving!**

P.S. If you're looking to improve as a software developer, you may wish to join thousands of other developers who get my newsletter each week. [Sign up here](/tips)!
