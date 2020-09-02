---
templateKey: blog-post
title: Postel's Law - The Robustness Principle
path: blog-post
date: 2020-09-01T14:44:53.681Z
description: Postel's Law, also known as the Robustness Principle, states that TCP implementations should be conservative in what they do (send), but liberal in what they accept from others. It's credited with helping the early Internet's rapid and decentralized growth, and has also been applied to communication and UX.
featuredpost: false
featuredimage: /img/postels-law-the-robustness-principle.png
tags:
  - networking
  - laws
  - communication
  - microservices
category:
  - Software Development
comments: true
share: true
---
[Postel's Law](https://en.wikipedia.org/wiki/Robustness_principle), also known as the robustness principle, states:

> Be conservative in what you do, be liberal in what you accept from others.

Jon Postel wrote this in an early version of the TCP specification in 1980, and it has since been referred to as Postel's Law.

## Origin

The main goal of this principle is to maximize the tolerance individual components of a system have for small incompatibilities. In the early days of the Internet (TCP is a low level networking protocol underlying most communication performed on today's networks), it was more important that most messages *work* than that they conform absolutely to a particular version of a networking protocol. Protocols were evolving, and individual components that had been built and deployed could not necessarily be updated easily to support later revisions. Further, many different companies and organizations were all trying to build components that would interact with one another, and interpretations even of the same protocol often differed. Given this scenario, the principle's first part of allowing minor variations makes a lot of sense. Without it, many existing components would quickly stop working as new components implementing newer versions of protocols were deployed.

## The Rise of the Web

In the 90s, when HTTP and HTML were invented, this law continued to be applied to browsers. Many browsers were written to be liberal with what they would accept in terms of HTML, with the argument being that it was a better user experience to try and interpret the HTML as much as possible rather than simply displaying an error. Of course, this resulted in many incompatibilities between browsers, because how each one interpreted this or that HTML feature or bit of invalid markup varied widely. "Browsers have historically been remarkably tolerant of ill-formed HTML and that allowed the web to grow tremendously fast." [Feathers](https://michaelfeathers.silvrback.com/the-universality-of-postel-s-law) There continue to be browser incompatibilities today, but they're largely better than in the early days. Note again that the spread of HTML and the growth of the "world wide web" were both helped by applying this principle, because there was no central authority over all browsers and all web sites, and because the protocols themselves were rapidly evolving (even if only unofficially in some cases).

## User Experience

In the field of UX, you can apply this [same principle](https://lawsofux.com/postels-law.html). Small changes in input can be forgiven or manipulated to match the expected value. Aliases for common commands can be allowed for. Examples of ways in which user inputs follow this rule include:

- Form inputs automatically trimming whitespace
- Form inputs automatically ignoring upper/lower case
- Forms automatically showing and using default values where appropriate for required fields
- Natural void interfaces (Alexa, Cortana, Google Home, etc.) support synonyms for various commands

All of these affordances help the systems to be more liberal with the kinds of inputs they will accept, and again the emphasis is on trying to achieve wide appeal that smooths over minor differences. These examples all represent boundaries between what the system controls and other systems (in this case, users). This is where Postel's Law makes the most sense and has the greatest value.

## Communication

Forgetting about computers for a moment, Postel's law applies to human-to-human communication as well. The lower the fidelity of the communication, the more important it is to apply this law. An example of low fidelity communication would be a mailed letter, as opposed to high fidelity in person face-to-face communication. The less information the receiver gets from the sender, in terms of non-verbal or unwritten cues like emotion or intent, the more the receiver must assume. Remember, for all practical purposes, it doesn't matter what message you think you sent, only what the recipient thinks they received. [The message is the message received](https://ardalis.com/the-message-is-the-message-received/) and as the sender you can't necessarily control that, so you should be careful (conservative) in what you send. As the recipient, you can't control what was said, but [you can control your reaction to it](https://automattic.com/postels-law/). Be liberal in what you accept, and try to first attribute concerns you have to miscommunication before malice.

> Never attribute to malice that which is adequately explained by communication failure.

This is my own kinder version of [Hanlon's razor](https://simple.wikipedia.org/wiki/Hanlon%27s_razor), which states "Never attribute to malice that which is adequately explained by stupidity."

## Microservices

When designing a distributed system using microservices, the robustness principle can be applied to reduce down time. Microservices should be independent of one another, and thus may be upgraded in isolation. When this happens, small changes in their message protocols may occur. Versioning of messages and APIs can be challenging, but the robustness principle can make things a little smoother by ensuring that services are as accepting as possible of inputs, even if they're not exactly what was expected.

## Patterns

Several design patterns are ideally suited to working with and implementing Postel's law. Probably the most obvious one is the [Adapter Pattern](https://www.pluralsight.com/courses/c-sharp-design-patterns-adapter), which is used to allow incompatible interfaces to interoperate. If changes in incoming messages were to cause problems in a system, an adapter could be developed and added that would allow the downstream system to continue to accept these messages without needing to be redeployed.

In [Domain-Driven Design](https://www.pluralsight.com/courses/domain-driven-design-fundamentals), bounded contexts provide an encapsulation boundary for a particular subdomain. Where bounded contexts must interoperate with other systems, an [anti-corruption layer](https://docs.microsoft.com/en-us/azure/architecture/patterns/anti-corruption-layer) is employed to keep these other systems from corrupting the domain model of the bounded context. This anti-corruption layer is another place where the robustness principle may be applied. It often includes adapters as well as other [patterns](https://www.pluralsight.com/paths/design-patterns-in-c) like [Facade](https://www.pluralsight.com/courses/csharp-design-patterns-facade).

Domain-Driven Design principles and practices map closely to microservices best practices, so it's not unusual to see the approach used in microservices development.

## Downsides

So, since it's a "law" it should be applied all the time, right? Not so fast. There are downsides to being liberal in what you'll accept. When this approach is followed for a sufficiently long period of time, the incorrect but liberally accepted messages become their on de facto standard, which can inhibit upgrading the system (since support for these may need to be maintained). Even worse, what about when you really **should** attribute the differences to malice, because they represent an attack? This [IETF draft](https://tools.ietf.org/html/draft-iab-protocol-maintenance-04) makes some good points about the robustness principle, and the long term effects of following it:

> The application of the robustness principle to the early Internet, or any system that is in early phases of deployment, is expedient.  The consequence of applying the principle is deferring the effort of dealing with interoperability problems, which can amplify the ultimate cost of handling those problems.

...

> A flaw can become entrenched as a de facto standard.  Any implementation of the protocol is required to replicate the aberrant behavior, or it is not interoperable.  This is both a consequence of applying the robustness principle, and a product of a natural reluctance to avoid fatal error conditions.  Ensuring interoperability in this environment is often referred to as aiming to be "bug for bug compatible".

The draft goes on to discuss what it refers to as "virtuous intolerance":

> Intolerance of any deviation from specification, where implementations generate fatal errors in response to observing undefined or unusual behaviour, can be harnessed to reduce occurrences of aberrant implementations.  Choosing to generate fatal errors for unspecified conditions instead of attempting error recovery can ensure that faults receive attention.

This is summed up in the principle "fail fast." If something is going to fail, the sooner it does so, the better. This improves feedback cycles and allows for corrective action to be performed immediately, rather than in the future when it might be much more expensive. Catching a bug due to a compilation failure is cheaper than during a runtime failure. Catching a bug during an automated test on a build server is cheaper than in production. Virtuous intolerance relies on intolerant implementations being widely deployed such that they are encountered quickly and with high probability (otherwise, they will still fail, but not "fast").

## Summary

Summary goes here.

## References

- [Postel's Law (Wikipedia)](https://en.wikipedia.org/wiki/Robustness_principle)
- [The Universality of Postel's Law](https://michaelfeathers.silvrback.com/the-universality-of-postel-s-law)
- [The Message is the Message Received](https://ardalis.com/the-message-is-the-message-received/)
- [Postel's Law (and human communication)](https://automattic.com/postels-law/)
- [The Harmful Consequences of the Robustness Principle](https://tools.ietf.org/html/draft-iab-protocol-maintenance-04)
- [Design Principles in Leadership: Postel's Law](https://medium.com/the-human-business/design-principles-in-leadership-postels-law-f3d7192cc7ac)