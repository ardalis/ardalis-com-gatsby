---
templateKey: blog-post
title: New Course - Refactoring to SOLID C# Code
date: 2023-11-17T11:04:10.000Z
description: "I'm thrilled to announce the release of my latest Pluralsight course, **Refactoring to SOLID C# Code**. This course is designed for software developers, architects, and anyone interested in enhancing their coding skills, especially in the C# programming language." 
path: blog-post
featuredpost: false
featuredimage: /img/new-course-refactoring-solid-csharp-code.png
tags:
  - training
  - csharp
  - solid
  - refactoring
  - pluralsight
  - course
  - legacy code
  - quality
category:
  - Software Development
comments: true
share: true
---

I'm thrilled to announce the release of my latest Pluralsight course, [**Refactoring to SOLID C# Code**](https://app.pluralsight.com/library/courses/refactoring-solid-c-sharp-code). This course is designed for software developers, architects, and anyone interested in enhancing their coding skills, especially in the C# programming language.

## Description

Legacy code is often difficult to maintain and extend. In this course, Refactoring to SOLID C# Code, you’ll learn to apply refactoring techniques guided by SOLID principles. First, you’ll explore a small application that wasn’t written to follow SOLID. Next, you’ll discover ways to improve the design using specific techniques. Finally, you’ll learn how to assess and test the resulting code. When you finish this course, you’ll have the skills and knowledge of refactoring and OO design principles needed to improve and maintain legacy .NET applications.

## Course Overview

- Assessing Legacy Code
- Refactoring Legacy Code to Follow SRP
- Refactoring Legacy Code to Follow DIP and ISP
- Refactoring Legacy Code to Follow OCP and LSP
- Assessing and Testing SOLID Code

## Course Details

This course begins by introducing you to a real-world inspired legacy application whose core service revolves around price calculation. The prices include multiple levels of markup logic as well as a variety of parts and components with interdependencies and different mechanisms for calculating their prices. The application is written in C# and uses .NET 7 to start. Just reading and understanding the code is a challenge because of the overall lack of structure, duplication, and mixing of concerns, which is often present in legacy code.

After a quick tour of the sample we assess the code and identify problems we would like to address. We consider the effort, risk, and value of these mitigations and talk about how an organization might prioritize such efforts.

Then we dive into the fixes themselves. While keeping the SOLID principles in mind, we modify the system to improve its design while keeping it behavior unchanged. We leverage characterization tests to ensure we're not breaking existing functionality, and we move in a step-by-step manner with frequent check-ins to ensure we don't get lost or have to deal with too many changes at once.

In the final module, we consider the improved (but certainly not perfect) codebase, and assess our progress. We leverage static code analysis metrics to help demonstrate exactly how the code has changed as a result of our efforts. We also discuss the next steps we might take to further improve the codebase.

## Summary

This course took me a while longer than I'd originally expected. It ended up being about 6 weeks overdue, largely because the original sample ended up being much more complex than I'd anticipated. I had to simplify it quite a bit to make it manageable for a course, while still being complex enough to present some "real world" challenges with navigating and understanding the code. I'm happy with the end result, though, and I hope you find it useful. Leave a comment below and of course I always welcome shares on your social media platform of choise. Thanks for reading!