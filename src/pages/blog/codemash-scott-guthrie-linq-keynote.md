---
templateKey: blog-post
title: CodeMash Scott Guthrie LINQ Keynote
path: blog-post
date: 2007-01-19T17:38:35.248Z
description: "One of the points in Scott’s keynote at CodeMash was the idea that
  declarative programming (saying “what I want”) has many advantages over
  imperative programming (“how I want to do it”). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - LINQ
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

One of the points in Scott’s keynote at CodeMash was the idea that declarative programming (saying “what I want”) has many advantages over imperative programming (“how I want to do it”). One advantage he noted is that as we start to move more and more toward multi-core computers, rather than faster and faster single cores, the need for applications to be partitionable over multiple processors will increase. Standard imperative algorithms used for many tasks in our apps tend to be written for single threaded, one cpu operation. For instance, to get a list of customers from Ohio, one might get a list of all customers and then write a for loop to iterate over the collection and pull out the ones where state is OH. This would be single threaded by default, and would not be able to take advantage of a multi-core architecture. The same action, however, could be written in a more declarative fashion using LINQ, as follows:

**ohiocustomers = customers.Where(c=>c.State == “OH”);**

In this case, none of the details of HOW the subset of customers are retrieved have been dictated. This will allow the platform to have some flexibility in how to execute the actions, and in a multi-core system LINQ (in some future, theoretical version, I think) might parcel out the work to separate cores and then collect the results back together, allowing better utilization of the available resources.

\[categories: LINQ]

<!--EndFragment-->