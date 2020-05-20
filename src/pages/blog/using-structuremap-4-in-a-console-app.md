---
templateKey: blog-post
title: Using StructureMap 4 in a Console App
path: blog-post
date: 2016-02-20T13:09:00.000Z
description: If you’re using an older version of StructureMap or want more of an
  introduction, please read A Gentle Introduction to StructureMap, which
  includes a console application for StructureMap 2.x.
featuredpost: false
featuredimage: /img/console-application.jpg
tags:
  - .net
  - console app
  - dependency injection
  - structuremap
category:
  - Software Development
comments: true
share: true
---
If you’re using an older version of StructureMap or want more of an introduction, please read [A Gentle Introduction to StructureMap](https://ardalis.com/a-gentle-introduction-to-structuremap), which includes a console application for StructureMap 2.x.

StructureMap 4 is currently the latest version (v4.0.1.318) and is what I’m using for this example. The old ObjectFactory type is no more; instead you create instances of Container as needed. For a simple console application, you should only need one such instance. Also, the preferred means of wiring up dependencies within a container is to use one or more Registry classes. My preferred approach is to use a single Registry class per project in my solution. For a single-project console app, that means a single Registry class. This also has the advantage of keeping the Main() method clean without the need for helper methods (e.g. InitIoC()).

Here is the complete example showing how I would configure a simple Console Application to use dependency injection with StructureMap 4.

```
using System;
using StructureMap;
using StructureMap.Graph;
 
namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            var container = Container.For<ConsoleRegistry>();
 
            var app = container.GetInstance<Application>();
            app.Run();
            Console.ReadLine();
        }
    }
 
    public class ConsoleRegistry : Registry
    {
        public ConsoleRegistry()
        {
            Scan(scan =>
            {
                scan.TheCallingAssembly();
                scan.WithDefaultConventions();
            });
            // requires explicit registration; doesn't follow convention
            For<ILog>().Use<ConsoleLogger>();
        }
    }
 
    public interface IWriter
    {
        void WriteLine(string output);
    }
 
    // will be automatically wired up by default convention
    public class Writer : IWriter
    {
        public void WriteLine(string output)
        {
            Console.WriteLine(output);
        }
    }
 
    public interface ILog
    {
        void Info(string message);
    }
 
    public class ConsoleLogger : ILog
    {
        public void Info(string message)
        {
            var color = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine(message);
            Console.ForegroundColor = color;
        }
    }
 
    public class Application
    {
        private readonly IWriter _writer;
        private readonly ILog _logger;
 
        public Application(IWriter writer, ILog logger)
        {
            _writer = writer;
            _logger = logger;
        }
 
        public void Run()
        {
            _logger.Info(nameof(Application) + " started.");
 
            _writer.WriteLine("Hello World!");
 
            _logger.Info(nameof(Application) + " finished.");
        }
    }
}
```

I like to use the WithDefaultConventions() extension for StructureMap, because it greatly reduces how many lines of registration code you need to write. With this in place, any interface in the scanned assembly will automatically use an instance of the type with the same name, minus the “I” prefix, if it exists. Thus, if you have an interface IFoo and a class Foo, there’s no need to explicitly register them – StructureMap will use Foo wherever an IFoo is needed automatically. In the example above, I’m using this to wire up Writer to IWriter. However, since I didn’t follow this convention for my ILog implementation (I named the implementation class ConsoleLogger), I have to explicitly tell StructureMap how to resolve the ILog type. This is done on line 29:

`// requires explicit registration; doesn't follow convention `\
`For<ILog>().Use<ConsoleLogger>();`

If you’re just getting started with [dependency injection](http://deviq.com/dependency-injection/) or the [Dependency Inversion Principle](http://deviq.com/dependency-inversion-principle/), this is a good way to start learning how it works. Just copy the above code into a new console application’s Program.cs file and try changing the types. Add an interface of your own, perhaps to change the “Hello World” line to a custom greeting. Maybe you can make it say “Good morning” or “Good afternoon” as appropriate. The nice thing about this style of programming is that it makes testing very easy. Your implementation of an IGreeting interface shouldn’t have any dependencies, so if you want to test that it produces the right greeting at the right time of day, you should be able to do so without being blocked.

**Next**: [Configure NLog Using StructureMap](http://ardalis.com/configure-nlog-with-structuremap) (for some more advanced StructureMap usage)