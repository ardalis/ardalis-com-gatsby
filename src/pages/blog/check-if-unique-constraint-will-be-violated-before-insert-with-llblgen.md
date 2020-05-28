---
templateKey: blog-post
title: Check if Unique Constraint will be violated before Insert with LLBLGen
path: blog-post
date: 2008-10-30T12:11:34.523Z
description: I needed to determine if a unique constraint would be violated so
  that I could programmatically update the Name of a business object to make it
  unique today.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - C#
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I needed to determine if a unique constraint would be violated so that I could programmatically update the Name of a business object to make it unique today. I use LLBLGen for this project’s database layer, and I have a unique constraint (actually a unique index) set on the database. In this case it covers two columns, an integer ID and a string Name, but the nice thing about LLBLGen is that it provides helper methods that generate the predicate needed. The code required looked like this:

<!--EndFragment-->

```
public static bool CampaignNameInUse(int advertiserId, string campaignName)
{
using (DataAccessAdapter adapter = new DataAccessAdapter())
{
CampaignEntity myCampaign = new CampaignEntity();
myCampaign.AdvertiserId = advertiserId;
myCampaign.Name = campaignName;
return adapter.FetchEntityUsingUniqueConstraint(myCampaign, myCampaign.ConstructFilterForUCAdvertiserIdName());
}
}
```