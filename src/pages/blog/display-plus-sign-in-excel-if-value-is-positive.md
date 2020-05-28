---
templateKey: blog-post
title: Display Plus Sign in Excel if Value is Positive
date: 2011-07-20
path: /display-plus-sign-in-excel-if-value-is-positive
featuredpost: false
featuredimage: /img/excel_1.png
tags:
  - excel
  - ms office
  - Productivity
category:
  - Productivity
comments: true
share: true
---

Sometimes in Excel you may want to actually display a + character (or plus sign) in front of the cell value if the value is positive.  For instance, if you’re showing the change in a value, like this (note these are made up values):

[![excel_1](/img/excel_1.png)](/img/excel_1.png)

In this case, you can imagine that the Change columns are relative to the previous month’s report, so this gives an at-a-glance idea of the trend.  However, you probably would like the first column to show a + sign so that it’s more clear that it’s a delta value, not a raw value.  You can apply this custom formatting to do so.  First, right click on the cell(s) you want to format, and select Format Cells.  Then click Custom and type in the value shown below.

[![excel_formatcell](/img/excel_formatcell.png)](/img/excel_formatcell.png)

Here’s the value for you to cut and paste:

> +#,###;-#,###;"On Forecast"

With that change to the two Change columns, they now look like this:

[![excel_2](/img/excel_2.png)](/img/excel_2.png)

The last thing we might want to add is some conditional formatting.  For instance, we might want to see the positive change as green and the negative as red.  You can see how to apply this change in the next screenshot (click to enlarge):

[![excel_3](/img/excel_3.png)](/img/excel_3.png)

### Summary

This just shows a couple of quick ways to enhance change values in your Excel sheets so that they stand out a bit.  You can change the default rendering of the change values so that they include a plus sign prefix if the cell value is positive, or a minus sign prefix if it is negative.  You can also apply a bit of conditional formatting so that the cells are colored differently based on their values.  Hope this helps!

**References**

I found [this forum thread](http://www.ozgrid.com/forum/showthread.php?t=60444&page=1) helpful when researching this topic.
