---
templateKey: blog-post
title: Use jQuery to Format Buttons Same Width
path: blog-post
date: 2016-07-29T05:51:00.000Z
description: >
  Some (many) user interfaces work best when buttons are sized identically, so
  that instead of this:
featuredpost: false
featuredimage: /img/buttons-differentsizesvertical.png
tags:
  - javascript
  - jquery
category:
  - Software Development
comments: true
share: true
---
Some (many) user interfaces work best when buttons are sized identically, so that instead of this:

![](/img/buttons-differentsizes.png)

or this:

![](/img/buttons-differentsizesvertical.png)

You have something like this:

![](/img/buttons-samesizes.png)

This is pretty easy to do in JavaScript, and jQuery make it simple to apply the logic to a set of buttons with a common class. You can create a function, widest(), that, when applied to a set of buttons, sets its width to the widest button in the set. This is especially useful if you have a dynamic UI, perhaps because you’re localizing the text, for instance.

`$.fn.widest = function() {     `\
              `return this.length ? this.width(Math.max.apply(Math, this.map(function() { 
        return $(this).width();
    }))) : this;
};`

This is a somewhat tricky function to follow (for me at least). It starts out checking whether this.length is “truthy”, which will be true if it’s being applied to an array. If it’s not, then it just returns this (the “: this;” on the 4th line), doing nothing. Assuming an array is passed in, it will set the width property of each element to the result of a function. The function returns the max of the width of all elements in the array. So, if the elements started with widths of 25, 50, and 100, the function would return 100, and this would be set as the width for every element in the array.

This function can be applied to a group of buttons (perhaps all marked class=”buttons”) like this:

`$('.buttons').widest();`

And this call can be made in the document ready function, or as part of a button click.

You can see a working example of this technique in this [jsfiddle](https://jsfiddle.net/ardalis/rb0qL32w/).

<iframe width="100%" height="400" src="//jsfiddle.net/ardalis/rb0qL32w/embedded/" frameborder="0" allowfullscreen="allowfullscreen"></iframe>