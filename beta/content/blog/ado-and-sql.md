---
title: Basic ADO and SQL Tutorial
date: "2000-09-25T00:00:00.0000000"
description: Learn how to use the ADO Connection, Command, and RecordSet object with simple SQL statements with ASP (Active Server Pages).
featuredImage: /img/ado-sql-tutorial.png
---

## Introduction

*Author's note: This was originally published in September 2000. It has been only slightly revised and republished in March 2005. Also, if you're just learning ASP, I strongly recommend you jump to ASP.NET instead.*

Return to this site often with your questions about data access in ASP. If you have specific questions, please email them to me. The purpose of this tutorial is to give you basic familiarity with data access using Active Server Pages. This page will also include a FAQ(Frequently Asked Questions) page, which will most likely duplicate some of the very important knowledge listed on other FAQs on this site, but which many new users still ask on the newsgroups and listservs several times per week. I figure this increases the chance that the right person will find the answer to their question before wasting bandwidth.

To access the FAQ, click here (sorry! no longer available!). Otherwise, continue on with the ADO tutorial, beginning in 3... 2... 1... start:

Greetings! Welcome to Data Access with Active Server Pages 201. Hopefully you've completed the 100 course series which is recommended but not required prior to signing up for this course. This course is graded pass/fail based on attendance only, so you need not fear for your grades. My name is Steve and I'll be your instructor.

