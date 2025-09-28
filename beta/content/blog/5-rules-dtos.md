---
title: 5 Rules for DTOs
date: "2024-04-06T00:00:00.0000000"
description: These are 5 rules for writing better DTOs.
featuredImage: /img/5-Rules-DTOs.png
---

If you don't like reading, here's my YouTube video with samples that covers why these 5 rules will help you write better DTOs:

<iframe width="560" height="315" src="https://www.youtube.com/embed/W4n9x_qGpT4?si=1ryxzqqMlRM3Sx8w" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## What's a DTO?

A DTO is a Data Transfer Object. Its job is to transfer data, and it can be used both to *send* data and to *receive* it. Often, data transferred will use different types (possibly even different programming languages and technology stacks) on each end of the transfer. The only thing you can count on transferring is the *data* - nothing else. Which leads to the first rule for DTOs.

![Rule 1. DTOs only contain data. No logic or behavior.](/img/DTOs-Rule-1.png)

DTOs should be super easy to work with, as well as to author. They do not benefit from encapsulation and typically they should avoid using inheritance as well (hiding things isn't something we want with DTOs, and reuse is overrated, too). Which leads us to the second rule.

![Rule 2. DTOs do not enforce encapsulation. They don't need private/protected members.](/img/DTOs-Rule-2.png)

Now, even though DTOs don't need encapsulation, it's still generally preferred to use C# properties rather than fields. By default, serializers and other language features work on properties but not fields (though you can configure this). Rule 3:

![Rule 3. DTOs should use properties (not fields).](/img/DTOs-Rule-3.png)

But what should you name them? An obvious naming convention is simply to add"DTO" (or"Dto") to the end of whatever sort of thing is being described. While this works and is fine for the most basic representation, there are many cases where you should use a more descriptive name.

Many common types used in modern dotnet apps can (and usually should) be modeled as DTOs. These include API request and response objects, commands and queries, events, and more. In such cases, suffix the type with the more specific name (e.g."CreateUserRequest" instead of just"UserDTO"). See rule 4.

![Rule 4. DTOs should only use"-DTO" suffix as a last resort. Prefer more descriptive names.](/img/DTOs-Rule-4.png)

Here are some of the things that should be DTOs, and should be named according to their particular use, rather than naming them"FooDTO", as rule 5:

![Rule 5. These should be modeled as DTOs: API Request/Response types, MVC ViewModel objects, Database query result objects, Messages like commands, events, and queries.](/img/DTOs-Rule-5.png)

## Summary

There's actually quite a bit more to say about DTOs, like how to map them, where they should live, and what types they should reference, but I'll save that for a follow-up article/video.

[Watch the full video on YouTube with samples here](https://www.youtube.com/watch?v=W4n9x_qGpT4&ab_channel=Ardalis). Thanks!

## Keep Up With Me

If you're looking for more content from me in your inbox [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).

