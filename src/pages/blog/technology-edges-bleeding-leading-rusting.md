---
templateKey: blog-post
title: "Navigating the Edges of Technology in Software Development: Bleeding, Leading, and Rusting"
description: "In the fast-evolving world of software development, keeping pace with technology trends is both a necessity and a challenge. Companies and developers often find themselves making critical decisions about whether to adopt new technologies early (bleeding edge), wait until they mature (leading edge or cutting edge), or continue using older, more established technologies (what I'll call the rusting edge). Understanding the distinctions and implications of these choices can significantly impact both the development process and business outcomes."
date: 2024-04-19
path: /technology-edges-bleeding-leading-rusting
featuredpost: false
featuredimage: /img/technology-edges-bleeding-leading-rusting.png
tags:
  - software development
  - mvc
  - asp.net
  - asp.net core
  - minimal apis
  - razor pages
  - web forms
  - silverlight
  - angularjs
  - .net aspire
  - technology
  - trends
category:
  - Software Development
comments: true
share: true
---

In the fast-evolving world of software development, keeping pace with technology trends is both a necessity and a challenge. Companies and developers often find themselves making critical decisions about whether to adopt new technologies early (bleeding edge), wait until they mature (leading edge or cutting edge), or continue using older, more established technologies (what I'll call the **rusting edge**). Understanding the distinctions and implications of these choices can significantly impact both the development process and business outcomes.

## Bleeding Edge: Innovation at a Risk

The term "bleeding edge" refers to technology that is so new it hasn’t been widely tested or adopted. These are often preview releases or version 1.0 products that promise innovative features and competitive advantages but come with higher risks of instability and lack of support. For startups or tech-centric businesses aiming to disrupt markets, bleeding edge technologies may offer the crucial differentiation needed to stand out. However for more established businesses who hope to build software that will last years, the frequent changes (and outright failures) common to bleeding edge technology are often better avoided.

Some examples of bleeding edge technologies that burnt companies who bet on them include [AngularJS (Angular 1)](https://en.wikipedia.org/wiki/AngularJS) and [Silverlight](https://www.reddit.com/r/sysadmin/comments/tquo2p/silverlight_5_eol_microsoft_removed_the_links/).

**Pros:**

- Access to the latest innovations and technologies.
- Potential to gain market advantages by leveraging new capabilities early.

**Cons:**

- Higher risk of encountering bugs and security vulnerabilities.
- Limited community support and resources, such as working samples and documentation.
- Potential for significant changes or discontinuation by vendors.
- Few developers with experience using the product - everyone must learn on the job

**Examples in .NET in April 2024**

- [.NET Aspire](https://learn.microsoft.com/en-us/dotnet/aspire/get-started/aspire-overview). Currently in preview, this technology is likely to be supported by the end of 2024.
- [.NET 9 preview 3](https://dotnet.microsoft.com/en-us/download/dotnet/9.0). Currently ion preview; expected release November 2024.

## Leading Edge: Established Yet Evolving

Leading edge technologies are those that have emerged from their initial testing phase and have proven effective in real-world applications. These are typically at least version 2.x releases and have garnered an active community and robust support. Organizations looking for a balance between innovation and reliability often opt for leading edge technologies.

**Pros:**

- Lower risk than bleeding edge technologies with a stable release.
- Strong community support and ample learning resources.
- Regular updates and patches from developers.
- Larger pool of experienced developers to draw from.

**Cons:**

- Some risk of obsolescence as newer technologies emerge.
- Possible limitations if the technology does not evolve quickly enough to meet emerging needs.

**Examples in .NET in April 2024**

- [.NET 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0). The latest available version of .NET, also an LTS (Long Term Support) release, with support ending in November 2026.
- [Minimal APIs](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis/overview?view=aspnetcore-8.0). The latest approach to building web APIs in .NET. First introduced in .NET 6. Currently in active development.
- [Razor Pages](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/?view=aspnetcore-8.0&tabs=visual-studio). First introduced in .NET Core 2.0. Currently the recommended approach to building server-rendered page-based sites with ASP.NET Core.

## Rusting Edge: Reliable but Declining

The "rusting edge" describes technologies that are on the decline. They are often nearing the end of their lifecycle but may still be supported and used within many organizations. These technologies are typically well-understood, stable, and have extensive documentation, making them a safe choice for critical systems that require reliability over innovation.

**Pros:**

- High stability and reliability.
- Extensive documentation and widespread knowledge.
- Predictable performance and fewer surprises.

**Cons:**

- Limited or no updates and improvements.
- Shrinking community and expertise pool.
- Risk of eventual obsolescence requiring eventual migration or overhaul.

**Examples in .NET in April 2024**

- [ASP.NET Core MVC](https://learn.microsoft.com/en-us/aspnet/core/mvc/overview?view=aspnetcore-8.0). Introduced in .NET Core 1.0 in 2016 to replace MVC 5. No longer under active development, but still supported. Replaced by Razor Pages, minimal APIs, and Blazor.
- [.NET Framework MVC](https://learn.microsoft.com/en-us/aspnet/mvc/overview/getting-started/introduction/getting-started). MVC 5 is the latest version, released in 2013.
- [.NET Framework Web APIs](https://learn.microsoft.com/en-us/aspnet/web-api/overview/getting-started-with-aspnet-web-api/tutorial-your-first-web-api). Version 2 is the latest version, released in 2013.
- [ASP.NET Web Forms](https://en.wikipedia.org/wiki/ASP.NET). First released as simply "ASP.NET" in 2002.
- [(Visual) FoxPro](https://en.wikipedia.org/wiki/Visual_FoxPro). First released in the 1980s and acquired by Microsoft in the 1990s. Its final release was in 2007, and extended support ended in 2015.

## Making the Right Choice

Deciding which edge to lean towards requires a strategic assessment of an organization's goals, risk tolerance, and market position. Innovation-driven companies might prefer the bleeding edge to stay competitive, while those in the most heavily regulated industries might find recent additions to the rusting edge more appropriate. Most will find the leading edge a safe yet progressive choice, with an optimal mix of risks and productivity.

In most cases, it would be a mistake to start a new project, expected to live for 10 or more years, on a rusting edge technology. Such applications often find themselves obsolete by the time the ship their first version. They have a hard time finding support as well as developers willing to work on dead end technology, and while initially developer resources may be abundant, that pool tends to quickly dry up as experienced developers retire or shift to working with more modern technologies. Thus, companies often must pay a premium to lure developers into working on rusting edge technology.

In conclusion, whether you’re pioneering with bleeding edge, progressing with leading edge, or maintaining with rusting edge technology, each has its place in the ecosystem of software development. The key is to align your technology strategy with your business objectives and the specific needs of your projects and teams.

### References

- [Gartner 2023 Hype Cycle for Emerging Technologies](https://www.gartner.com/en/articles/what-s-new-in-the-2023-gartner-hype-cycle-for-emerging-technologies)
- [Merriam-Webster: bleeding edge](https://www.merriam-webster.com/dictionary/bleeding%20edge)
- [Merriam-Webster: leading edge](https://www.merriam-webster.com/dictionary/leading%20edge)
- [Merriam-Webster: cutting edge](https://www.merriam-webster.com/dictionary/cutting%20edge)
- (rusting edge hasn't made it into the dictionary yet - I just introduced the term)

*If you found this useful, consider sharing it with a peer and joining my [weekly dev tips newsletter](/tips) or [subscribe to my YouTube channel](https://youtube.com/ardalis). Cheers!*
