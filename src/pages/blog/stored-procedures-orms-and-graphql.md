---
templateKey: blog-post
title: Stored Procedures, ORMs, and GraphQL
date: 2020-04-26
path: /stored-procedures-orms-and-graphql
featuredpost: false
featuredimage: /img/stored-procedures-orms-graphql.png
tags:
  - graphql
  - orm
  - predictions
  - rest
  - stored procedure
  - web api
category:
  - Software Development
comments: true
share: true
---

_GraphQL is the new ORM, and your API endpoint is the new stored procedure._

About fifteen years ago, a debate raged in the still-young .NET development world over how best to access data. On the one side were the traditionalists, among them database administrators (DBAs) and many experienced software developers with experience building efficient, performant applications. On the other were (mostly) newer developers, with an interest in building new applications as quickly and effectively as possible to meet that time's enormous demand for web-based software. One set of tools stood out - the Object/Relational Mapper (O/RM or ORM). With these tools, developers no longer needed to hand-craft low level queries and commands in SQL to work with data, either via custom queries or stored procedures.

## Stored Procs vs. ORMs; DBAs vs. Devs

![ORMS vs. Stored Procedures](/img/orms-vs-stored-procedures-1536x1023.jpg)

It's a bit of a simplification to say that the main conflict was between database administrators and application developers, but these two camps are representative of the two opposing worldviews. On the side of the DBAs, the arguments favored run time performance and security. Hand-crafted queries, pre-compiled and encapsulated in stored procedures, offered the best performance, especially over the inefficient queries often produced by early ORM tools. In addition, applications could be configured to connect to their database using credentials that were restricted to accessing only (certain) stored procedures. What's more, the most common security exploit of the time (and still today), SQL injection attacks, were generally ineffective against data access that used stored procs. These were compelling arguments on this side of the debate.

On the ORM side, application developers sought to eliminate one of the major bottlenecks in their lives - waiting for the queries they needed to allow their apps to work with data. Web development was still relatively new, and one of its defining characteristics was its ability to be updated quickly and globally. This agility and speed of development was often hamstrung by policies requiring separate teams or individuals to manage data access. Especially in startups and smaller organizations (who often lacked dedicated database professionals on staff), the ability to move quickly was often valued over the best possible performance and security practices. Speed to market and maximizing the utility of scarce web developer resources brought a great deal of interest in ORM tools that could largely eliminate the need to hand craft stored procedures and custom SQL within applications. It's worth noting that the use of ORMs, too, helped to eliminate many SQL injection vulnerabilities.

## The Return of Thick/Smart Clients

Early web applications of the 90s/00s generally built each page's HTML on the server and sent the resulting page to a browser over HTTP. Users would interact with the page through hyperlinks or forms, sending additional requests back to the server with each interaction. Virtually all of these applications' logic ran on the server, with the client browser used solely to render the HTML. Such relatively "dumb" clients are known as thin clients. These contrasted with many client-server applications that preceded the web, in which most of the logic ran in the application executable itself.

With improvements in browsers and JavaScript performance, and eventually frameworks like jQuery and later Angular and React, web applications became smarter, with more and more of the application logic running in the browser. Thus, many web applications used "thick" clients. At the same time, the introduction of the iPhone in 2007 ushered in a new era of app development for phones and mobile devices. These native applications were additional examples of thick/smart clients. These smart clients all communicate with servers through HTTP API calls.

Many web developers have specialized their skills to focus on building rich client-side applications using HTML, JavaScript, and CSS (front end developers) or on serving up the data and efficiently executing commands using server side technologies (back end developers). Especially in smaller organizations, many web developers remain responsible for both "ends" of web application development (so called full stack developers).

## APIs are the new Stored Procedures

Web APIs are carefully architected and designed to support their clients, both end-user applications and other services. These APIs must be secure, scalable, and performant. Building APIs effectively involves a fair bit of knowledge, and developers responsible for these APIs often guard them against front-end developers, fearing they might introduce problems in their rush to expose functionality they need for their client side apps.

Meanwhile, front-end developers often feel like they're forced to wait on the APIs they need to support their apps. If only there were a way for them to eliminate the need to deal with hand-crafted API endpoints (and the need to deal with the gate-keeping developers responsible for them).

Enter GraphQL.

## GraphQL is the new ORM

[GraphQL](https://graphql.org/) is a query language for APIs, allowing front end developers to define queries on the client, have them executed on the server, and get back exactly the data they need. Applications that leverage GraphQL do not need to write separate individual API endpoints for every query the application needs to perform against the server. Data updates can be performed using [mutations](https://graphql.org/graphql-js/mutations-and-input-types/).

This should sound familiar at this point. With the bulk of application logic living in smart clients (web and mobile), and with a new technology (GraphQL) providing faster development with fewer moving parts and requiring fewer developers, it's no surprise GraphQL has gained popularity rapidly. It's not a silver bullet and it does have disadvantages when compared to web APIs ([here's a detailed comparison](https://goodapi.co/blog/rest-vs-graphql)), but for many applications and organizations these tradeoffs are acceptable.

## What to Expect

ORMs eventually penetrated from startups and small businesses into the enterprise. Today, most Microsoft development shops use Entity Framework (or alternative frameworks) for at least some of their CRUD-based data requirements. It's become the exception rather than the rule to see ASP.NET applications that rely entirely on stored procedures for their data access. A lot of this adoption hinged on Microsoft embracing ORMs themselves, shipping their own ORM tool in the form of EF, and improving it over the last decade.

Today, GraphQL is rare in the enterprise, at least in the Microsoft-based organizations who typically request my assistance. It's still a relatively new technology, and Microsoft doesn't yet offer a GraphQL solution, though it has offered technologies in the same space in the form of OData. But [GraphQL is not OData](https://jeffhandley.com/2018-09-13/graphql-is-not-odata). If GraphQL continues to grow in popularity and demand, I think it's only a matter of time before Microsoft ships support for it in .NET, and eventually it starts being used in more and more enterprises just as ORMs did before it.
