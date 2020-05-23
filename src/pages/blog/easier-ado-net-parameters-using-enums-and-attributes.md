---
templateKey: blog-post
title: Easier ADO.NET Parameters using Enums and Attributes
path: blog-post
date: 2003-06-06T23:53:00.000Z
description: DonXML has a cool article I just read on how to use Attributes to
  extend Enums to create strongly typed parameter objects for ADO.NET commands.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ADO.NET
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

DonXML has a cool article I just read on how to use Attributes to extend Enums to create strongly typed parameter objects for ADO.NET commands. You can read the whole article here:

<http://www.donxml.com/FunwithAttributeBasedProgramming.htm>

The article is cool for two reasons:

1. It makes it so that adding a parameter is a very simple one line of code (not 2-3 with a bunch of parameters to mess with)
2. It allows common parameters that should be the same everywhere (like, customerID) to be defined in one place. This way, you know everyone is using the same definition for the parameter, and if you switch from an int to a guid for customerID, you only have one place you need to change in your code to account for the db schema change.

\[Listening To: System of a Down – Temper]

<!--EndFragment-->