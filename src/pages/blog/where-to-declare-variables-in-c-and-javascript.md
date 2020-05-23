---
templateKey: blog-post
title: Where to Declare Variables in C# and JavaScript
path: blog-post
date: 2014-07-16T15:10:00.000Z
description: "Both JavaScript and C# belong to the C family of languages. They
  share curly braces and semi-colons, and in fact there are many cases where the
  exact same code will execute (correctly, in most cases) as either language. "
featuredpost: false
featuredimage: /img/deathtostock_desk1_3.jpg
tags:
  - C#
  - javascript
  - tip
category:
  - Software Development
comments: true
share: true
---
Both JavaScript and C# belong to the C family of languages. They share curly braces and semi-colons, and in fact there are many cases where the exact same code will execute (correctly, in most cases) as either language. However, there are certain best practices that are unique to each language, and where variables should be declared is one of them.

![](/img/deathtostock_desk1_3.jpg)

## Declaring Variables in C#

In C#, it’s generally best to declare variables just before they’re used. Like any convention in programming, there’s some debate about this, but this rule is supported by well-respected books like Clean Code and top-voted answers to questions like this one: [Where do you declare variables? The top of a method or when you need them](http://programmers.stackexchange.com/questions/56585/where-do-you-declare-variables-the-top-of-a-method-or-when-you-need-them)? As this answer points out, there are good functional reasons for following this rule, and it also makes it much easier to [refactor code](http://bit.ly/RefactoringFundamentals "Learn more on Pluralsight: Refactoring Fundamentals") if variables and logic that uses them are collocated.

## Declaring Variables in JavaScript

In JavaScript, despite looking a great deal like C#, the best practice is to follow something called “the single var pattern.” That is, declare all of your local variables at the start of each function, using a single var statement. The book [JavaScript Patterns](http://amzn.to/1mJqH8E) demonstrates this:

function func() {\
var a = 1,\
b = 2,\
sum = a + b;\
// function body\
}

The reason why this is preferable in JavaScript has to do with how the code is parsed before it is executed. In C#, which is strongly typed, variables must be declared before they are used. Not so in JavaScript. If you use a variable that hasn’t been declared, that variable will simply be created for you in the global space (assuming you’re not in strict mode). If you’re familiar with JavaScript, you’re probably nodding along at this point, but do you know this isn’t always true? If you use a variable that hasn’t been declared yet, but which is declared later in the same scope, you’re actually using that variable. Surprise!

This is commonly called ***hoisting***, and is a consequence of how the parser works. There’s an initial pass that gathers up all declarations and creates the associated objects. Then during execution, expressions and undeclared variables are created. Take a look at this fiddle to see this in action (example modified from one found in JavaScript Patterns – [buy the book](http://amzn.to/1mJqH8E)):

<iframe width="100%" height="220" src="https://jsfiddle.net/a24ss/embedded/js,html,result/"></iframe>

In the above code, if you view the result, you’ll see that in the first log() call, myGlobal is not “This is global.” as you might expect. It’s undefined, because it’s an instance of the local myGlobal declared on the following line (but not yet assigned a value – that line hasn/t been executed yet).

## Summary

Although sharing a great deal of syntax, JavaScript and C# are very different languages in many, sometimes subtle, ways. In this case, even something as straightforward as a convention for where to declare variables should not be shared between the two languages, because each one is optimized in exactly opposite ways. Although I’ve been using JavaScript for over a decade, I definitely consider myself primarily a C# developer, so as I work more and more with JavaScript today, I have to constantly remind myself of how to best write code following each language’s idiom.