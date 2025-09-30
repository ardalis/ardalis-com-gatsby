---
title: Review - Iron Speed Designer
date: "2005-06-01T00:00:00.0000000"
description: A walkthrough and review of a powerful Rapid Application Development (RAD) tool for ASP.NET, Iron Speed Designer.
featuredImage: /img/iron-speed.png
---

## Introduction

[Iron Speed Designer](http://ironspeed.com/products/) is a Rapid Application Development (RAD) tool developed by [Iron Speed Inc.](http://ironspeed.com/) Unlike many similar products I've encountered and worked with, Iron Speed Designer has immense breadth and depth of coverage and details. It's been my experience that a particular tool might be good at generating a data access layer, or providing some simple UI for managing the contents of a table. Another might have decent documentation or supporting samples and videos. One of the things that immediately struck me about Iron Speed's product is that it includes all of these things in a single package. Their designer handles the data access layer as well as the user interface, and includes very detailed wizards, documentation, and even video walkthroughs.

In order to put the product through its paces, I constructed a simple link management administration site using the tool. This was a real-world requirement of mine, albeit a fairly simple one.

## Walkthrough

I have a fairly simple link management system I'm working on that includes two tables, one for links and one for categories. There's a simple 1:Many relationship between the two tables, established by a foreign key. Every link must belong to one and only one category. I have a real need for a simple web-based admin for this system, so it seemed like the logical choice for testing out Iron Speed Designer.

My first step was to open up Iron Speed Designer and create a new application. This launches the Application Wizard which asks me for the name of the application, its language, and the folder it should be located in. I entered this information and continued on. Figure 1 shows this first step.

#### Figure 1 - Iron Speed Application Wizard - Step 1

![Iron Speed Application Wizard](/img/iron-speed-step1.png)

Next, I selected a default style for the pages and configured my database connection settings. Figures 2 and 3 show these wizard screens.

#### Figure 2 - Iron Speed Application Wizard - Step 2

![Iron Speed Application Wizard](/img/iron-speed-step2.png)

#### Figure 3 - Iron Speed Application Wizard - Step 3

![Iron Speed Application Wizard](/img/iron-speed-step3.png)

Finally, I specified the two tables I was interested in (TextLink and TextLinkCategory) from my database, and clicked Finish to complete the basic application. Figure 4 shows the database object selection dialog, which also allows views and custom queries to be specified as data sources. Figure 5 shows the final page of the application wizard.

#### Figure 4 - Iron Speed Application Wizard - Step 4

![Iron Speed Application Wizard](/img/iron-speed-step4.png)

#### Figure 5 - Iron Speed Application Wizard - Step 5

![Iron Speed Application Wizard](/img/iron-speed-step5.png)

At this point I chose to Build and Run the application (following the wizard's advice, since I'm a first-time user). The resulting application is shown in Figure 6. The main pages include a tab view across the top with links to each table (or main object) involved in the application. Below this, there is a search area that includes some default search and filtering options. All of this is completely configurable. The search results default to the contents of the table, but of course these can be adjusted as well, and each row includes options to edit, view, or delete the record (and of course there is also a 'New' button for adding new records).

#### Figure 6 - Our Generated Application

![Iron Speed Application Wizard](/img/iron-speed-application.png)

When adding or editing a record, a new screen is displayed allowing for a rich user interface (not just a grid view). Figure 7 shows the generated page for adding a new text link. As you can see, it includes special controls specific to the data type of the column, including datepicker controls for the two date columns.

#### Figure 7 - Add Text Link Generated Page

![Iron Speed Application Wizard](/img/iron-speed-generated-page.png)

If I try to save the record without filling out all of the columns that do not allow nulls, I'm automatically told the error of my ways. The same is true if I try to put a non-date string into a date column. I'm told that the data is invalid or out of range. Not bad for not having written any code. What if I enter an End Date that occurs before my Begin Date? Well in that case, it lets it through.

One failure of many code generation tools is that they are fire-and-forget – they're nice to use to get started, but after that, you can't use them again because they will overwrite all of your customizations you've added. And since no code generator is realistically going to create 100% of your application without any need for additional tweaking, this is a major disadvantage. One of the nice things about Iron Speed Designer is that its designer automatically keeps all of your customization code separated from its generated code. That means that I can modify things and then later on, when I want to add another table to this application, I can simply re-generate the application and all of my custom code will still be intact (and, if I didn't break anything with my table changes, functional).

Getting back to my customization attempt (to ensure that the end date is on or after begin date), I simply right-clicked on the End Date text box in the Iron Speed Designer and selected Add Code Customization. A new wizard appeared, which includes several dozen options for common customization features. Scrolling down to the validation options, I go through a wizard that automatically lets me wire up a custom validator to my End Date field. This code is placed in a 'safe' codebehind class, which is safe from being overwritten by subsequent code generations. Opening up this safe file, I'm able to edit the validation code (there are, in this case, even comments on how to do exactly this task, so a bit of cut-and-pasting makes the job that much quicker). Figure 8 shows the final code, which worked on the first test.

