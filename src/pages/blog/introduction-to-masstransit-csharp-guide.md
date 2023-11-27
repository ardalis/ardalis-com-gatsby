---
templateKey: blog-post
title: "Introduction to MassTransit: A Guide to Streamlined Messaging in C#"
date: 2023-09-28
description: "Explore how to simplify message-based architecture in C# applications using MassTransit. This comprehensive guide introduces MassTransit's key features, shows you how to set up a service bus, and integrates with RabbitMQ. Ideal for developers looking to build scalable and robust distributed systems."
path: blog-post
featuredpost: false
featuredimage: /img/introduction-to-masstransit-csharp-guide.png
tags:
  - MassTransit
  - Messaging
  - C#
  - CSharp
  - Service Bus
  - RabbitMQ
category:
  - Software Development
comments: true
share: true
---

If you're interested in building distributed, scalable, and robust applications in C#, you may have heard of MassTransit. This open-source messaging framework simplifies working with message brokers like RabbitMQ and Azure Service Bus, allowing you to focus more on business logic and less on infrastructure concerns.

## What Is MassTransit?

MassTransit is a free, open-source distributed application framework for .NET. It's a service bus for sending messages between different parts of your application, or even across different applications. With MassTransit, you can implement various messaging patterns such as publish/subscribe, request/response, and more, using a consistent and easy-to-understand API.

## Why Use MassTransit?

1. **Simplicity**: The framework abstracts away much of the boilerplate code required when dealing with message brokers directly.
2. **Extensibility**: Easily extend MassTransit by adding middleware components or integrating it with dependency injection frameworks.
3. **Asynchronous Messaging**: Embrace async programming with MassTransit’s native support for asynchronous messaging.

It can also let you work with low level messaging tools like RabbitMQ with a LOT less code, as you'll see in a moment.

## Getting Started with MassTransit in C#

To kick things off, let's install the MassTransit NuGet package. We'll use the RabbitMQ version for this example.

```csharp
Install-Package MassTransit.RabbitMQ
```

### Basic Setup

Here's a basic example demonstrating how to set up a MassTransit service bus and a consumer, using RabbitMQ for the transport layer.

```csharp
using MassTransit;
using MassTransitTest;

Console.WriteLine("Hello, World!");
IBusControl busControl = null;
try
{
    busControl = Bus.Factory.CreateUsingRabbitMq(cfg =>
    {
        cfg.Host("localhost", "/", h =>
        {
            h.Username("guest");
            h.Password("guest");
        });

        cfg.ReceiveEndpoint("my_queue", e =>
        {
            e.Consumer<MyConsumer>();
        });
    });

    busControl.Start(); // This is non-blocking
    Console.WriteLine("Press any key to exit");
}
catch (Exception ex)
{
    Console.WriteLine($"An error occurred: {ex.Message}");
}

Console.ReadKey();

if (busControl != null)
{
    busControl.Stop();
}
```

```csharp
using MassTransit;
namespace MassTransitTest;

public class MyConsumer : IConsumer<MyMessage>
{
    public async Task Consume(ConsumeContext<MyMessage> context)
    {
        Console.WriteLine($"Received: {context.Message.Text}");
    }
}
```

```csharp
namespace MassTransitTest;

public class MyMessage
{
    public string Text { get; set; }
}
```

That's all the code you need for a console app that will act as a consumer. Next you'll need something that sends messages.

### Sending Messages

Sending messages is just as easy. The following files demonstrate how to set up a console app that sends messages continuously, once per second.

```csharp
using MassTransit;
using MassTransitTest;

Console.WriteLine("Sender!");
var busControl = Bus.Factory.CreateUsingRabbitMq(cfg =>
{
    cfg.Host("localhost", "/", h =>
    {
        h.Username("guest");
        h.Password("guest");
    });
});

var sendToUri = new Uri("rabbitmq://localhost/my_queue");
var endpoint = await busControl.GetSendEndpoint(sendToUri);

await busControl.StartAsync(); // This is non-blocking

int messageCount = 0;

var cts = new CancellationTokenSource();

Console.WriteLine("Sending messages. Press any key to stop...");

while (!cts.Token.IsCancellationRequested)
{
    messageCount++;
    await endpoint.Send(new MyMessage { Text = $"Message {messageCount}" });
    Console.WriteLine($"Sent: Message {messageCount}");
    await Task.Delay(TimeSpan.FromSeconds(1), cts.Token);
}

await busControl.StopAsync();
```

It will need access to the message type as well, which can come from a common project both apps reference or can just be duplicated:

```csharp
namespace MassTransitTest;
public class MyMessage
{
    public string Text { get; set; }
}
```

Now if you run both apps, one should start sending messages while the other consumes them. Assuming you have RabbitMQ set up, that is. The next section shows how to get that going quickly using docker.

# Running RabbitMQ Using Docker

Before you can dive into MassTransit, you'll need a message broker. RabbitMQ is one of the most popular choices, and fortunately, it's easy to set up using Docker. So let's go ahead and run RabbitMQ.

## Prerequisites

- Docker installed on your machine

## Run RabbitMQ

You can pull and run the RabbitMQ Docker image using the following command:

```bash
docker run -d --hostname my-rabbit --name rabbitmq-server -p 5672:5672 -p 15672:15672 rabbitmq:3-management
```

This command will:

- Run RabbitMQ as a daemon (`-d`)
- Set the hostname to `my-rabbit`
- Name the Docker container `rabbitmq-server`
- Map port 5672 for RabbitMQ and 15672 for the management interface

Once the container is running, you can access the RabbitMQ management interface at [http://localhost:15672/](http://localhost:15672/). The default username and password are `guest` and `guest`, respectively.

## Stop RabbitMQ

When you're done, you can stop the RabbitMQ container with the following command:

```bash
docker stop rabbitmq-server
```

And if you want to remove the container:

```bash
docker rm rabbitmq-server
```

## Output

Putting it all together, if you run the sample while RabbitMQ is running you should get output like this:

```powershell
PS> dotnet run
Hello, World!
Press any key to exit
Received: Message 1
Received: Message 2
Received: Message 3
Received: Message 4
Received: Message 5
```

## Conclusion

In a world full of complexities, MassTransit provides a simplified approach to messaging in C#. This article only scratches the surface of its capabilities - a hello world intro if you will - but there's certainly a lot to like about MassTransit. Follow some of the links below to learn more.

## References

- [MassTransit Documentation](https://masstransit-project.com/)
- [Getting Started with MassTransit and RabbitMQ](https://www.rabbitmq.com/tutorials/tutorial-one-dotnet.html)
- [MassTransit GitHub Repository](https://github.com/MassTransit/MassTransit)
- [Message Patterns in MassTransit](https://docs.microsoft.com/en-us/azure/architecture/patterns/publisher-subscriber)

If you're looking for more tips like this, [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
