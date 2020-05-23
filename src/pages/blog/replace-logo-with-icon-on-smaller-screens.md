---
templateKey: blog-post
title: Replace Logo with Icon on Smaller Screens
date: 2018-10-13
path: blog-post
featuredpost: false
featuredimage: 
tags:
  - css
  - front end development
  - html
  - responsive ui
category:
  - Software Development
comments: true
share: true
---

I'm not a responsive design expert. Or even close. But I did recently figure out how to replace a full logo with a smaller square icon on a web site so when it's viewed on a phone the header is more compact. Here's how I did it so I can find it again, and to help others, and so smarter people can come by and tell me better ways to do it.

## The HTML

<a href="/" class="navbar-brand">
  <img src="~/images/logo\_218x48.png" id="logo" alt="logo" />
  <img src="~/images/icon\_50x50.png" id="icon" alt="icon" />
</a>

## The CSS

#icon {
    display: none;
}

#logo {
    display: block;
}

/\* Hide/rearrange for smaller screens \*/
@media screen and (max-width: 600px) {
    #icon {
        display: block;
        align-content:center;
    }

    #logo {
        display: none;
    }
}

Basically when the screen shrinks below 600px, the two images swap between display:block and display:none.  Seems to work fine everywhere I've tested it. Hope it helps some others.
