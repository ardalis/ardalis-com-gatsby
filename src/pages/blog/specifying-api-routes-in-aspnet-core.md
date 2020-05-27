---
templateKey: blog-post
title: Specifying API Routes in ASPNET Core
path: blog-post
date: 2016-09-08T05:18:00.000Z
description: "ASP.NET Core uses attribute routing to determine the behavior of
  web APIs. Its integrated support for MVC and Web API is one of my favorite
  features, since working with MVC 5 and Web API 2 was painful due to the
  similarities but separate implementations of the two stacks. "
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - api
  - asp.net core
  - routing
  - startup
  - web api
category:
  - Software Development
comments: true
share: true
---
ASP.NET Core uses attribute routing to determine the behavior of web APIs. Its integrated support for MVC and Web API is one of my favorite features, since working with MVC 5 and Web API 2 was painful due to the similarities but separate implementations of the two stacks. When creating routes for your APIs, a common approach is to use something like this:

`[Route("api/[controller]/{id?}")]`

When applied to a particular API Controller class, especially one performing typical CRUD operations like List, Add, Update, and Delete, this route will work. However, it’s not as specific as it could be, and will result in odd scenarios being supported and/or more error checking required. For instance, the List method might not accept any parameters, but with this route in place a request with an ID would still be routed to the List() method. What’s more, the {id?} token states that the id is opti0nal, but it’s not optional for most of the methods involved in a typical API.

A better approach is to build the route specific to each action method, like so:

`[Route("api/[controller]")] public class ItemsController : Controller
{
  [HttpGet]
  public IActionResult List() {}

  [HttpPost]
  [Route("{id}")]
  public IActionResult Create(string id, [FromBody] Item item) {}

  [HttpPut]
  [Route("{id}")]
  public IActionResult Update(string id [FromBody] Item item) {}

  [HttpDelete]
  [Route("{id}")]
  public IActionResult Delete(string id) {}
}`

It’s up to you whether you would even require an ID parameter for Create and Update methods. In those cases usually the Item being sent will have an ID property of its own that can be used. It’s also not unusual to have two \[HttpGet] methods, one for a single item and one for a list, with the single item method accepting an ID as well. The point is, you can easily use a combination of class and method level route attributes to construct routes that map explicitly to the actions, rather than using less specific global or controller level routes.