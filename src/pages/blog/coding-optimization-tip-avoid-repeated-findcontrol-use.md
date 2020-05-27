---
templateKey: blog-post
title: "Coding Optimization Tip: Avoid Repeated FindControl() Use"
path: blog-post
date: 2007-01-27T17:17:31.247Z
description: In a project I’m working on I have a [recursive FindControl() which
  is quite useful for finding controls that are hiding inside of templates like
  LoginView or CreateUserWizard].
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - tips
  - optimization
  - c#
  - .NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

In a project I’m working on I have a [recursive FindControl() which is quite useful for finding controls that are hiding inside of templates like LoginView or CreateUserWizard](http://ardalis.com/blogs/ssmith/archive/2006/08/23/Add-Profile-Items-in-CreateUserWizard-and-Recursive-FindControl.aspx). I’m working with some junior developers and trying to instill best practices into them. This is an example of a code optimization technique I’m applying today to some code one of them wrote.

Problem Code:

<!--EndFragment-->

```
if ((Common.FindControl(LoginView3, "NotesTextBox")) != null) 
{ 
advertiser.InternalNotes = ((TextBox)Common.FindControl(LoginView3, "NotesTextBox")).Text; 
} 
```

<!--StartFragment-->

The big problem with this code is that it’s using the expensive operation FindControl twice whenever the control isn’t null (which in this case will not be uncommon). The simple refactoring if this is only occurring once on the page is next.

Better Code:

<!--EndFragment-->

```
TextBox NotesTextBox = Common.FindControl(LoginView3, "NotesTextBox") as TextBox; 
if (NotesTextBox != null) 
{ 
advertiser.InternalNotes = NotesTextBox.Text; 
} 
```

<!--StartFragment-->

This eliminates the redundant call to FindControl(). However, if there are many such references on the page, it can be improved further by adding a property to the page.

Best Code:

<!--EndFragment-->

```
private TextBox _notesTextBox = null; 
private TextBox NotesTextBox 
{ 
get 
{ 
if (_notesTextBox == null) 
{ 
_notesTextBox = Common.FindControl(LoginView3, "NotesTextBox") as TextBox; 
} 
return _notesTextBox ; 
} 
}
```

<!--StartFragment-->

. . . . . . . . .

advertiser.InternalNotes = NotesTextBox.Text;

Now anywhere on the page, NotesTextBox can be referenced and it’s certain to not be null (unless it’s not where it’s expected – if that case can happen, handle it in the property get) and better still, the FindControl() will only be called once, guaranteed. Better yet, the code to access the control is 1 line of code instead of 3.

If the control only exists under certain conditions, such as for a LoginView configured to show different content to different Roles, wrap the access to the control in an if statement that tests the user's role, like so:

<!--EndFragment-->

```
if (this.User.IsInRole("Administrators")
if (this.User.IsInRole("Administrators")
```

<!--StartFragment-->

\[categories: tips;optimization]

Tags: [tips](http://technorati.com/tag/tips), [optimization](http://technorati.com/tag/optimization), [c#](http://technorati.com/tag/c#), [.NET](http://technorati.com/tag/.NET)

<!--EndFragment-->