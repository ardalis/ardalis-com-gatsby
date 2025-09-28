---
title: Limit Rows In DataTable or DataSet
date: "2008-10-30T08:12:43.6560000-04:00"
description: I wrote some quick and dirty ADO.NET code to go against an RSS feed
featuredImage: img/limit-rows-in-datatable-or-dataset-featured.png
---

I wrote some quick and dirty ADO.NET code to go against an RSS feed instead of a flat XML file today. In the process I had to figure a way to limit the number of rows returned by the function, which returns a DataTable. The simplest method I found was this one, which uses the DataTable.Select() method. Using this technique, you could also pass in a sort parameter (second parameter to Select()) which would let you grab the top N rows from the DataTable after sorting it on whichever column you wished (syntax for sortexpression is "column" which defaults to ascending or"column DESC" for descending). And of course you can also do a filter, etc., but I didn't need all that.


```
public DataTable LatestRows(int rowCount)
{
try
{
DataSet myDataSet = new DataSet();
using (XmlTextReader myReader = new XmlTextReader("http://aspalliance.com/crystal.rss"))
{
myDataSet.ReadXml(myReader);
}
DataTable myTable = myDataSet.Tables [2].Clone(); // in standard RSS, the feed items are here
DataRow [] myRows = myDataSet.Tables [2].Select();
for (int i = 0; i < rowCount; i++)
{
if (i < myRows.Length)
{
myTable.ImportRow(myRows [i]);
myTable.AcceptChanges();
}
}
return myTable;
}
catch
{
return new DataTable();
}
}
```

