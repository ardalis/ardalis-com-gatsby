---
templateKey: blog-post
title: Case Sensitive or Insensitive SQL Query
path: blog-post
date: 2007-09-30T11:44:07.064Z
description: "Suppose you need to perform a SQL query and you need for it to be
  case sensitive or case insensitive, an either your database is set up the
  opposite way or you're smart "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL Query
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Suppose you need to perform a SQL query and you need for it to be case sensitive or case insensitive, an either your database is set up the opposite way or you're smart and you're trying to write your query so that it will work regardless of how the database may or may not be configured. For instance, consider this query:

<!--EndFragment-->

```
SELECT UserId, email
FROM aspnet_membership 
WHERE email = 'billg@microsoft.com'
```

<!--StartFragment-->

If your database contains an email for Bill like this one: [BillG@microsoft.com](http://ardalis.com/mailto:BillG@microsoft.com) then whether or not your query will return any rows will depend on the COLLATION for the database. If you want to ensure that you DO get results, you can force it to use a CASE INSENSITIVE collation like so:

<!--EndFragment-->

```
SELECT UserId, email
FROM aspnet_membership 
WHERE email = 'biilg@microsoft.com' COLLATE SQL_Latin1_General_CP1_CI_AS
```

<!--StartFragment-->

Similarly, if you don't want it to return any rows unless you specify the correct case for the email, you would change the collation to replace \_CI\_ with \_CS\_ where CI is short for Case Insensitive and CS is short for Case Sensitive. The following query would not match [BillG@microsoft.com](http://ardalis.com/mailto:BillG@microsoft.com) because it is using a case sensitive collation.

<!--EndFragment-->

```
SELECT UserId, email
FROM aspnet_membership 
WHERE email = 'billg@microsoft.com' COLLATE SQL_Latin1_General_CP1_CS_AS
```

<!--StartFragment-->

Also note that most of the time, passwords are expected to be case sensitive, so you can improve the security of your system by forcing any check comparing the password to use case sensitivity. However, if you're using hashed passwords (which you should be) then this is a non-issue since your hash algorithm will likely return all caps or all lowercase depending on how it is configured, and as long as you use the same hash settings when you set the password and when you check it, the collation of the database will not matter.

<!--EndFragment--><!--StartFragment-->

**Update:** [Kimberly Tripp (SQL Goddess) has some more to say on this subject](http://www.sqlskills.com/blogs/kimberly/2007/10/03/ThePerilsOfCaseinsensitiveDataAndOurLifeInTangentland.aspx).

<!--EndFragment-->