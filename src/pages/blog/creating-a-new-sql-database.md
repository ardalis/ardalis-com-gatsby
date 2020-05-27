---
templateKey: blog-post
title: Creating a New SQL Database
path: blog-post
date: 2008-01-29T14:04:03.693Z
description: "Today I need to set up a new database for a new web site I'm
  working on. Last week, I saw Rick's post about the \"mousercise\" that defines
  the typical table set up in SQL Server 2000 and 2005's table designer. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Cool Tools
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Today I need to set up a new database for a new web site I'm working on. Last week, I saw [Rick's post about the "mousercise" that defines the typical table set up in SQL Server 2000 and 2005's table designer](http://west-wind.com/weblog/posts/237339.aspx). I have to admit that I completely relate to his feelings, and what made his post better still was that in addition to raising a complaint (that I share), he offered a solution! This is one reason why [Rick Strahl's blog](http://west-wind.com/WebLog/default.aspx) is worth reading (and probably has something to do with why he has several thousand more subscribers than my blog). So, in the course of setting up this database (which I'm doing as I write this, and which currently exists on a whiteboard), I have to go through the following steps.

First, I need to actually create the database, which is easily enough done in SQL 2005, though usually the permission for this is not available on the user accounts I use for general querying, so I remote into the DB server, which is hosted extremely well by [ORCSWeb](http://orcsweb.com/), and about a minute later I have the database.

Next I need a way to connect to the thing, so I create a user and come to what has occasionally stalled me for a moment – the password decision. For a while, I had a pretty standard password that was easy to remember (and not terribly secure) that I used for a variety of databases. Lately, I've moved away from that approach and am using a password generator to provide strong passwords which do not depend upon my (lack of) imagination (or the use of 1337-speak). Of course, another issue with passwords and secrets like connection strings is how to store and share them securely. Having a super strong password is useless if you're going to send it along with the credentials it goes with as plain text across the Internet for anyone with a packet sniffer to grab. So for secrets, I now use this [password management software](http://thycotic.com/products_secretserver_overview.html) (Secret Server), from [Thycotic Software](http://thycotic.com/), which is run by my friend and [ASPAlliance author](http://aspalliance.com/author.aspx?uId=45452), [Jonathan Cogley](http://weblogs.asp.net/jcogley). Check it out if you're looking for a better way to store and share your passwords and other secrets, like product keys, etc. Once the user/password were generated and stored in Secret Server and in the database, it was time to move on to the next step, creating the tables.

Here's where Rick's new approach comes in. Normally, it would be time to go into SQL Server Management Studio, open the database, click on Tables, and hit New Table. Not this time. Let's put Rick's use of the Database Diagram Manager to the test. Rick doesn't really cover how to get to the Database Diagram Manager, but basically all you need do is create a new Database Diagram. It will ask you which tables to add – if you're doing this for a brand new database like me, just ignore that. Now you can click on Table View in the toolbar, select Modify Custom, and see the Column Selection dialog. From here, you can add in the columns you typically use for a table that aren't normally in the column row view of the table designer. For me, I picked the following:

**Column Name\
Data Type\
Length\
Precision\
Scale\
Allow Nulls\
Default Value\
Identity\
Description**

These are basically the same one's Rick used, and cover the fields I normally care to set whenever I create a new table. I don't think I've ever cared to set the Identity Seed or Increment to anything other than 1 for each of them, and there are a few other fields that I just never use. So this works for me. Now for the moment of truth. Click OK and then add a new table to the diagram. Doh! It only shows Column Name, Data Type, and Allow Nulls – what happened? Never fear – the last step is to right click on the table, select Table View, Custom. Now you'll see the columns you just set up.

At this point, adding the columns is a breeze and requires little or no use of the mouse, which is how any data entry system (which is basically what initial database setup consists of) should be designed to operate. Thanks for the great tip, Rick!

<!--EndFragment-->