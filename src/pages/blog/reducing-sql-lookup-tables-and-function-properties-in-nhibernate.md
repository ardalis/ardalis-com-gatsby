---
templateKey: blog-post
title: Reducing SQL Lookup Tables and Function Properties in NHibernate
path: blog-post
date: 2008-10-05T14:28:00.000Z
description: One of the points made in Jeffrey’s agile development boot camp
  last week that struck a chord with me was that many database-centric designs
  have lookup tables that aren’t really just data.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
One of the points made in [Jeffrey’s](http://jeffreypalermo.com/)[agile development boot camp](http://www.headspringsystems.com/training) last week that struck a chord with me was that many database-centric designs have lookup tables that aren’t really just data. That is, tables that hold values such as statuses that, if modified, can easily break existing code or won’t function as expected without the addition of code. We have a lot of these in our codebase, and we’ve been struggling with the questions of how to address these values in our system. Do we use Enums? If so, do we try and keep the enums in sync with the database values? If not, do we want to use magic numbers/strings to refer to these codes? It’s a real PITA to work with these things and really the only reason they’re in the database at all is so we have some referential integrity locking down the allowable values of the status column(s).

You can avoid this problem if you push the status logic into objects and don’t rely on the database to implement referential integrity for you. Create a Status class that has all of the logic necessary for rendering a status code in a variety of ways (for instance a short code, a long name, and a description, all of which are difficult to implement on Enums without attributes or other extension approaches). Have your primary class reference the status via composition (e.g. a property). Then, in your persistence layer, you can store just the short code value (or integer key) of the class, but without the requirement that there be a lookup table involved. If referential integrity is of great importance, a constraint can easily be applied to the database. The constraint would then be updated with the build at the same time as new values are added to the Status class. The status can also be used similarly to an Enum assuming it has some static properties representing its value instances, like so:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> WorkOrderStatus
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> WorkOrderStatus Assigned = <span style="color: #0000ff">new</span> WorkOrderStatus(
<span style="color: #606060">   4:</span>         <span style="color: #006080">"ASD"</span>, <span style="color: #006080">"Assigned"</span>, <span style="color: #006080">"Assigned"</span>, 2, <span style="color: #0000ff">true</span>);
<span style="color: #606060">   5:</span>  
<span style="color: #606060">   6:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> WorkOrderStatus Cancelled = <span style="color: #0000ff">new</span> WorkOrderStatus(
<span style="color: #606060">   7:</span>         <span style="color: #006080">"CAN"</span>, <span style="color: #006080">"Cancelled"</span>, <span style="color: #006080">"Cancelled"</span>, 5, <span style="color: #0000ff">false</span>);
<span style="color: #606060">   8:</span>  
<span style="color: #606060">   9:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> WorkOrderStatus Complete = <span style="color: #0000ff">new</span> WorkOrderStatus(
<span style="color: #606060">  10:</span>         <span style="color: #006080">"CMP"</span>, <span style="color: #006080">"Complete"</span>, <span style="color: #006080">"Complete"</span>, 4, <span style="color: #0000ff">false</span>);
<span style="color: #606060">  11:</span> ...
<span style="color: #606060">  12:</span> }
```

NHibernate can map this status directly if you create a WorkOrderStatusType class that inherits from NHibernate.Type.PrimitiveType and overrides its methods. The mapping then is simply:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">class</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">="WorkOrder"</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">   2:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">property</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">="Status"</span> 
<span style="color: #606060">   3:</span>     <span style="color: #ff0000">type</span><span style="color: #0000ff">="WorkOrderStatusType, Infrastructure"</span> 
<span style="color: #606060">   4:</span>     <span style="color: #ff0000">not-null</span><span style="color: #0000ff">="true"</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #606060">   5:</span> ...
<span style="color: #606060">   6:</span> <span style="color: #0000ff">&lt;/</span><span style="color: #800000">class</span><span style="color: #0000ff">&gt;</span>
```

One very common pattern I’ve noticed as software evolves is the migration from simple boolean state codes on objects to multi-value states and eventually to the need for some kind of an event log. In the example above, perhaps originally we started with a WorkOrderStatus that was simply a boolean with states for Complete and Incomplete, and it has since moved on to include the states listed above (and several others). Now the customer wants to know when the status changed, and by whom, so they can track the WorkOrder through its workflow.

Typically this requires a bunch of changes in the database and some application logic to get the current status from the event log as the most recent one. Further, the WorkOrder might expose dates for LastUpdated and CompletedDate which should be tied to this same event log, though prior to adding the event log they were set in application code when these state transformations occurred. This is an example wherein NHibernate’s support for functions can be very helpful (see also [this post by Ayende](http://ayende.com/Blog/archive/2006/10/01/UsingSQLFunctionsInNHibernate.aspx)). Assuming there is an Event table which has columns for BeginStatus and EndStatus as well was a DateTime column, date properties for the WorkOrder could be mapped like so:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">class</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">="WorkOrder"</span><span style="color: #0000ff">&gt;</span>
<span style="color: #606060">   2:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">property</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">="LastAssignedDate"</span> <span style="color: #ff0000">formula</span><span style="color: #0000ff">="(
<span style="color: #606060">   3:</span> select max(e.DateTime) 
<span style="color: #606060">   4:</span> from Event e 
<span style="color: #606060">   5:</span> where (e.WorkOrderId = Id)
<span style="color: #606060">   6:</span> and (e.EndStatus = 'ASD'))"</span><span style="color: #0000ff">/&gt;</span>
<span style="color: #606060">   7:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">property</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">="LastUpdatedDate"</span> <span style="color: #ff0000">formula</span><span style="color: #0000ff">="(
<span style="color: #606060">   8:</span> select max(e.DateTime) 
<span style="color: #606060">   9:</span> from Event e 
<span style="color: #606060">  10:</span> where (e.WorkOrderId = Id))"</span><span style="color: #0000ff">/&gt;</span>
<span style="color: #606060">  11:</span> ...
<span style="color: #606060">  12:</span> <span style="color: #0000ff">&lt;/</span><span styl
```

The nice thing about this approach is that there are fewer tables in the database that are dedicated to mere lookup data. In this case, we’ve eliminated the need for a WorkOrderStatus table that might have had columns like ID, Name, Description, ShortCode, SortBy, and perhaps other properties. Keeping the database more streamlined makes it easier to comprehend and easier to change, and keeping this logic in our classes rather than in the database makes our code easier to change and easier to test. If the raw SQL in the mapping file is a red flag for you, replace them with SQL Functions (which Ayende [covers in his post](http://ayende.com/Blog/archive/2006/10/01/UsingSQLFunctionsInNHibernate.aspx)).