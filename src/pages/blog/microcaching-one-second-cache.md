---
templateKey: blog-post
title: ASP.NET Micro Caching - Benefits of a One-Second Cache
date: 2004-05-03
path: blog-post
description: When I start talking about caching, I imagine that many people immediately stop listening, thinking "my situation requires up-to-the-minute data, so caching isn't an option". Consider the benefits of what I call 'micro caching', in which data is cached for a very small amount of time. In high volume applications, the benefits can be substantial.
featuredpost: false
featuredimage: /img/micro-caching-title.png
tags:
  - asp.net
  - Caching
category:
  - Software Development
comments: true
share: true
---

## Introduction

I fell in love with caching when I first started playing with it in the early versions of the ASP.NET alphas.  I was aware of caching before that, but I'd never really gone to the effort to seriously implement a cache engine in an ASP app, and with ASP.NET, I didn't have to.  The thing that attracts me to caching is its impact on performance without requirements (usually) for major re-architecture of the system.

In this article, I'm going to discuss what I call *Micro Caching*, because it involves caching things for very brief periods.  One of the major downsides of caching in general is that by definition the data is not fresh.  How big a problem this is depends on the application and the user's requirements, which is why it is important to determine the user's tolerance for stale data when gathering requirements.  The knee-jerk answer is going to be 'I need live data all the time', but hopefully with the data in this article, you will be able to convince the user/client that perhaps it would be ok if the data were, say, a second or two old, if it meant they could host the application on half as much hardware.

## Server and Test Setup

The test server had the following specifications:

- 1GHz P3 Processor
- 512MB RAM
- Windows Server 2003
- SQL Server 2000

To test the page, I used Application Center Test (ACT), running locally.  Everything in this test is running on one box, which I realize has some implications as far as where the bottlenecks in performance will occur.  During all tests the CPU was maxed out, indicating that increased performance could have been achieved with a more powerful box and/or by splitting the work between several servers.  However, the point of this test was not to achieve the maximum performance possible for this trivial example--it was to measure the effects of a small amount of caching on a simple but high-volume application.

The test script consisted of a single request to my default.aspx page.  The script was constructed to use three simultaneous users for five minutes with thirty seconds of "ramp-up" time (to ensure the app had compiled and the sql server was awake and running full speed).  ACT, unlike other tools such as LoadRunner, does not let you add "think time" between users' requests without editing the vbscript by hand, so although there are only three users, they are hammering the server because there is no delay between the completion of one of their requests and the initiation of their next request.

## Test Page Without Caching

I created a simple ASP.NET page that calls "SELECT * FROM Products" against a local instance of the Northwind database, fills a DataSet with the result, and binds it to a DataGrid.  To limit the web server overhead, I disabled ViewState and SessionState on the page.  The page's code without caching was as follows:

#### Default.aspx

```aspnet
<%@ Page language="c#" Codebehind="Default.aspx.cs" AutoEventWireup="false" Inherits="MicroCache._Default" EnableSessionState="false" EnableViewState="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
 <HEAD>
  <title>Products</title>
 </HEAD>
 <body MS_POSITIONING="FlowLayout">
  <form id="Form1" method="post" runat="server">
   <asp:DataGrid id="DataGrid1" runat="server"></asp:DataGrid>
  </form>
 </body>
</HTML>
```

The codebehind performed the logic as follows:

#### Default.aspx.cs (excerpt)

```csharp
 public class _Default : System.Web.UI.Page
 {
  protected System.Web.UI.WebControls.DataGrid DataGrid1;
 
  private void Page_Load(object sender, System.EventArgs e)
  {
   BindGrid();
  }

  private void BindGrid()
  {
   SqlConnection conn = new SqlConnection("server=localhost;database=northwind;integrated security=true");
   SqlDataAdapter cmd = new SqlDataAdapter("SELECT * FROM Products", conn);
    DataSet ds = new DataSet("Products");
   cmd.Fill(ds);
   DataGrid1.DataSource = ds;
   DataGrid1.DataBind();   
  }
...
}
```

## Results Without Caching

Running the test without any caching on the web server resulted in 16,961 requests and an average requests per second of 56.54.  The Time to First Byte (TTFB) and Time to Last Byte (TTLB), which are useful measures of the site's performance from an individual user's perspective, were both 52ms--instant as far as a user is concerned.  For most web applications, anything under one second is an acceptable TTLB.

Below is a graph of requests per second over time for the page without caching.

#### Figure 1

![Figure 1](/img/microcaching-fig1.gif)

## Test Page With Caching

For the second part of the test, I modified the test page by adding one line of code to Default.aspx:

```aspnet
<%@ OutputCache Duration="1" VaryByParam="none" %>
```

The new Default.aspx then looked like this:

```aspnet
<%@ Page language="c#" Codebehind="Default.aspx.cs" AutoEventWireup="false" Inherits="MicroCache._Default" EnableSessionState="false" EnableViewState="false" %>
<%@ OutputCache Duration="1" VaryByParam="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
 <HEAD>
  <title>Products</title>
 </HEAD>
 <body MS_POSITIONING="FlowLayout">
  <form id="Form1" method="post" runat="server">
   <asp:DataGrid id="DataGrid1" runat="server"></asp:DataGrid>
  </form>
 </body>
</HTML>
```

The same test was run against this page.

## Results With Caching

Running the test a second time against a page with one second of output caching enabled resulted in a total of 74,157 requests and an average requests per second of 247.19.  The TTFB and TTLB were both 11ms.  So, compared to the non-cached page, the throughput increased by over 400% and each page took 80% less time to load, five times the performance.

Figure 2 below shows a graph of requests per second over time.

#### Figure 2

![Figure 2](/img/microcaching-fig2.gif)

The next figure shows both tests, side-by-side.

#### Figure 3

![Figure 3](/img/microcaching-fig3.gif)

## Analysis and Summary

Clearly, even just a second's worth of caching can have a big impact on performance for a high-volume application.  It's easy to see why this is the case if we look at the database's performance during this test.  I ran the test with two performance counters:

```
SQLServer:SQL Statistics\Batch Requests/sec
ASP.NET Apps v1.1.4322\Requests/Sec\myapplication
```

In the non-caching test, the SQL Server requests/sec counter averaged 56.2 requests per second.  In the micro-caching test, it averaged 1.0 request per second.  Obviously, the database was not having to do nearly as much work.  However, not all of the savings were on the database side.  Loading data into a DataSet is relatively expensive as well, as is data binding.  Although there aren't any performance counters for these activities specifically, we know they were occurring once per request in the first case, and once per second in the latter case, so we dropped a lot of work from the ASP.NET engine's plate as well.

Typically, the database and the web server will reside on separate boxes.  The reduction in database load would clearly benefit the database server, which is a very good thing since, historically, database servers are much more difficult to scale out than web servers.  In addition, it will reduce network traffic between the web and database servers, which will further enhance performance, and the reduction in web server load is also helpful, of course, since it reduces how many web servers would be needed (or how powerful each one would need to be).

### Summary

Caching is a very useful tool to take advantage of when designing applications.  It is not a panacea, and like any tool, it can be used improperly.  But even in situations where data needs to be up to the second, adding one second's worth of caching can make a big impact on application performance.  Remember to ask your users how much they can tolerate out-of-date data and try to get them to at least sign off on one-second-old data if you can, since that will allow you to take advantage of techniques like the one described here.

Originally published on [ASPAlliance.com](http://aspalliance.com/251_ASPNET_Micro_Caching_Benefits_of_a_OneSecond_Cache).
