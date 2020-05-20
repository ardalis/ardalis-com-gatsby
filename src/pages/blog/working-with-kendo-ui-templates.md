---
templateKey: blog-post
title: Working with Kendo UI Templates
path: blog-post
date: 2014-02-20T17:09:00.000Z
description: I’m watching the Introduction to Kendo UI course by Keith Burnell
  on Pluralsight and decided to play around a little bit with templates, which
  are a pretty powerful feature.
featuredpost: false
featuredimage: /img/image_thumb_3_todo.png
tags:
  - javascript
  - jquery
  - kendoui
category:
  - Software Development
comments: true
share: true
---
I’m watching the [Introduction to Kendo UI course by Keith Burnell on Pluralsight](http://pluralsight.com/training/courses/TableOfContents?courseName=introduction-to-kendoui) and decided to play around a little bit with templates, which are a pretty powerful feature. If you’re a server-side web developers, templates should seem pretty familiar to you. Any ASP or ASP.NET page can be thought of like a template, in which you mix markup and dynamic data expressions. In this case, the templates are defined in their own script blocks. There are demos and documentation available; in my case I opted to write something up based on what’s in the Pluralsight course in a JSFiddle.

Templates are most valuable when you’re binding some data to them. The data can be anything – Keith Burnell uses cars – in my case since I’m getting ready to go to bed soon, I used a simple task lists:

![](/img/image_3_java.png)

Once you have the data, you can think about how you want to visualize it. A simple unordered list with a heading is perfect. To define this as a Kendo UI Template, you need to place the HTML markup within a script block with a type of “text/x-kendo-template”. As with other template solutions like ASP, ASP.NET, and Razor, there is a special syntax you use to switch between raw markup and embedded JavaScript or bound objects. In this case, you use a “hash syntax” in which JavaScript code is surrounded by # symbols, and displaying JavaScript values is done using #= (or #: for HTML encoded values). The template for HTML to display the above data looks like this:

![](/img/image_6_java.png)

The nice thing about templates like this is that they’re mostly declarative. We’re not having to write a lot of string manipulation code in order to create the markup. All that’s left to do at this point is to bind the data to the template, and output the result somewhere. We’ll specify that the output will go into an html element: a div with an id of “container”.

![](/img/image_9_java.png)

The final result:

![](/img/image_thumb_3_todo.png)

I’ve [created a JSFiddle with the above code](http://jsfiddle.net/NkT9h)in it and necessary references to Kendo UI and jQuery so that you can play with it yourself, or cut and paste any of the code into your own project. Have fun using templates to simplify your HTML markup when you’re using Kendo UI!