---
templateKey: blog-post
title: Refactor Request
path: blog-post
date: 2008-04-02T01:25:03.416Z
description: "Not sure if it’s already there, but the folks at DevExpress or
  JetBrains (or Microsoft, but I don’t want to wait for another VS) should have
  a refactoring for CodeRush/Refactor! or Resharper "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Not sure if it’s already there, but the folks at [DevExpress](http://devexpress.com/) or [JetBrains](http://www.jetbrains.com/) (or Microsoft, but I don’t want to wait for another VS) should have a refactoring for [CodeRush/Refactor!](http://www.devexpress.com/Products/NET/IDETools/CodeRush) or [Resharper](http://www.jetbrains.com/resharper) that will convert verbose properties into C# 3.5 short properties, like so:

Make this:

<!--EndFragment-->

```
<span style="color: #0000ff;">protected</span> <span style="color: #0000ff;">bool</span> isSponsored = <span style="color: #0000ff;">false</span>;
<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">bool</span> IsSponsored

{

    get { <span style="color: #0000ff;">return</span> isSponsored; }

    set { isSponsored = <span style="color: #0000ff;">value</span>; }

}
```

<!--StartFragment-->

Into this:

<!--EndFragment-->

```
<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">bool</span> IsSponsored { get; set; }
```

<!--StartFragment-->

Ideally, it should work in two forms:

1) Right click on the property (field name let’s say) and offer it as an option in that context.

2) Apply to all properties in a class.

And it should only do it if it is safe, of course. If I had set isSponsored to true in the original code, the refactoring wouldn’t have been possible, since it would have changed the behavior.

Of course, if some enterprising developer has already done this, please comment with a link. Maybe [Keyvan’s](http://nayyeri.net/) done it – he just published a [book on VS extensibility](http://nayyeri.net/blog/first-impressions-on-professional-visual-studio-extensibility)…

<!--EndFragment-->