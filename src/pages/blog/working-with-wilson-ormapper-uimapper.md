---
templateKey: blog-post
title: Working with Wilson ORMapper / UIMapper
path: blog-post
date: 2005-03-08T02:27:02.055Z
description: I’ve been trying to get Paul Wilson’s [ORMapper] and [UIMapper] to
  work for a small application I’ve been working on. First, let me vent a bit.
  The lack of documentation for these tools is very frustrating.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Test Driven Development
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been trying to get Paul Wilson’s [ORMapper](http://ormapper.net/) and [UIMapper](http://uimapper.net/) to work for a small application I’ve been working on. First, let me vent a bit. The lack of documentation for these tools is very frustrating. I would love to see at least a user-documentation area like the wiki that is set up at <http://docs.communityserver.org/> so that Paul’s users could help build up the documentation themselves. I understand he’s busy, and I’m like him when it comes to the tedious parts of programming.

Lacking documentation, some unit tests would have helped me to get a good grasp on things, but alas these did not exist either. So I wrote some. However, I quickly ran into a problem where NUnit was saying that ORMapper thought my object’s type was invalid. I triple-checked it and the type was correct. I finally [found the answer to this issue](http://www.wilsondotnet.com/Tips/ViewPosts.aspx?Thread=591) on Paul’s Forum. I was trying to load the object in SetUp or TestFixtureSetUp which for some reason runs in a different scope than code that is executed within each Test. The workaround: do all of the object loading in each test, rather than in a SetUp method.

Once my ORMapper tests worked, I started trying to expand things and get into the UIMapper. However, I kept getting syntax errors and null reference exceptions that were very frustrating and almost impossible to track down. I finally punted and used Paul’s WilsonORHelper.exe program to rebuild my XML files and classes. Then, things worked like a charm (albeit the names for some things weren’t just how I wanted them, but at that point I just wanted it to work). Lesson learned: use the tool rather than trying to hand-edit it to be just so (at least when it’s late at night and you’re already frustrated).

Leveraging this last lesson I went straight to the [CodeSmith](http://www.ericjsmith.net/codesmith)template for the UIMappings files. This time, though, I was still getting all kinds of NullReferenceExceptions. The main problem was the ComboBox UI element, which apparently is not fully defined by the template. Instead, when you look at the config file, it has TODO items for ‘source’ ‘key’ and ‘display’ attributes. Since I hadn’t messed with these, the page was throwing errors when it tried to load this control. In my opinion, if these values are not set, or are set to something that includes the string “TODO”, the exception given really ought to be a bit more helpful than a generic NullReferenceException. It might even be a good idea for the exception to direct me to the config file and tell me which attributes I need to set. As it stands, I haven’t yet figured out what to put for these attributes that will make the ComboBox work, so I’ve simply commented it out of my config files.

Other than that, I’ve gotten it to work! I have **Items** and **Categories** and I can do all the basic CRUD functions now. There are still a bunch of modifications I need to make, and I’d like to try and integrate Peter Blum’s date controls for the DatePicker widget. We’ll see how that goes, and how long it takes before something else pulls me away from this project.

<!--EndFragment-->