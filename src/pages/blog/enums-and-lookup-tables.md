---
templateKey: blog-post
title: Enums and Lookup Tables
path: blog-post
date: 2003-09-22T23:01:00.000Z
description: Everyone knows (or would know if they’d read [Code Complete] that
  ‘magic numbers’ are a **bad thing** in your code. Enumerated types, or Enums
  in .NET, are a great way to avoid such magic numbers.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Enums
  - Lookup Tables
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Everyone knows (or would know if they’d read [Code Complete](http://www.amazon.com/exec/obidos/tg/detail/-/1556154844/stevenatorasp)) that ‘magic numbers’ are a **bad thing** in your code. Enumerated types, or Enums in .NET, are a great way to avoid such magic numbers. For instance, let’s say I have a content management system which has articles whose state can vary between Draft, Editing, and Production. I could simply use 1, 2, and 3 for these states and remember what each stands for, but that’s going to be really hard to look at six months later when I revisit the code (or if someone else has to read it). In languages without enumerated types, named constants would be a step in the right direction, but truly enums are much more powerful because they allow me to limit the allowable values of parameters to only valid values. For instance, I might have a method for updating the status of an article, called UpdateStatus(), which takes an integer articleId and an integer statusId. There’s nothing to prevent me from sending a -5 or a 300 to the statusId, which of course would not be valid status numbers, but are perfectly acceptable integers. If instead I define the method so that it accepts an integer articleId and an ArticleStatus statusId, where ArticleStatus is an enumerated type, I’m assured that only valid values can be passed to that method (the compiler will enforce that).

Now, it’s frequently the case that the database will contain so-called lookup tables, or tables whose sole purpose is to provide some information about another table through a foreign key. In the above example, my Article table would likely have an ArticleStatusId which would be a foreign key to the ArticleStatus table. ArticleStatus would simply have two columns, ArticleStatusId and Name, and would be considered a lookup column in this case. These provide similar usefulness to enums, but at the database level. By using a foreign key to this table instead of just an integer column without any constraints, I’ve ensured that only valid status ids can exist in my Article table. I can also use the lookup table’s data to populate dropdownlists in the UI to constrain the user’s selection at that level.

Since they serve similar purposes, it would be great if lookup tables could be automatically converted into enumerated types so that developers could get compile-time strong type checking in their applications. With Yukon’s integration of .NET, we may be a step closer to this, but I’m not aware of any such feature coming any time soon. So what often happens is enums and lookup tables are both used, and at some point they get out of synch with one another. An additional status type, e.g. Archived, is added to the ArticleStatus lookup table in the database, but the enum is not updated (which requires the code to be recompiled). This kind of thing will not cause any errors immediately, but it will come back to bite you at some point when you try to use the new value through your compiled application. Some way of notifying you that the database’s values had changed so that you knew to update and recompile your code is needed.

Although probably not the ideal solution to this problem, one solution I’ve devised is to write an enum-to-lookuptable checking unit test, using NUnit. This test passes if the number of rows in the lookup table matches the number of items in the enum, and if each item in the lookup table has a matching value and named item in the enumeration. An example of the test is shown here (note that this uses the Microsoft Data Access Application Block in addition to NUnit 2.1):

<!--EndFragment-->

```
[Test]
public void EnumMatchesTableData()

{
Type enumType = typeof(AspAlliance.Data.Cms.ArticleStatus);

DataTable dt = SqlHelper.ExecuteDataset(AspAlliance.Data.Cms.SqlServer.Configuration.Current.ConnectionString,
CommandType.Text,
“SELECT * FROM ArticleStatus ORDER BY ArticleStatusID”).Tables[0];
Assertion.AssertEquals(“Enum count does not match database count.”,
Enum.GetValues(enumType).GetLength(0),
dt.Rows.Count);
foreach(DataRow row in dt.Rows)

{
int id = Int32.Parse(row[“ArticleStatusID”].ToString());

Assertion.AssertEquals(row[“Name”].ToString().Replace(” “, “”), Enum.GetName(enumType, id));
}
}
```