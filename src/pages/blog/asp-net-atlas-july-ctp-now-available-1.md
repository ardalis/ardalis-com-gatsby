---
templateKey: blog-post
title: ASP.NET Atlas July CTP Now Available
path: blog-post
date: 2006-08-01T03:15:11.833Z
description: "You can now download the [July Community Tech Preview of Atlas
  here](http://atlas.asp.net/default.aspx?tabid=47&subtabid=471). Some Details:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Atlas and Ajax
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

You can now download the [July Community Tech Preview of Atlas here](http://atlas.asp.net/default.aspx?tabid=47&subtabid=471). Some Details:

### UpdatePanel and ScriptManager:

* ScriptManager.RegisterControl() takes optional parameter to specify client type to create.
* Fix for UpdatePanels in Firefox.

### Drag and Drop:

* Added public dragStart/dragEnd events to DragDropManager.
* dragStart fires with dragMode, dataType, and data as eventArgs.
* dragStop fires with empty eventArgs.
* style.position of dragVisuals will no longer default to “absolute”.
* DragDropManager do longers disposes dropTargets when unregistering them.
* FloatingBehavior now unregisters itself on dispose.

<!--EndFragment-->