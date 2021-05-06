---
templateKey: blog-post
title: ASP.NET MVC 3 Scaffolding Quick Start
date: 2011-04-26
path: blog-post
description: Using the latest ASP.NET MVC 3 tools, it's very quick to go from simple C# classes to working data management screens with a generated backing database. This article walks through the basics of getting started with this approach.
featuredpost: false
featuredimage: /img/mvc-3-scaffolding.png
tags:
  - ASP.NET MVC
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

One of the new features in ASP.NET MVC 3 is its scaffolding feature, which basically lets you very quickly produce data entry controllers and views based on a particular model, even if you don't yet have a database in place.  This can let you very quickly produce a proof-of-concept, or iterate through some design options, without the need to go through a big process of setting up a database, tables, stored procedures, etc. just to show the customer how the UI might work with a given set of data.  To use this feature, you'll want to [get the latest ASP.NET MVC 3 tools](http://www.microsoft.com/downloads/en/details.aspx?FamilyID=82cbd599-d29a-43e3-b78b-0f863d22811a).

## Scaffolding a Model Class

We'll start with a simple model class that intentionally uses a few different data types.

It's important that we annotate a property as being a `[Key]` in order for the scaffolding to work properly.  We can also specify many other metadata properties using attributes from the System.ComponentModel.DataAnnotations namespace, but for now we'll stick with just the `[Key]`.

Now that we have this class, the next step is to add a Controller for this class by right-clicking on the Controllers folder in Solution Explorer.

Fill in the resulting window with the name of the model class, the template to use (I'm using the default Entity Framework read/write template), and the data context class.  Since I'm starting from a brand new project, I don't have a data context class yet, so I selected `<New data context>` from the list of options, and named the class `BookContext`.

Once you click Add, you should see a number of new items added to your project.

More interestingly, if you simply run your web application at this point and navigate to /book, you will see that you now have a working Controller and View for managing a collection of books.

Click Create New, fill in the form, and you'll see you now have full CRUD-L (Create, Read, Update, Delete -- and List) access to your model class.

Note that the display name for PublicationDate isn't necessarily how the user would expect.  We can fix that with some annotations on the Create/Edit views, though on the Index view for now I'm just fixing it manually.  Adding the attribute [Display] to the property allows us to specify a Name to show.

Note that if you change your model, you're likely to get an error regarding the database being out of sync with your model.  Looking at the generated code for the BookContext, we see a comment which has the line of code needed to fix this issue, assuming you are ok with deleting your database on every application start!

Once this is added to Global.asax the error disappears and we're able to continue working on our model, its annotations, and the look and feel of our scaffolded CRUD views and controllers.

## Summary

The latest tools for ASP.NET MVC 3 make it extremely easy to get started with a data driven application starting with code.  You can quickly create a model in C#, provide a few simple annotations to specify key values, display names, and validation constraints, and then simple but functional data management screens are a few clicks away.  The result, while easy to produce, is generally good code (though it would be a better design not to call the data context directly from the controller, but rather to inject it via an IRepository interface) that can easily be tailored to suit production requirements.

[Download the sample code for this article here.](http://aspalliancefiles.s3.amazonaws.com/MVC3ScaffoldingQuickStart.zip)

Originally published on [ASPAlliance.com](http://aspalliance.com/2055_ASPNET_MVC_3_Scaffolding_Quick_Start)
