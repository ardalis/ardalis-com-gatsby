---
templateKey: blog-post
title: Ensure You Are Not Adding To Global Scope in JavaScript
path: blog-post
date: 2014-07-15T15:19:00.000Z
description: "A key best practice if you’re writing JavaScript code is to avoid
  adding objects to the global scope. There are several good reasons for this –
  globals add coupling, it makes it easier for disparate libraries to break one
  another, etc. A general rule of programming is to avoid global scope, in fact.
  "
featuredpost: false
featuredimage: /img/java-script.png
tags:
  - javascript
  - tip
category:
  - Software Development
comments: true
share: true
---
A key best practice if you’re writing JavaScript code is to avoid adding objects to the global scope. There are several good reasons for this – globals add coupling, it makes it easier for disparate libraries to break one another, etc. A general rule of programming is to avoid global scope, in fact. Unfortunately, JavaScript makes adding things to global scope very easy. Consider this bit of[code](http://jsfiddle.net/7Rx32/):

```
<div id="message" />
```

**JavaScript**

```
function sayHello(person) {
    message = "Hello, " + person;
    $("#message").text(message);
}

sayHello('@ardalis');
```

In this example, we have a function, within which we set a variable and then use some jQuery to modify a div. However, because we didn’t specify the “var” keyword, we’ve actually just added a new object to the global scope: message. In fact, if some other functionality was relying on the existence of a global object message, we just replaced it with ours, so that other part of the system is likely to break now, even though no part of it has changed. We’ve added tight coupling to our design, probably inadvertently, making our application more brittle and less maintainable.

Since this is so easy to do by accident, how can we avoid it? Of course there are tools like [JSLint](http://www.jslint.com/) that can go a long way toward finding problems in your JavaScript. Run the sayHello() function through it and it will let you know ‘message’ was used before it was defined.

## Counting Globals

Another option is to calculate the number of objects in the global space, and ensure you’re not adding to it. This can be done as part of your test suite on a per-function basis, asserting that each function begins and ends with no change in the global state (or, if the function intends to add to global state, ensuring it adds only what is expected). The key to this is being able to count how many objects are in global at a given time, which you can do using this [code](http://jsfiddle.net/7Rx32/3/):

```
<p id="message" />
<p id="result" />
```

**JavaScript**

```
function sayHello(person)
{
    message = "Hello, " + person;
    $("#message").text(message);
}
 
function sayHelloShouldNotAddToGlobalScope(globalObject)
{
    var initialGlobalCount = Object.keys(globalObject).length;
    sayHello("@ardalis");
    var endGlobalCount = Object.keys(globalObject).length;
    if(initialGlobalCount == endGlobalCount) {
        $("#result").text("Success!");
    } else {
        $("#result").text("Failed - Initial Count: " + 
                             initialGlobalCount + 
                              " End Count: " +
                             endGlobalCount);
    }
}
 
$(document).ready(function() {
    // run test
    sayHelloShouldNotAddToGlobalScope(window);    
});
```

Now if you run this, you should see that **the function ends with one more item in global scope than it starts with** (the exact numbers will vary on the environment in which it runs).

## Use Strict

Another option is to specify “use strict” which is done by simply adding this string to your code, either locally or globally, followed by a semicolon, like so:

“use strict”;

Doing so will, among other things, prevent the use of undeclared variables, which is the source of the problem in the sayHello() function above. Strict mode is supported in Chrome 13+, IE 10+, Safari 5.1+, and Firefox 4+. If you add it to the code above (see this [fiddle](http://jsfiddle.net/7Rx32/4)), you’ll get an error when you try to run the code (check the console in your developer tools):

![](/img/console.png)

## Summary

Most modern browsers support “use strict” so it’s a good idea to get in the habit of using it. It will prevent common problems like inadvertently adding objects to global scope, as you can see here. You can also check the count of objects in the global object before and after you execute your methods, ideally within your JavaScript unit tests.