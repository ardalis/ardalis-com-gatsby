---
templateKey: blog-post
title: Interfaces Describe What - Implementations Describe How
path: /interfaces-describe-what-implementations-describe-how
date: 2024-09-23
description: "When working with software development, especially in object-oriented or component-based systems, understanding the distinction between interfaces and implementations is crucial. The two terms often come up in conversations about architecture, design patterns, and coding best practices, but what do they really mean? In this post, we'll break down the difference and why it matters."
featuredpost: false
featuredimage: /img/interfaces-describe-what-implementations-describe-how.png
tags:
  - interface
  - abstraction
  - implementation
  - software design
  - object-oriented design
category:
  - Software Development
comments: true
share: true
---

When working with software development, especially in object-oriented or component-based systems, understanding the distinction between interfaces and implementations is crucial. The two terms often come up in conversations about architecture, design patterns, and coding best practices, but what do they really mean? In this post, we'll break down the difference and why it matters.

## YouTube

<iframe width="560" height="315" src="https://www.youtube.com/embed/Cg4w-MgjkLA?si=LcOwZQKK3c4Q_y7U" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## What is an Interface?

An interface in software development defines *what* a component or class can do. Think of it like a contract or a blueprint. It specifies the methods or behaviors that must be available without dictating *how* they should be carried out. (While [default interface methods](https://learn.microsoft.com/en-us/dotnet/csharp/advanced-topics/interface-implementation/default-interface-methods-versions) are a special case in modern languages like C#, they don't change the fundamental role of interfaces as abstractions).

For example, imagine you're creating an interface for a file reader. The interface might define methods like `Open()`, `Read()`, and `Close()`. However, it doesn't specify whether the file is read from a local drive, from the cloud, or even from a database. It simply outlines *what* the class should be able to do.

In simpler terms, the interface focuses on the **what**—the behavior and capabilities your system should expose. This allows different parts of a system to interact without needing to know the internal workings of the other parts. It's a definite [code smell](https://deviq.com/antipatterns/code-smells) if your interface indicates **how** it accomplishes the operations it exposes.

Remember:

> **Interfaces describe what; Implementations describe how.**

## What is an Implementation?

The implementation, on the other hand, defines *how* those methods or behaviors are actually carried out. Continuing with the file reader example, the implementation would contain the logic to open, read, and close files in a specific environment, such as reading a local file or making HTTP requests to download a file from the cloud.

While the interface lays out *what* needs to be done, the implementation handles the nitty-gritty details of *how* it's done. This separation is essential because it allows for flexibility and scalability. For example, you could have multiple implementations of the same interface: one for local files, another for cloud storage, and yet another for database access, all without changing how the rest of your system interacts with those components.

Again, the interface's job is to simply describe **what** needs to happen. The implementation is responsible for **how** it's done, in some specific manner. (and if you're wondering about **why**, see [architecture decision records](https://ardalis.com/getting-started-with-architecture-decision-records/)).

## Why the Separation Matters

### Flexibility

By separating the *what* and the *how*, you gain tremendous flexibility. Changing how something is done (such as switching from reading a local file to reading from a cloud storage service) doesn't require changes to every part of the code that interacts with the file reader. Instead, you simply swap out one implementation for another.

From the calling code's perspective, it shouldn't be concerned about *how* the task is performed, as long as it *is* performed. When you're able to achieve this kind of separation, it makes your software design much simpler.

### Testability

This separation also makes your code much easier to test. You can mock or stub out the *how* part (the implementation) when writing unit tests and focus solely on whether the system behaves as expected based on the interface. Maybe in production the file access implementation works with real files. However, in your tests you need to change how it works. The test implementation may simply return an expected string or result, or maybe it throws an exception saying the file doesn't exist. It's often much easier to set up and run tests using mock or fake implementations of *how* than by using the production "real" version of *how* the code implements the interface in question.

### Maintainability

Lastly, maintaining code becomes easier when the *what* and *how* are decoupled. Consumers of the interface need only worry about the interface, not the underlying details, making such code simpler and more loosely coupled. Implementations, too, become simpler since they too can focus solely on implementing the (hopefully [small and cohesive](https://deviq.com/principles/interface-segregation)) interface, without regard for every possible way the whole system might need to perform related tasks. 

## Real-World Example

Let's consider another common real-world example: sending notifications.

- **Interface**: You might define an interface called `ISendEmail` with a single method: `Send()`.
- **Implementation**: One implementation might send emails using an SMTP server, while another might send emails using a cloud service provider. Yet another might simply send a message on a message queue for some other part of the system to deal with. The rest of the system doesn't care how notifications are sent; it only interacts with the `ISendEmail` interface.

If later on you need to switch from SMTP to a cloud provider or your own microservice, you need only switch out implementations. The **what** described by the interface remains unchanged, and so too does all of your code that consumes that interface. Only the implementations, which describe **how** the sending is done, need to be changed. Ideally, instead of modifying existing implementations, you introduce new ones as needed, ensuring minimal disruption to the system. [Learn more.](https://www.weeklydevtips.com/episodes/015).

## Conclusion

Understanding the difference between interfaces (what) and implementations (how) is a foundational concept in software design that improves flexibility, testability, and maintainability. It allows you to build systems where the underlying functionality can evolve without breaking the contracts that the rest of your application depends on.

By focusing on the *what* with interfaces, and leaving the *how* to implementations, you can create modular, scalable, and adaptable codebases that are easier to manage over time.
