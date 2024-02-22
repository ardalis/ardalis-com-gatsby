---
templateKey: blog-post
title: "Introducing Modular Monoliths: The Goldilocks Architecture"
date: 2024-02-21
description: "This article introduces the concept of Modular Monoliths, an architectural approach that combines the simplicity of monolithic applications with the flexibility of microservices, offering a balanced solution for software development. It outlines the key characteristics, advantages, and suitable scenarios for adopting this Goldilocks architecture, providing a pragmatic path for developers and architects aiming for maintainability, simplicity, and scalability in their projects."
path: blog-post
featuredpost: false
featuredimage: /img/introducing-modular-monoliths-goldilocks-architecture.png
tags:
- Modular Monolith
- Software Development
- Software Architecture
- Microservices
- Monoliths
category:
  - Software Development
comments: true
share: true
---
In the world of software architecture, finding the perfect balance between complexity and simplicity can often feel like an elusive quest. Developers and architects are constantly navigating the spectrum between traditional monoliths, known for their simplicity but criticized for their scalability and maintainability issues, and microservices, praised for their scalability and flexibility but often complicated by their operational and developmental overhead. Enter the "Goldilocks" architecture: the [Modular Monolith](https://bit.ly/3UKfNWI). This architecture promises to strike a balance that is "just right" for many applications, offering the simplicity of a monolith with the flexibility of microservices.

## What is a Modular Monolith?

A Modular Monolith is a software architecture that structures the application as a single deployment unit (like a traditional monolith) but organizes its internal components or modules in such a way that they are loosely coupled and highly cohesive. Each module within the architecture focuses on a specific business domain or functionality, similar to how microservices operate, but without the distributed system complexity.

## Where to Learn More

I've published two courses on Modular Monoliths:

- [Getting Started: Modular Monoliths in .NET](https://bit.ly/3T1pC17)
- [Deep Dive: Modular Monoliths](https://bit.ly/3I5wWm3)
- [Bundle (both of the above)](https://bit.ly/3UKfNWI)

You can use code ARDALIS at checkout (should be already embedded in the above links) for 20% off of the individual courses (the bundle has a permanent 20% discount built in).

Now back to your article already in progress...

### Key Characteristics

- **Cohesion within Modules:** Each module is designed around a business domain, encapsulating its logic, data, and dependencies. This encourages [domain-driven design](https://www.pluralsight.com/courses/fundamentals-domain-driven-design) and makes the codebase more intuitive and aligned with business requirements.
- **Loose Coupling between Modules:** Inter-module communication is managed through well-defined interfaces or shared libraries, minimizing direct dependencies and making modules more replaceable and maintainable.
- **Single Deployment Unit:** Despite its internal segmentation, the application is deployed as a single unit, simplifying deployment processes and eliminating the need for complex orchestration.

### Advantages of Modular Monoliths

Modular Monoliths offer a unique set of advantages that make them particularly appealing for certain types of projects:

- **Simplified Development and Deployment:** By avoiding the distributed nature of microservices, modular monoliths reduce operational complexity, making development, testing, and deployment more straightforward.
- **Improved Maintainability:** The clear modular boundaries and reduced coupling make it easier to understand, maintain, and evolve the application over time. Most changes will only require an understanding of a single module, not the entire system.
- **Flexibility for Future Scaling:** Starting with a modular monolith doesn't preclude the possibility of migrating to microservices later. Modules can be gradually broken out into separate services as the need arises, providing a flexible path for scaling. [This is considered the safest path to deploying a microservices-based system, according to Martin Fowler.](https://martinfowler.com/bliki/MonolithFirst.html)

## Comparing Modular Monoliths and Microservices

The biggest difference between modular monoliths and microservices is in how they're deployed. This has a big impact on complexity and cost, because building and maintaining distributed systems is inherently more difficult than non-distributed, monolithic systems. The [fallacies of distributed computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing) offer a simple summary of why this is the case.

We can chart traditional non-modular monoliths along with modular monoliths (moduliths, if you will) and microservices based on how modular they are and how many deployed services the system uses:

![monoliths moduliths microservices graph](/img/modular-monoliths-vs-microservices-graph.png)

## A Common Microservices Antipattern: The Distributed Monolith

The key to successful microservices is their independence from one another. However, there are many ways in which teams can reduce or eliminate this independence, often without realizing it. If you have direct, realtime dependencies between microservices, such that one is only available when another one is, they're coupled together, not independent. If they share a database, they're coupled together, not independent. If you find that any time you change one microservice, you need to update and deploy several others, they're almost certainly not independent.

When you design and build an entire application ostensibly using microservices but with tight coupling between the different services, you've essentially built a **distributed monolith**.

![monoliths moduliths microservices distributed monoliths.png](/img/monoliths-moduliths-microservices-distributed-monoliths.png)

## When to Choose a Modular Monolith

A Modular Monolith architecture is particularly well-suited for projects where:

- The team is small to medium-sized, or the project is at an early stage, making the operational complexity of microservices unnecessary.
- The application's domains are well-understood, but future scaling requirements are uncertain.
- There is a need for rapid development and deployment without sacrificing the ability to scale or refactor in the future.
- The team is attempting to "fix" a Big Ball of Mud monolithic application and considering microservices. **Modular monoliths provide a bridge between monoliths and microservices**.

## Conclusion

The Modular Monolith architecture offers a pragmatic approach to software design, providing the benefits of microservices-like modularity within the simplicity of a monolithic application. It stands as a testament to the idea that sometimes, the middle ground is not only the path of least resistance but also the path of greatest potential. As we continue to explore the vast landscape of software architecture, the Modular Monolith reminds us that the best solution often lies in balance, adaptability, and the thoughtful consideration of our unique project needs and team dynamics.

### References

1. Martin Fowler on Microservices - [https://martinfowler.com/bliki/MonolithFirst.html)
2. Fundamentals of Software Architecture, by Mark Richards and Neal Ford [Amazon](https://amzn.to/3OS4bgq)
3. [YouTube: Introducing Modular Monoliths](https://www.youtube.com/live/wkAc6K09pKQ?si=lC-uAwyDHX4eJYmL&t=147) with Robert Green and Me on Visual Studio Toolbox
4. [YouTube: Modular Monolith Architecture](https://www.youtube.com/watch?v=ikuu3QIuJuc&ab_channel=MarkRichards) by Mark Richards
5. [More Courses on Dometrain](https://dometrain.com/?affcode=1115529_gyvpazys)

**Keep Improving!**

P.S. If you're looking to improve as a software developer, you may wish to join thousands of other developers who get my newsletter each week. [Sign up here](/tips)!
