---
templateKey: blog-post
title: Making DataReaders Less Evil
path: blog-post
date: 2004-09-17T13:13:00.000Z
description: I admit it, I’ve never been a big fan of the DataReader. There are
  two main reasons for this. Firstly, I’m a big fan of caching, and DataReaders
  cannot be cached.
featuredpost: false
featuredimage: /img/data-reader.jpg
tags:
  - DataReaders
category:
  - Software Development
comments: true
share: true
---
I admit it, I’ve never been a big fan of the DataReader. There are two main reasons for this. Firstly, I’m a big fan of caching, and DataReaders cannot be cached. Thus, even if they are, say, 2x as fast as a DataTable the first time, the cached DataTable is 10x faster whenever it’s read from the cached (these numbers are made up just like 87% of all statistics). Another reason I’ve shied away from DRs is that I prefer to build systems in tiers (that ‘N-Tier’ buzzword you’ve heard about), and I think it is a very bad practice to delegate responsibility for cleaning up resources from one tier to another. It’s just asking for trouble (using a DR to fill a strongly typed collection and then closing the DR in the same method is fine – I just don’t like passing open DRs between tiers). All that said, I’ve recently been informed of a way to use DRs that is safe in the N-Tier scenario, and I think it’s a very elegant solution.

[Teemu Keiski’s article on using delegates to allow DRs to be passed between tiers without requiring the calling code to handle the cleanup of the DR](http://aspalliance.com/526)is a must-read for anybody who is using DRs to pass databack from a data access layer to the main application. Check it out here:

<http://aspalliance.com/526>