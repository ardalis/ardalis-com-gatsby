---
templateKey: blog-post
title: .NET Data Access Performance Comparison
date: 2005-02-16
path: blog-post
description: This article attempts to compare several different data access techniques through the use of a stress testing tool. DataTables and DataReaders are compared with a number of different variables, and recommendations for best practices are provided.
featuredpost: false
featuredimage: /img/dotnet-data-access.png
tags:
  - .net
  - dotnet
  - data access
category:
  - Software Development
comments: true
share: true
---

[Download Sample Files](http://aspalliance.com/download/626/DataAccessPerfFiles.zip)

## Introduction and Background

In .NET, there are several ways to extract data from a data source.  The two most common techniques using ADO.NET involve the use of the DataReader or the filling of a DataSet or DataTable with a DataAdapter. In this article, a very easy-to-reproduce set of tests is analyzed to determine which techniques performs the fastest.  Further, additional variables such as N-Tier architecture and the effects of caching on the results are considered.  Finally, I recommend some best practices based on the results.

### Background

I’ve been interested in the debate between DataReaders and DataSets ever since .NET’s first preview was made available.  The conventional wisdom has always held that DataReaders are the best way to go, offering the smallest memory footprint and the fastest access to the data.  However, while I don’t argue these points, DataReaders have always been a dangerous tool to use, especially in an N-Tier application, in which an open DataReader is passed up from the data access layer to a business or user interface layer, thereby delegating the responsibility for closing the DataReader to those layers.  I have personally been burned by the effects of unclosed DataReaders on a busy site, and so for a long time I was rather religiously against the use of DataReaders unless they were opened and closed within the same method.

More recently, I’ve come across a few techniques that make using DataReaders across tiers safe.  One such technique is detailed in [Teemu Keiski’s article](http://aspalliance.com/526).  Another is found in the opening pages of Steven Metsker’s [Design Patterns in C#](http://www.amazon.com/exec/obidos/ASIN/0321126971/aspalliancecom).  Both of these techniques take advantage of delegates to enable a DataReader to be accessed from a higher tier in the application while still forcing control of that DataReader to pass through the data access layer method prior to its destruction (allowing for proper cleanup).  In this way, it is possible to pass an open DataReader from one tier to another without the risks that would otherwise be involved.

Just how great is the risk, and how large is the problem, when a DataReader is accidentally left open?  That was another of my questions that I sought to answer when I began this testing.  I had seen the empirical effects on one of my sites, but I didn’t know the exact effects in a controlled environment.  I was quite surprised to see just how devastating the effect such a simple error could have on a busy site.

## The Environment

I actually wrote these tests while offline with only my laptop at hand, so they utilize nothing but local resources.  I created a solution in VS.NET and added to it a web project and an Application Center Test project (located under Other Projects in the Add Project dialog).  I’ve used ACT a number of times in the past, but I’d never used it from within VS.NET, so I thought I’d give it a shot.  It was actually pretty nice.  It lacked some of the pretty graphs and other reports that I was used to seeing in ACT, but it did let me do my coding and my testing all without ever leaving VS.NET.  In addition to VS.NET, the tests also required IIS (I’m running on Windows XP Pro) and a database (SQL Server 2000, also running locally).

My hardware was a Dell Inspiron 8000 laptop with an 850MHz P3 processor and 512mb of RAM.

Now, before I get into the actual tests, let me concede right off that this is not meant to be a model for how a production website would perform.  For one thing, having VS.NET and other applications running on the machine affects the performance.  For another, it’s very rare that one would have a production web application running on the same hardware as the database used by that application.  That said, since the environment was kept constant between iterations of the tests, the results, while perhaps not empirically reflective of true server performance, should at least provide a good comparison of the various techniques employed, relative to each other.

## The Test

For the sake of simplicity (and partly because ACT is quite simple, especially from within VS.NET), nothing too fancy was employed for the tests.  In fact, I ran the exact same test for each iteration.  The test script simply loads the default.aspx page from the web project one time.  That’s it.  I configure ACT to use 5 concurrent connections, no delays between connection attempts, and to run the test for 5 minutes following a 30 second warm-up period.

Once again, this kind of test is not indicative of a real-world scenario by any means.  For one thing, there is only one page involved, whereas a real application test would involve a variety of users going through several different paths.  More importantly, real users do not simply hammer the application with requests at lightning speed – they pause between requests as they read or work through each page in the application.  This is reflected by something called ‘think time’ in many performance testing products but is not taken into consideration by these tests.  Thus, while there will be some raw requests per second numbers derived from these tests, these numbers to not correspond to the number of users the application might support.  They are simply useful for comparison’s sake.

## The Scenarios

All of these scenarios use a single default.aspx page to connect to the Pubs database on the SQL Server database and pull back the contents of the Authors table.  To avoid any extra processing overhead from data binding and rendering, the page simply has a label that is updated with the count of the total number of authors, which is found via a DataTable property or by looping through all the rows of a DataReader.  For all of these tests I am using the SqlClient namespace, rather than OleDb, to connect to the SQL Server.

Initially I simply wanted to compare a DataReader with a DataTable.  However, after I ran these tests, I thought of several other variables that I wanted to consider.  What if the DataReader wasn’t properly closed?  What if the DataTable were cached--one of the big advantages of DataTables over DataReaders?  Finally, I compared the delegated DataReader approach, testing its performance both when its client properly disposed of it and when it was left open for the DAL to clean up.  The results are discussed in the following section.

## The Results

The overall winner was the cached DataTable, with an average of 132 requests per second.  The DataReader method, whether using delegates or properly closed by the calling function, averaged about 112 requests per second.  The uncached DataTable averaged 99 requests per second.  The real surprise to me was the unclosed DataReader.  I knew it would have a negative impact on performance, but even I (who long considered them ‘evil’ for this reason, before learning of the delegate approach) didn’t expect it would be this bad.  The unclosed DataReader averaged just 7 requests per second.

Another important consideration for web performance is the per-request time required.  This is measured by the TTLB, or Time To Last Byte, which records how long it took from when the request was made until the last byte of the response was sent to the client.  These corresponded directly to the requests per second, in this case, with the cached DataTable taking 8ms, the DataReaders taking 30ms, the uncached DataTable taking 35ms, and the unclosed DataReader averaging 661ms.

A summary of the results is listed below.  What the summary doesn’t show, but which is also worth noting, is that while all the other tests had more-or-less constant requests per second for the duration of the test, the unclosed DataReader behaved erratically.  It would run for several seconds with 20 or more requests per second, then it would simply hang, and process no requests at all for 15 or 20 seconds at a time.  (Most likely this behavior is due to the connection pool being tapped out and not releasing connections until they time out.  However, I have not proven this to be the case.)  It was also the only test that resulted in HTTP errors, of which it recorded 90 during the 5 minute test run which included 2,141 requests.

| **Scenario**                           | **Req/s** | **TTLB (ms)** |
|------------------------------------|-------|-----------|
| Cached DataTable                   | 132   | 8.34      |
| Unclosed DataReader Using Delegate | 113   | 30.13     |
| Closed DataReader Using Delegate   | 112   | 30.26     |
| DataReader Closed by Client        | 112   | 30.76     |
| DataTable                          | 99    | 35.97     |
| DataReader Left Open by Client     | 7     | 661.88    |

## Recommendations for Optimal Performance

Based on the results of these tests, I have several recommendations for optimal data access performance.  The first recommendation is that caching be used wherever possible.  These tests demonstrated that even when no network latency is involved between the application server and the database, accessing a cached DataTable was 17% faster than using a DataReader to hit the database (network latency would greatly increase this advantage, as the latency time would be added for every row of data the DataReader returned).  In cases where caching is not appropriate, however, the DataReader is clearly faster than the DataTable, beating it by about 12% in these tests.  However, when using the DataReader, it should always be wrapped in a using statement to ensure that it is properly disposed of.  A single unclosed DataReader on a given site could cause the site to become unresponsive, and resulted in a 93% degradation in performance in these tests versus properly destroyed DataReaders.

Listing 1 shows an example of a Data Access Layer method for returning a DataReader, using a Delegate technique, and the delegate definition.

#### Listing 1 - Returning a DataReader Using a Delegate To Ensure Cleanup

```csharp
public delegate object BorrowReader(IDataReader reader);
 
public static object LendAuthorsReader(BorrowReader borrower)
{
      using(SqlConnection conn = new SqlConnection(_connectionString))
      {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Authors", conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            return borrower(reader);
      }
}
```

To call the method from a business object or ASP.NET page, the code would look something like this:

```csharp
Data.LendAuthorsReader(new Data.BorrowReader(DisplayDelegateReader));
```

The code that actually uses the Reader is found in the DisplayDelegateReader method, which must match the delegate defined above, that is, it must return object and must take a single IDataReader parameter.  Listing 2 shows the method used in these tests.

#### Listing 2 - Calling the Data Access code and using the DataReader

```csharp
private object DisplayDelegateReader(IDataReader reader)
{
      int authorCount = 0;
      while(reader.Read())
      {
            authorCount++;
      }
      reader.Close();
 
      if(authorCount > 0)
      {
            ResultLabel.Text = authorCount + "authors found.";
      }
      else
      {
            ResultLabel.Text = "Failed to find authors.";
      }
      return null;
}
```

## Summary and Resources

In summary, this was just a very, very simple showdown between a few of the most common data access scenarios.  If you are trying to decide which data access technique to use for your application or within your organization, please refer to the resources listed below for additional information on caching and data access performance, and then run your own tests.  Using ACT or [LoadRunner](http://www.mercury.com/us/products/performance-center/loadrunner/) or [ANTS](http://red-gate.com/dotnet/summary.htm), it is not difficult to test a sample application with a variety of data access techniques and evaluate which one will be best in your particular situation.  In fact, because there are so many variations between applications and architectures, running your own tests is really the only way you can be sure what will be best for you.  The downloadable code provided with this article should give you an easy starting point if you have never done any performance testing using ACT before.

### Resources

[Performance Comparison: Data Access Techniques (MSDN, 2002)](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnbda/html/bdadotnetarch031.asp) Required Reading!

[ASP.NET Caching: Techniques and Best Practices (MSDN, 2003)](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnaspp/html/aspnet-cachingtechniquesbestpract.asp)

[Creating a Cache Configuration Object for ASP.NET (MSDN, 2003)](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnaspp/html/aspnet-createcacheconfigobject.asp)

[Monitoring Your Web Application](http://aspalliance.com/126)

[ASP.NET Micro Caching: Benefits of a One-Second Cache](http://aspalliance.com/251)

[Review: Red Gate ANTS Profiler](http://aspalliance.com/516)

Originally published on [ASPAlliance.com](http://aspalliance.com/626_NET_Data_Access_Performance_Comparison).