#### Figure 8 - Customizing Field Validations

```csharp
/// <summary>
/// This method implements server side validation logic for the EndDate field.
/// </summary>
private void V_EndDateFVCustomValidator_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
{
 // We can refer to the Begin Date FieldValue control directly as
 // V_BeginDate. So now, get the Begin Date
 DateTime StartDate = this.V_BeginDate.GetFieldValue().ToDateTime();

 // Get the End Date. This is passed as a String.
 DateTime EndDate = DateTime.Parse(args.Value);

 // Now compare the two values and report an error message
 if (EndDate < StartDate)
 {
 args.IsValid = false;
 // Set the error message. Error message will get reported in a dialog.
 this.V_EndDateCustomValidator.ErrorMessage = "End Date occurs before Start Date";
 }
}
```

As I mentioned, there are literally dozens of code customizations built into the code customization wizard, each with a description, step-by-step instructions, and a preview of the generated code. I was very impressed with the level of hand-holding the tool provided every step of the way. It wasn't like many other code-gen tools where once they've generated the basics, you're left to your own devices to move forward (and forget about re-generating the basics without blowing away your customizations).

## The Design Environment

One other thing I'd like to cover is the designer itself. The designer offers a very good WYSIWYG view of each page that is created for the application. The code editor lacks some of VS.NET's features, like Intellisense, but is otherwise adequate, and the beauty of this is that you very rarely need to write very much code. Figure 9 shows the designer, scrunched down to make it fit most screen widths. The toolbox is normally open and includes all the tools you need to customize any of these pages with your own search boxes, editable grids, etc. Also, the various 'rich' controls include Configure links on the design surface, which allow you to easily customize how they are displayed or how they are wired up to the database.

![Iron Speed Designer GUI](/img/iron-speed-designer.png)

## What's Not To Like?

I firmly believe that no review is terribly useful if it doesn't include some *needs improvement* items. For Iron Speed Designer, I ran into a few issues that on the whole were pretty minor, but which bear mentioning. Building the application can be fairly slow if you start getting into a large number of tables. For the two-table application shown in this walkthrough, things were pretty quick, but for another sample I created which included 8 or 10 tables, the build process took a significant amount of time (more than a few seconds), a lot of which appeared to be time spent communicating with the database updating stored procedures. This likely would have been faster if I had been working with a local database as opposed to a remote one via the Internet, so it's likely more of a problem with my lack of sufficient bandwidth than with anything Iron Speed could fix. However, since most of the time I wasn't modifying anything with the stored procedures, it might have optimized the build process by keeping track of whether or not things had changed with respect to the database, instead of re-running the scripts on every build.

Another issue I encountered had to do with trying to customize which columns were returned from the search results of a query. This too was with my larger sample, and the end result was that I kept getting the default columns returned in addition to my specifically selected columns. This is very likely user error, and my next step was going to be to try out [Iron Speed's Developer Forums](http://ironspeed.com/support/UserForums.aspx) to see if I could get a quick fix there, but my publication schedule didn't allow time for that.

## Coolest Features

The two things that I found most compelling about Iron Speed Designer were its attention to detail and its ability to handle just about every task I threw at it with a menu item or wizard. I very rarely had to drop down into writing code myself, even to add custom behavior to the application. I'm confident that if I continued to work with the product, I would be able to produce data management applications in a fraction of the time it would take me to write them in.NET myself by hand.

I also found the video documentation and demos to be very well done. If the screen shots here aren't sufficient for you, watch the 5 minute (or so) [video demo](http://www.ironspeed.com/products/ProductVideo.aspx).

## Pricing

You'll find pricing information [here](http://www.ironspeed.com/products/Pricing.aspx). There are a variety of pricing options – the most economical for an individual seems to be the Professional Edition, for a few hundred dollars (without add-ins).

## Summary

I've used a variety of RAD tools for.NET in the past few years, including a couple of ORM tools, DAL generators, and template-based code generators. None of the others I've used have come close to Iron Speed Designer in terms of breadth and depth of features and attention to detail. The feature set is great, but not only that, the extensibility (which most other tools also offer) is available within the designer and with little if any code required. What's more, there's actually very good documentation, including video walkthroughs for many common scenarios.

If you'd like to try it out yourself, you can [download a demo](http://www.ironspeed.com/download?c=AspAlliance).

## Additional Resources

[Product Showcase on AspAlliance.com](http://aspalliance.com/ironspeed/)

[Iron Speed Designer Home](http://ironspeed.com/products/)

[Iron Speed User Forums](http://ironspeed.com/support/UserForums.aspx)

[Iron Speed Video Demo](http://www.ironspeed.com/products/ProductVideo.aspx)

Originally published on [ASPAlliance.com](http://aspalliance.com/681_Review_Iron_Speed_Designer)

