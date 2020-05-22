---
templateKey: blog-post
title: LINQ Range Variable Problem
path: blog-post
date: 2010-10-05T11:50:00.000Z
description: "Ran into this issue last night and just figured it out.  I have
  this code for a demo:"
featuredpost: false
featuredimage: /img/vscode-760x360.png
tags:
  - C#
  - linq
category:
  - Software Development
comments: true
share: true
---
Ran into this issue last night and just figured it out. I have this code for a demo:

```
<span style="color: #0000ff">using</span> System;<br /><span style="color: #0000ff">using</span> System.Data.Objects;<br /><span style="color: #0000ff">using</span> System.Transactions;<br /><span style="color: #0000ff">using</span> ExtractTransformLoad.Domain;<br /><span style="color: #0000ff">using</span> Northwind.Entities;<br /><span style="color: #008000">//using System.Linq;</span><br /><br /><span style="color: #0000ff">namespace</span> ExtractTransformLoad<br />{<br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> SqlFreightByShipperRepository : IFreightByShipperRepository<br />    {<br />        <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> DeleteAndInsert(DateTime runDate, FreightByShipper freightByShipper)<br />        {<br />            <span style="color: #0000ff">using</span> (var context = <span style="color: #0000ff">new</span> NorthwindEntities())<br />            <span style="color: #0000ff">using</span> (var scope = <span style="color: #0000ff">new</span> TransactionScope())<br />            {<br />                var summaryToDelete = (from freightSummary <span style="color: #0000ff">in</span> context.FreightSummaries<br />                                       <span style="color: #0000ff">where</span><br />                                           freightSummary.RunDate == runDate &&<br />                                           freightSummary.ShipperName == freightByShipper.ShipperName<br /><br />                                       select freightSummary);<span style="color: #008000">//.FirstOrDefault();</span><br />                context.DeleteObject(summaryToDelete);<br /><br />                var newFreightSummary = <span style="color: #0000ff">new</span> FreightSummary()<br />                                         {<br />                                             Freight = freightByShipper.Freight,<br />                                             RunDate = DateTime.Today,<br />                                             ShipperName = freightByShipper.ShipperName<br />                                         };<br />                context.FreightSummaries.AddObject(newFreightSummary);<br />                context.SaveChanges(SaveOptions.AcceptAllChangesAfterSave);<br />                scope.Complete();<br />            }<br />        }<br />    }<br />}
```

Now, in Visual Studio, it looks like this:

![image](<> "image")

Hovering over freightSummary in the above LINQ query would reveal just

(range variable) ? freightSummary

[![image](<> "image")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/LINQRangeVariableProblem_7646/image_5.png)

A bunch of searching later didn’t much help, although [this thread did put me on the right track](http://social.msdn.microsoft.com/Forums/en-US/adodotnetentityframework/thread/294673ca-2d16-4212-9f0d-ddc41ad8689f) just a moment ago. The trick, it turns out, is that I didn’t have the System.Linq namespace included (you can see above I just re-commented it out). If you include System.Linq, everything works as expected. Final code here:

```
<span style="color: #0000ff">using</span> System;<br /><span style="color: #0000ff">using</span> System.Data.Objects;<br /><span style="color: #0000ff">using</span> System.Transactions;<br /><span style="color: #0000ff">using</span> ExtractTransformLoad.Domain;<br /><span style="color: #0000ff">using</span> Northwind.Entities;<br /><span style="color: #0000ff">using</span> System.Linq;<br /><br /><span style="color: #0000ff">namespace</span> ExtractTransformLoad<br />{<br />    <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> SqlFreightByShipperRepository : IFreightByShipperRepository<br />    {<br />        <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> DeleteAndInsert(DateTime runDate, FreightByShipper freightByShipper)<br />        {<br />            <span style="color: #0000ff">using</span> (var context = <span style="color: #0000ff">new</span> NorthwindEntities())<br />            <span style="color: #0000ff">using</span> (var scope = <span style="color: #0000ff">new</span> TransactionScope())<br />            {<br />                var summaryToDelete = (from freightSummary <span style="color: #0000ff">in</span> context.FreightSummaries<br />                                       <span style="color: #0000ff">where</span><br />                                           freightSummary.RunDate == runDate &&<br />                                           freightSummary.ShipperName == freightByShipper.ShipperName<br /><br />                                       select freightSummary).FirstOrDefault();<br />                context.DeleteObject(summaryToDelete);<br /><br />                var newFreightSummary = <span style="color: #0000ff">new</span> FreightSummary()<br />                                         {<br />                                             Freight = freightByShipper.Freight,<br />                                             RunDate = DateTime.Today,<br />                                             ShipperName = freightByShipper.ShipperName<br />                                         };<br />                context.FreightSummaries.AddObject(newFreightSummary);<br />                context.SaveChanges(SaveOptions.AcceptAllChangesAfterSave);<br />                scope.Complete();<br />            }<br />        }<br />    }<br />}
```

I guess I’m spoiled by Resharper, which normally prompts me for any namespace it detects that I’m trying to use but haven’t yet included. It wasn’t until I added the .FirstOrDefault() that R# kicked in, and then for some reason it couldn’t automatically add the using statement for System.Linq, but once I did so by hand, the Range Variable problem disappeared.