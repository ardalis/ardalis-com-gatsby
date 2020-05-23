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
javascript: (function () {
    function c() {
        var e = document.createElement("link");
        e.setAttribute("type", "text/css");
        e.setAttribute("rel", "stylesheet");
        e.setAttribute("href", f);
        e.setAttribute("class", l);
        document.body.appendChild(e)
    }
    function h() {
        var e = document.getElementsByClassName(l);
        for (var t = 0; t < e.length; t++) {
            document.body.removeChild(e\[t\])
        }
    }
    function p() {
        var e = document.createElement("div");
        e.setAttribute("class", a);
        document.body.appendChild(e);
        setTimeout(function () {
            document.body.removeChild(e)
        }, 100)
    }
    function d(e) {
        return {
            height: e.offsetHeight,
            width: e.offsetWidth
        }
    }
    function v(i) {
        var s = d(i);
        return s.height > e && s.height < n && s.width > t && s.width < r
    }
    function m(e) {
        var t = e;
        var n = 0;
        while ( !! t) {
            n += t.offsetTop;
            t = t.offsetParent
        }
        return n
    }
    function g() {
        var e = document.documentElement;
        if ( !! window.innerWidth) {
            return window.innerHeight
        } else if (e && !isNaN(e.clientHeight)) {
            return e.clientHeight
        }
        return 0
    }
    function y() {
        if (window.pageYOffset) {
            return window.pageYOffset
        }
        return Math.max(document.documentElement.scrollTop, document.body.scrollTop)
    }
    function E(e) {
        var t = m(e);
        return t >= w && t <= b + w
    }
    function S() {
        var e = document.createElement("audio");
        e.setAttribute("class", l);
        e.src = i;
        e.loop = false;
        e.addEventListener("canplay", function () {
            setTimeout(function () {
                x(k)
            }, 500);
            setTimeout(function () {
                N();
                p();
                for (var e = 0; e < O.length; e++) {
                    T(O\[e\])
                }
            }, 15500)
        }, true);
        e.addEventListener("ended", function () {
            N();
            h()
        }, true);
        e.innerHTML = " <p>If you are reading this, it is because your browser does not support the audio element. We recommend that you get a new browser.</p> <p>";
        document.body.appendChild(e);
        e.play()
    }
    function x(e) {
        e.className += " " + s + " " + o
    }
    function T(e) {
        e.className += " " + s + " " + u\[Math.floor(Math.random() \* u.length)\]
    }
    function N() {
        var e = document.getElementsByClassName(s);
        var t = new RegExp("\\\\b" + s + "\\\\b");
        for (var n = 0; n < e.length;) {
            e\[n\].className = e\[n\].className.replace(t, "")
        }
    }
    var e = 30;
    var t = 30;
    var n = 350;
    var r = 350;
    var i = "https://s3.amazonaws.com/moovweb-marketing/playground/harlem-shake.mp3";
    var s = "mw-harlem\_shake\_me";
    var o = "im\_first";
    var u = \["im\_drunk", "im\_baked", "im\_trippin", "im\_blown"\];
    var a = "mw-strobe\_light";
    var f = "https://s3.amazonaws.com/moovweb-marketing/playground/harlem-shake-style.css";
    var l = "mw\_added\_css";
    var b = g();
    var w = y();
    var C = document.getElementsByTagName("\*");
    var k = null;
    for (var L = 0; L < C.length; L++) {
        var A = C\[L\];
        if (v(A)) {
            if (E(A)) {
                k = A;
                break
            }
        }
    }
    if (A === null) {
        console.warn("Could not find a node of the right size. Please try a different page.");
        return
    }
    c();
    S();
    var O = \[\];
    for (var L = 0; L < C.length; L++) {
        var A = C\[L\];
        if (v(A)) {
            O.push(A)
        }
    }
})()
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

body {   font-family: "Chiller"; }

You can use any font installed on your machine. Another popular one is "Comic Sans MS". Add another line with color: red; to see how that changes things, too.

## More?

Do you have any similar fun "hacks" that can be easily applied to any site using client-side JavaScript and/or dev tools? Leave the details in a comment and I'll incorporate the best ones here in the post with proper credit. Thanks!