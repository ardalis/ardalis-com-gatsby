---
templateKey: blog-post
title: How to Easily Format Tables in Markdown
path: blog-post
date: 2020-07-01T12:26:21.129Z
description: Markdown is a great tool/language for writing documentation and
  building styled content for books, etc. in a very source control friendly way.
  However, one area where it's lacking is in easy support for displaying tables.
  Fortunately, there's a free online tool that makes this easy, too!
featuredpost: false
featuredimage: /img/how-to-easily-format-tables-in-markdown.png
tags:
  - markdown
  - table
category:
  - Productivity
comments: true
share: true
---
I'm a big fan of [Markdown](https://www.markdownguide.org/basic-syntax/). It provides a simple way to richly format text without the complexity or security issues that would come from using HTML. Support for Markdown is ubiquitous within the software development industry, with native support everywhere from [GitHub](https://guides.github.com/features/mastering-markdown/) to [StackOverflow](https://stackoverflow.com/editing-help). I've written everything from [short documentation articles](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/middleware/) to [several entire](https://docs.microsoft.com/en-us/dotnet/architecture/cloud-native/) [ebooks for Microsoft](https://docs.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/) using Markdown. I've even recently [moved my blog to GatsbyJS/Netlify/Github using Markdown](https://github.com/ardalis/ardalis-com-gatsby) (you can see [this article's source here](https://github.com/ardalis/ardalis-com-gatsby/blob/master/src/pages/blog/how-to-easily-format-tables-in-markdown.md))! But one thing that has always been a real pain with Markdown is table formatting.

Tables are often the best way to present some data. I learned about HTML tables early in my career, before CSS really was a thing, and we used them not just for data presentation but also layout. I got pretty good at defining TR and TD tags and spanning this or that cell across multiple rows or columns to make it fit where I wanted. Markdown doesn't do any of that. There are no tags. Instead, you basically draw the tables as ASCII art by using | and - characters. In my experience it's quite tedious and easy to get wrong when doing it by hand.

Fortunately, you don't have to.

## Markdown Tables Generator

There's a really nice tool I found recently called [Tables Generator](https://www.tablesgenerator.com/markdown_tables). It's a web site that will let you author your table and then click a button to generate the Markdown needed to produce it. It also supports LaTeX and HTML table syntax if you prefer. Just click on the sample table and start adding text. When you're ready, click Generate to see the resulting Markdown. Then copy/paste it into your markdown file and you're done!

![Markdown Table Generator Sample](/img/markdown-tables-generator-sample.png)

That's really all there is to it. The tool supports some basic formatting and makes it easy to build the table you need. It was a big help to me recently on some work I was doing that involved a few complex tables. I hope you find it useful.
