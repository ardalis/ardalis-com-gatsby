---
templateKey: blog-post
title: How to Start Multiple Projects in Visual Studio
path: blog-post
date: 2017-02-25T03:36:00.000Z
description: >
  If you have multiple projects that need to interact with one another, you can
  configure Visual Studio to launch multiple projects whenever you press
  F5/ctrl+F5. To do so, right-click on the solution and go to Properties:
featuredpost: false
featuredimage: /img/vslogo-760x360.png
tags:
  - visual studio
category:
  - Software Development
comments: true
share: true
---
If you have multiple projects that need to interact with one another, you can configure Visual Studio to launch multiple projects whenever you press F5/ctrl+F5. To do so, right-click on the solution and go to Properties:

![](/img/visual-studio-multiple-startup-projects.png)

By default the solution will typically be set to a Single startup project, such as if you were to right-click on a project and choose “Set as Startup Project”. However, from here you can choose the Mutliple startup projects radio button and then choose the action for each project. In the above diagram, I have a messaging demo that includes a producer service and two consumer services. When I launch the solution, all three services kick off at the same time.