To begin, you will need a machine on which you can test some sample scripts. The easiest way to accomplish this if you haven't already done so is to download ASP from Microsoft and install it with PWS on your Win95 or WinNT box. There are plenty of resources available for describing how to do this, so I won't waste any more time on it. (If you have XP Pro, and install IIS, you'll have ASP. If you have XP Home, you're out of luck unless you can hack it to host a webserver for ASP -- if you want to do ASP.NET, then you can use [Cassini](http://www.asp.net/Default.aspx?tabindex=6&tabid=41)).

## Connection Object

Now that you have a machine on which to practice, the first thing that is required for you to start using a database with your ASP pages is a connection. Using your editor of choice (Visual Interdev 6.0 is very nice because it has Intellisense, which will help you see the methods and properties of the various ADO objects), write the following code:

```cs
 Session("DB_ConnectionString") = _"DSN=myDSN;UID=myUID;PWD=myPWD;DB=myDB;HOST=myHOST;SERV=MyService;SRVR=MyServer;PRO=MyProtocol;"
 Dim objConnect 'Declare the connection variable
 'Set up Connection Object
 Set objConnect = Server.CreateObject("ADODB.Connection")
 objConnect.Open Session("DB_ConnectionString")
```

Notice that I'm using a Session variable for the connection string. This is useful if you plan on using the same database for multiple ASP pages, which is often the case. If you are using Visual Interdev, you can use the data connection wizard to create this Session variable for you. In VI 1.0, you do this by clicking on Project - Add to Project - Data Connection. If you do not already have a DSN, this will also let you create one. **MAKE SURE YOU USE A SYSTEM DSN!** If you use a File DSN, then the default web user account on Windows NT (IUSR_MACHINENAME) will not be able to access the database. Also note that many of the parameters in the connection string above are not necessary if you are using a database on the same machine as your server. In fact, you do not even need to use a DSN. An alternative, if you have the database as a file on your web server, is to do the following:

```csharp
Dim objConnect 'Declare the connection variable
Dim cnpath 'Connection path to database file
'Set up Connection Object
Set objConnect = Server.CreateObject("ADODB.Connection")
cnpath="DBQ=" & server.mappath("/path/database.mdb")
objConnect.Open"DRIVER={Microsoft Access Driver (*.mdb)}; " & cnpath
```

This assumes that the database is located within your web directory, in the subdirectory"path". You can set cnpath to"C:\path\database.mdb" if you want it to use any path on your machine. Once you have established a connection, you are ready to move on to recordset and command objects.

Also note that you could (and should) use an Application variable instead of a Session variable, assuming everybody on your site will be connecting to the same database, which is typically the case. Finally, it is very important that you only open connections when you need them, and that you keep them open as briefly as possible. As soon as you're finished with them, call `Connection.Close`.

## Command Object

Most ASP texts will jump right into recordsets once you have established your connection. However, if you learn to use the command object right from the start, you'll find that it makes manipulating recordsets much simpler and gives you more options. First, you must create the command object. You do this with the following piece of code:

```csharp
'Create Command Object
Dim objCmd 'Declare the command variable
Set objCmd = Server.CreateObject("ADODB.Command")
Set objCmd.ActiveConnection=objConnect
objCmd.CommandType = adCmdText
```

Note that you set the command object's `ActiveConnection` property to your connection object, which you created above. Also note that, in this case, our `CommandType` is text. This allows us to send SQL commands directly to the database server. If you are using SQL Server as your database, the other command types may prove useful, but for most third party databases, such as Oracle or Informix, you are best off sticking with adCmdText. Also note that adCmdText is a *constant*. The numeric equivalent is 1. The ADO constants are in a file called adovbs.inc. If you have not already included this file in your current page, locate it(it is installed with ASP - just use the windows Find File command to locate it), copy it to your web directory and rename it adovbsinc.asp. Finally, add this line to the very top of your ASP page:

```html
<!--#INCLUDE VIRTUAL="/yoursubdirectory/adovbsinc.asp"-->
```

The reason for renaming it is for security purposes -- malicious users can more easily access a file on your server ending in.inc than one ending in.asp. Although this file is rarely changed and most ASP developers know its contents, it's just good practice not to have any of your code visible to web users.

Now you will be able to use any of the constants found in the rest of this tutorial. Before you can actually use a command object, you need to create a recordset object which references it. So without further ado...

(Update: this isn't entirely true - you can use the Command object without a Recordset to perform database operations that do not return a result set)

## Recordset Object

The Recordset object is the primary object you will work with when you are accessing data using ASP and ADO. A Recordset is essentially a database cursor, which you can page through to view each row of a query or table. To begin with, we'll declare our recordset:

```csharp
'Create Recordset Object
Dim objRst 'Create Recordset Variable
Set objRst = Server.CreateObject("ADODB.Recordset")
Set objRst.ActiveConnection = objConnect
Set objRst.Source = objCmd
```

Note that our Recordset references our connection *objConnect* and our Command object, *objCmd*. This is the minimal requirements for a recordset that uses the command object. You can get away with fewer parameters when declaring your recordset, if you opt not to use the Command object (in fact there are a few different ways to set up your recordset), but I won't cover them here. You should understand two additional parameters for your recordset which can affect how your query performs. They are the `CursorType` and `LockType` properties. Each of these has 4 possible values. The default values give you a Read-Only, Forward-Only recordset. For the operations we will be performing in this tutorial, the default options are ideal. If you choose to use the Recordset object instead of the Command object for your updates and inserts, you will need to become more familiar with the Cursor and Lock types. Here is an excerpt from the adovbs.inc file, listing the cursor and locktypes:

```csharp
'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4
```

Note that Cursor is 0 to 3 and Lock is 1 to 4. Don't ask me why Microsoft did it this way. To set these properties, you would use code like:

```csharp
'Set Locktype and Cursortype
Set objRst.Locktype = adLockReadOnly
Set objRst.Cursortype = adOpenForwardOnly
```

Now that we've managed to declare all of our necessary objects, we're finally ready to access some data. The first thing you need to do is test out an SQL query to make sure it returns some results from your database. A simple"SELECT * FROM TableName" will suffice. Use your query for the CommandText in the following piece of code, with a valid column name in place of"field":

```csharp
objCmd.CommandText ="SELECT * " & _" FROM mytable "
objRst.Open
If Not objRst.EOF Then
Response.Write(objRst("field"))
End If
objRst.Close
```

When you execute this SQL query, it will print the first record's"field" value. If no values exist, it will do nothing. If you do not test for EOF before attempting to access recordset values, you will generate a run-time error (when you reach EOF). Always test for EOF before attempting to access your recordset. Note that I immediately close the recordset. Get in the habit of closing your recordsets as soon as you are finished using them, especially within loops. If you attempt to open a recordset that is already open, you will generate a run-time error.

Update: If you loop through a recordset, make sure you call objRst.MoveNext within your While Not objRst.EOF loop. Otherwise you'll enter an infinite loop. This is an extremely common mistake. Also, avoid looping through recordsets. A much faster technique is to use GetRows, which will return the results in an array. Here's [some more info on GetRows](http://authors.aspalliance.com/nothingmn/view.asp?print=true&aid=27).

So far we haven't done anything that required the use of the command object, although it is a nice debug tool to be able to write out the CommandText property to check your SQL. The next example demonstrates why the Command object works better than the ADO recordset object for manipulating the data in your database.

```csharp
objCmd.CommandText ="UPDATE mytable SET " & _" field = 'Somevalue'" & _" WHERE field = 'Some Other Value' "
objRst.Open
```

Note that for this Command, you do not need to close your recordset. This command uses your database's own UPDATE routine, which will almost always be far faster than using ASP's ADO Recordset object to perform your update. Ideally, you should move all critical database calls to stored procedures on your database server, but the above method is almost as efficient. Similarly, you can perform the following statements using your database:

```csharp
objCmd.CommandText ="DELETE FROM mytable " & _" WHERE field = 'Some Other Value' "
objRst.Open
objCmd.CommandText ="INSERT INTO mytable " & _" (field1,field2) " & _" VALUES ("this value","this other value")"
objRst.Open
```

Note once again that I didn't have to close the recordsets between operations, because they do not result in any data being sent to the recordset. You only need to worry about closing your recordset/command object combination when you are performing SELECT statements.

**Update**: You really really really should use stored procedures for your database access, for security reasons as well as performance. Using SQL in your page comprised of strings concatenated together opens up your code to [SQL Injection Attacks](http://msdn.microsoft.com/msdnmag/issues/04/09/SQLInjection/default.aspx).

## Summary and Resources

This concludes this tutorial for basic access. For an example of how to make data connections even simpler, check out the Data Connection Procedures article.

More Resources:

- [W3Schools ADO Tutorial](http://www.w3schools.com/ado/default.asp)
- [W3Schools SQL Tutorial](http://www.w3schools.com/sql/default.asp)
- [AspAlliance SQL Articles](http://aspalliance.com/articles/LearnSQL.aspx)

Got Questions?

- [ASPAdvice Community](http://aspadvice.com/)
- [SQLAdvice Community](http://sqladvice.com/)

Originally published on [ASPAlliance.com](http://aspalliance.com/655_Basic_ADO_and_SQL_Tutorial)

