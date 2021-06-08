---
templateKey: blog-post
title: Dynamic Excel Reports with ASP
date: 2003-09-20
path: blog-post
description: Sometimes it's useful to present data to users in Excel format, so they can easily manipulate the data themselves. In this article, a very simple technique for accomplishing this is demonstrated.
featuredpost: false
featuredimage: /img/dynamic-excel.png
tags:
  - ASP
  - Excel
category:
  - Software Development
  - Productivity
comments: true
share: true
---

## Technique

There are many situations in which you may wish to convert table data into an Excel spreadsheet format for the user. There are several methods available for doing this; I will describe in this article one of the simplest ones. It basically tricks the user's browser into thinking the HTML it is downloading is actually an Excel document, and then Excel does the rest of the work by parsing the HTML into a worksheet. Because of the way this works, although this technique is free and easy, it is also very limited in how it can be used. Also, this method only works if the client has Excel 97 or later installed.

If you need to [generate Excel documents on the web server](http://officewriter.softartisans.com/) in any kind of scalable, robust, or customized fashion, the best tool available is [OfficeWriter](http://officewriter.softartisans.com/) (formerly ExcelWriter) from [SoftArtisans](http://www.softartisans.com/). AspAlliance author Andrew Mooney has written a [fairly detailed review of an older version (v4) of ExcelWriter](http://aspalliance.com/48).

In order to create an Excel report dynamically, you must simply create a .asp file with the header of:

```aspnet
<%
Response.ContentType = "application/vnd.ms-excel"
%>
```

This informs the browser that the code to follow is Excel formatted, and Netscape or IE will prompt the user to Save or Open the file. When they Open the file, Excel is launched and the report is viewed by Excel. In order for Excel to understand your data, you need only create an HTML table, which Excel 97 will then convert into its own format. **NOTE: This must be the first line of code on the page!** (Actually, it just has to be before any other header or HTML info is output to the browser, but put it at the top and it won't cause you problems)

For example, a donut shop wants to track its donuts. It has a report written which dumps the following data:

| flavor                | qty_baked | qty_eaten | qty_sold | price |
|-----------------------|-----------|-----------|----------|-------|
| Boston Crème          | 24        | 2         | 10       | 0.5   |
| Jelly                 | 24        | 1         | 12       | 0.5   |
| Strawberry Crème      | 36        | 1         | 15       | 0.5   |
| Chocolate Crème Stick | 24        | 2         | 6        | 0.75  |
| Maple Crème Stick     | 12        | 1         | 6        | 0.75  |

## Code

They also want to be able to manipulate this data using Excel, and perform some calculations on it. They created an Excel sheet using this code:

```aspnet
<%
Response.ContentType = "application/vnd.ms-excel"
set conntemp=server.createobject("adodb.connection")
cnpath="DBQ=" & server.mappath("/stevesmith/data/timesheet.mdb")
conntemp.Open "DRIVER={Microsoft Access Driver (*.mdb)}; " & cnpath
set RS=conntemp.execute("select * from donut")
%>
<TABLE BORDER=1>
    <TR>
        <%
        ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ' % Loop through Fields Names and print out the Field Names
        ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        j = 2 'row counter
        For i = 0 to RS.Fields.Count - 1
        %>
        <TD><B><% = RS(i).Name %></B></TD>
        <% Next %>
        <TD><B>On Hand (calculated)</B></TD>
        <TD><B>Gross (calculated)</B></TD>
    </TR>
    <%
    ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ' % Loop through rows, displaying each field
    ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Do While Not RS.EOF
    %>
    <TR>
        <% For i = 0 to RS.Fields.Count - 1
        %>
        <TD VALIGN=TOP><% = RS(i) %></TD>
        <% Next %>
        <TD>=b<%=j%>-c<%=j%>-d<%=j%></TD>
        <TD>=d<%=j%>*e<%=j%></TD>
    </TR>
    <%
    RS.MoveNext
    j = j + 1
    Loop
    ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ' % Make sure to close the Result Set and the Connection object
    ' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RS.Close
    %>
    <TR BGCOLOR=RED>
    <TD>Totals</TD>
    <TD>=SUM(B2:B6)</TD>
    <TD>=SUM(C2:C6)</TD>
    <TD>=SUM(D2:D6)</TD>
    <TD>n/a</TD>
    <TD>=SUM(F2:F6)</TD>
    <TD>=SUM(G2:G6)</TD>
</TABLE>
```

You can test this code by clicking [here](http://authors.aspalliance.com/stevesmith/articles/examples/excelsample.asp). As you can see, this not only includes all of the information from the original HTML table-based dump, but it also includes some simple Excel functions, and they would easily be able to create charts and/or graphs from this spreadsheet, or manipulate the data into a local database.

**Note:** Microsoft has acknowledged a BUG in IE (3.02, 4.0, 4.01, 4.01sp1) which causes it to misinterpret Excel output, particularly when generated by ASP, ISAPI, or CGI. You can read more about it at [support.microsoft.com](http://support.microsoft.com/support/kb/articles/q185/9/78.asp). To summarize: *When Internet Explorer connects to a Web server resource that dynamically generates Word, Excel, or other Active Documents, Internet Explorer may send two GET requests for the resource. The second GET usually does not have session state information, temporary cookies, or authentication information that may have already been specified for the client. This bug can affect any local server (EXE) Active Document application hosted inside the Internet Explorer frame window. It occurs most frequently with ISAPI, ASP, or CGI applications that adjust the HTTP "Content Type" header to identify the installed application.*

## Update: 16 July 2003

I wrote this article several years ago, and since then it has grown to be extremely popular. I receive one or two emails per week asking questions like "How can I have Excel open several sheets?" or "How can I control the format of the sheet?" or "How can I add charting?". The thing to remember about this particular technique is that it is 100% dependent on the Excel application on the user's machine. It is a feature of Excel, not ASP, that allows it to look at an HTML table and interpret it as an Excel worksheet. Unfortunately, there are significant limits to what Excel can do in this regard. However, if you need to go beyond these limits, there are things you can do to help Excel, although they do require more work and resources than the one line of code this technique requires. The best product on the market, bar none, to do anything non-trivial with Excel over the web is [ExcelWriter](http://excelwriter.softartisans.com/), from [SoftArtisans](http://www.softartisans.com/). I'll be writing a review of the product as a separate article some time in the future, but I encourage you to visit their website and look through their samples to see if they solve your problem if this technique does not meet your needs.

### Reference Links

- [SoftArtisans ExcelWriter](http://excelwriter.softartisans.com/)
- [Wayne Berry's Article](http://www.15seconds.com/Issue/970515.htm)
- [Microsoft Excel Development](http://www.microsoft.com/exceldev)
- [Dsofile.exe Lets You Edit Office Document Properties from Visual Basic and ASP (Q224351)](http://support.microsoft.com/default.aspx?scid=kb;EN-US;q224351)  Dsofile.exe is a self-extracting executable that provides a simple in-process ActiveX component for programmers to use in order to read and modify the Document Summary Properties for an OLE Structured Storage file such as native Excel, PowerPoint, Microsoft Visio, and Word documents without using Automation to Microsoft Office. The component can also work on non-OLE documents when it is run on Windows 2000 with an NTFS file system.
- [Perf/License Issues w/Excel on the Server (SoftArtisans)](http://excelwriter.softartisans.com/default.aspx?PageID=86)

Originally published on [ASPAlliance.com](http://aspalliance.com/1_Dynamic_Excel_Reports_with_ASP).
