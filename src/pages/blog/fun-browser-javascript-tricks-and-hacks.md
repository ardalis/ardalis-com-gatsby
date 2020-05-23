---
templateKey: blog-post
title: Fun Browser JavaScript Tricks and Hacks
path: blog-post
date: 2018-11-07T00:00:00.000Z
description: I occasionally present to school-age kids on software development,
  and an easy way to get them engaged is to show them how something already
  familiar to them - web sites - can easily be manipulated using tools they
  already have available.
featuredpost: false
featuredimage: /img/fun-browser-javascript-tricks-and-hacks.png
tags:
  - seo
category:
  - Software Development
comments: true
share: true
---
I occasionally present to school-age kids on software development, and an easy way to get them engaged is to show them how something already familiar to them - web sites - can easily be manipulated using tools they already have available. None of these are my own personal creation, but I'm listing them here for others to benefit from and for me to easily locate in the future, as some of the original sources have disappeared over the years.

## Harlem Shake

The Harlem Shake "hack" is applied by opening up the developer tools console tab and pasting in some JavaScript code. Then watch as all the elements on the page start dancing around to music. You can try it on this page right now. Just copy the code listing below. Then hit F12 to open your browser's developer tools. Locate the 'Console' tab and click in there. Turn on your sound (maybe not **too** loud). Then paste and hit Enter.

```javascript

```

Note: You can also paste the script into the address bar, but in my tests with Chrome it would always strip off the initial "javascript:" from the pasted text, so you need to type that back in at the beginning yourself (hit Home, then type "javascript:" without the quotes, then hit Enter).

[Source](https://gist.github.com/jonathantneal/656b23d080994df1587f770f61d88c77)

## Edit Everything on (almost) Any Page

A lot of kids equate "hacking" a site with defacing it in some fun manner. Maybe go to their school web site and modify the principal's name to be theirs, for instance. There are a few ways to do this kind of thing using the built-in developer tools, but none are as easy as this hack. Use the same technique described above to add apply this code to a page:

javascript:document.body.contentEditable='true'; document.designMode='on'; void 0

Now you can just click anywhere on the page (except on images) and start typing to modify the text of the page. This includes most navigation menus, as well as body text!

[Source](http://www.blogohblog.com/cool-javascript-tricks/)

## Image Snake / Wheel

This code will take all of the images on the page and have them fly around in a figure-8 pattern, each chasing the next like a snake:

**javascript:R=0; x1=.1; y1=.05; x2=.25; y2=.24; x3=1.6; y3=.24; x4=300; y4=200; x5=300; y5=200; DI=document.getElementsByTagName("img"); DIL=DI.length; function A(){for(i=0; i-DIL; i++){DIS=DI\[ i ].style; DIS.position='absolute'; DIS.left=(Math.sin(R\*x1+i\*x2+x3)\*x4+x5)+"px"; DIS.top=(Math.cos(R\*y1+i\*y2+y3)\*y4+y5)+"px"}R++}setInterval('A()',5); void(0);**

[Source](http://www.blogohblog.com/cool-javascript-tricks/)

## CSS Font Changes

Another easy way to dramatically change the look of a site is to modify its default font. Again, go to a popular site or the school's home page and open up developer tools. In this case, go to the Elements tab and look for a body {} style under the Styles section. Add or modify a font-family attribute like so (include the quotes around the font name for multi-word fonts):

body {   font-family: "Chiller";
}

You can use any font installed on your machine. Another popular one is "Comic Sans MS". Add another line with color: red; to see how that changes things, too.

## More?

Do you have any similar fun "hacks" that can be easily applied to any site using client-side JavaScript and/or dev tools? Leave the details in a comment and I'll incorporate the best ones here in the post with proper credit. Thanks!