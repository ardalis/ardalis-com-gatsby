---
templateKey: blog-post
title: Creating a Simple ASP.NET Report with Export to Excel
date: 2011-04-19
path: blog-post
description: In this article you will learn how to create a simple ASP.NET report using Web Forms, C#, and a View Model class rather than drag and drop controls, resulting in very clean and understandable HTML. Then, you'll learn how to add Export to Excel functionality, allowing users to export the data in Excel format and save the file with a default filename of your choosing (as opposed to Report.aspx, for instance).
featuredpost: false
featuredimage: /img/aspnet-report-excel.png
tags:
  - ASP.NET MVC
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

One of my very first articles was on [exporting reports to Excel using Active Server Pages](http://aspalliance.com/1), and this article still gets over a thousand views per month.  Today I had to create a quick report for internal use and I thought it would be helpful for the user to be able to quickly export the results to Excel.  Thus I found myself, over a decade later, going through much the same process as in that original article.  Some things have changed, but the basics are still much the same.

## Getting the Data

I'm assuming that you're able to get back your data from a database somehow if that's your data source.  I'm practicing some separation of concerns even though in this case I'm working in a Web Forms application, which means that my data access lives somewhere else, and within my page I have a ViewModel class that has no external dependencies (it's really just a state bag or Data Transfer Object/DTO) that I'll be using for my data binding.  The ViewModel class includes all of the dynamic data elements my page needs to display, and in this case I've put the ViewModel class inside of my codebehind class, but that's just a matter of convenience in this case, and not necessarily a best practice (particularly if you're going to populate the ViewModel from outside of your codebehind class).

## Presenting the Data on the Web

I'm no longer in love with the various data-bound controls that shipped with "classic" ASP.NET, such as the DataGrid and Repeater.  Ultimately, the event-based data binding added way too much indirection and debugging headaches.  I find that I'm much happier with the simpler semantics adopted by the original Active Server Pages and recently popularized by ASP.NET MVC and Web Pages implementations.  To that end, I'm going to construct my HTML pretty much how I want it to look, and then use a simple foreach loop to populate the contents of the table.

For styling the table, I borrowed one of the nice templates from this [Top 10 CSS Table Designs](http://www.smashingmagazine.com/2008/08/13/top-10-css-table-designs/) article, which has some nice options.  The end result is some very clean and readable code.

You can view the actual output [here](http://aspalliancefiles.s3.amazonaws.com/books.htm).

## Export Report to Excel in ASP.NET

In order to export to Excel, we need two things:

1. Some way to tell the page to switch into Excel rendering move (or a different page that only serves Excel).
2. Some way for th epage to tell the browser that the content should be interpreted as an Excel sheet.

The simplest way to achieve the first requirement is to add a link to the page that says "Export to Excel" and simply links back to the same page but adds a querystring parameter.

It's not strictly required that this link have an id or a runat="server" but this is useful if we want to avoid displaying this link in our Excel report.  With this in place, we can add a simple check to the Page_Load() method in the codebehind to determine whether we should render Excel.

Now, finally, we get to the good part.  How do we convert our simple HTML table into an Excel worksheet?  The cool thing is, we don't have to worry about that.  Excel takes care of that for us, by automatically converting HTML (and in particular, tables) into Excel's columns and rows format.  All we need to do is tell the browser that we want Excel to handle this request, and provide a few clues like what the resulting download should be named.  We'll also use this opportunity to hide some HTML-only elements on the page, like the Export to Excel link.

Whatever filename you specify is what the user will be prompted to download.

Excel may warn that the file you are opening is in a different format than the extension (in this case, it's HTML even though we told Excel it was an xls file).  You can simply ignore this prompt, resulting in Excel opening the file.

## Summary

Creating simple reports using ASP.NET is very straightforward.  Adding an option for users to easily export results to Excel is also fairly easy to implement as you've seen here.  Please [download the sample project for this article and run it for yourself](http://aspalliancefiles.s3.amazonaws.com/ExcelReport.zip), and be sure to follow my twitter account ([@ardalis](https://twitter.com/ardalis)) for more tips and tricks related to ASP.NET and software development in general.

Originally published on [ASPAlliance.com](http://aspalliance.com/2054_Creating_a_Simple_ASPNET_Report_with_Export_to_Excel)
