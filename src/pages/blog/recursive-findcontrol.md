---
templateKey: blog-post
title: Recursive FindControl
path: blog-post
date: 2008-09-21T16:17:00.000Z
description: I’ve been asking for a recursive FindControl() method as a method
  off of System.Web.UI.Control for years but so far no luck. You find yourself
  needing these frequently when you work with composite controls, like most of
  the Login family of controls introduced with ASP.NET 2.0. In particular,
  LoginView, CreateUserWizard, and Login frequently require a technique like
  this to access their contents.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
I’ve been asking for a recursive FindControl() method as a method off of System.Web.UI.Control for years but so far no luck. You find yourself needing these frequently when you work with composite controls, like most of the Login family of controls introduced with ASP.NET 2.0. In particular, LoginView, CreateUserWizard, and Login frequently require a technique like this to access their contents.

I[posted a simple version a while back](http://aspadvice.com/blogs/ssmith/archive/2006/08/23/Add-Profile-Items-in-CreateUserWizard-and-Recursive-FindControl.aspx);[Michael Palermo updated it](http://weblogs.asp.net/palermo4/archive/2007/04/13/recursive-findcontrol-t.aspx), and [Aaron Robson posted a nice generic version on IntrepidNoodle.com](http://intrepidnoodle.com/articles/24.aspx). However, his site is often incredibly slow or non-responsive (perhaps he should switch to [ORCSWeb](http://orcsweb.com/)), so while I’m happy to give him full credit, I’m going to mirror the content here so that I have access to it when I need it.

Of course, this can also be done as an Extension Method, which I’ll show at the bottom of this post.

```
<span style="color: rgb(0, 128, 0);">// Source: http://intrepidnoodle.com/articles/24.aspx</span>
<span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">static</span> <span style="color: rgb(0, 0, 255);">class</span> ControlFinder
{
    <span style="color: rgb(0, 128, 0);">/// &lt;summary&gt;</span>
    <span style="color: rgb(0, 128, 0);">/// Similar to Control.FindControl, but recurses through child controls.</span>
    <span style="color: rgb(0, 128, 0);">/// &lt;/summary&gt;</span>
    <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">static</span> T FindControl&lt;T&gt;(Control startingControl, <span style="color: rgb(0, 0, 255);">string</span> id) <span style="color: rgb(0, 0, 255);">where</span> T : Control
    {        
        T found = startingControl.FindControl(id) <span style="color: rgb(0, 0, 255);">as</span> T; 
 
        <span style="color: rgb(0, 0, 255);">if</span> (found == <span style="color: rgb(0, 0, 255);">null</span>)
        {
            found = FindChildControl&lt;T&gt;(startingControl, id);
        }
 
        <span style="color: rgb(0, 0, 255);">return</span> found;        
    }
 
    <span style="color: rgb(0, 128, 0);">/// &lt;summary&gt;     </span>
    <span style="color: rgb(0, 128, 0);">/// Similar to Control.FindControl, but recurses through child controls.</span>
    <span style="color: rgb(0, 128, 0);">/// Assumes that startingControl is NOT the control you are searching for.</span>
    <span style="color: rgb(0, 128, 0);">/// &lt;/summary&gt;</span>
    <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">static</span> T FindChildControl&lt;T&gt;(Control startingControl, <span style="color: rgb(0, 0, 255);">string</span> id) <span style="color: rgb(0, 0, 255);">where</span> T : Control
    {
        T found = <span style="color: rgb(0, 0, 255);">null</span>;
 
        <span style="color: rgb(0, 0, 255);">foreach</span> (Control activeControl <span style="color: rgb(0, 0, 255);">in</span> startingControl.Controls)
        {
            found = activeControl <span style="color: rgb(0, 0, 255);">as</span> T;
 
            <span style="color: rgb(0, 0, 255);">if</span> (found == <span style="color: rgb(0, 0, 255);">null</span> || (<span style="color: rgb(0, 0, 255);">string</span>.Compare(id, found.ID, <span style="color: rgb(0, 0, 255);">true</span>) != 0))
            {
                found = FindChildControl&lt;T&gt;(activeControl, id);
            }
 
            <span style="color: rgb(0, 0, 255);">if</span> (found != <span style="color: rgb(0, 0, 255);">null</span>)
            {
                <span style="color: rgb(0, 0, 255);">break</span>;
            }
        }
 
        <span style="color: rgb(0, 0, 255);">return</span> found;
    }
}
```

With this in place, you can easily access it from your Page by using a [Base Page Class](http://aspadvice.com/blogs/ssmith/archive/2006/09/14/Ultimate-ASP.NET-Base-Page-Class.aspx) and adding these methods to it:

```
<span style="color: rgb(0, 128, 0);">// Source: http://intrepidnoodle.com/articles/24.aspx</span>
<span style="color: rgb(0, 0, 255);">public</span> T FindControl&lt;T&gt;(<span style="color: rgb(0, 0, 255);">string</span> id) <span style="color: rgb(0, 0, 255);">where</span> T : Control
    {
        <span style="color: rgb(0, 128, 0);">// We know the control we're searching for isn't the Page itself,</span>
    <span style="color: rgb(0, 128, 0);">// so we use the more performant FindChildControl to search.</span>
    <span style="color: rgb(0, 0, 255);">return</span> FindChildControl&lt;T&gt;(Page, id);    
    }
 
    <span style="color: rgb(0, 0, 255);">public</span> T FindControl&lt;T&gt;(Control startingControl, <span style="color: rgb(0, 0, 255);">string</span> id) <span style="color: rgb(0, 0, 255);">where</span> T : Control
    {
        <span style="color: rgb(0, 0, 255);">return</span> ControlFinder.FindControl&lt;T&gt;(startingControl, id);    
    }
 
    <span style="color: rgb(0, 0, 255);">public</span> T FindChildControl&lt;T&gt;(Control startingControl, <span style="color: rgb(0, 0, 255);">string</span> id) <span style="color: rgb(0, 0, 255);">where</span> T : Control
    {
        <span style="color: rgb(0, 0, 255);">return</span> ControlFinder.FindChildControl&lt;T&gt;(startingControl, id);
    }
```

\
The next logical step is to just make this an extension method. [Brendan Enrick has already done this work for us](http://aspadvice.com/blogs/name/archive/2008/03/31/Creating-a-Recursive-FindControl-Extension-Method.aspx), so I’ll let you read his post to see how it’s done.

**Update 23 Sep 2008 in response to Howdy Doody’s comment**

Apologies – I left out how (and perhaps more importantly, why) you would use this. We’ll start with the why, which is that you have some some code that nests controls within controls. For example, the Login control has a Password textbox inside of it (whether you template it or not). If you want to get to this control to manipulate it, you can’t just drop into Page_Load and say Password.Text = "foo". Password is not defined at Page scope – it’s only defined within the control tree of the Login control. This can be a problem with any arbitrary control of your own if you use LoginView or MultiView controls as well. For instance, this LoginView:

<asp:LoginView runat="server" id="LoginView1">

<RoleGroups>

<asp:RoleGroup Roles="Administrators">

<ContentTemplate>

<asp:Label runat="server" id="**AdminMessageLabel**" />

</ContentTemplate>

<asp:/RoleGroup>

</asp:LoginView>

If you want to set the contents of the AdminMessageLabel in Page_Load, you would not easily be able to do so. However, you can get a reference to it like so, using a recursive FindControl<T> method, which in this case we’ll assume is defined either in the page itself or in a common Base Page Class (recommended).

Label AdminMessageLabel =**this.FindControl<Label>(LoginView1, "AdminMessageLabel");**

if(AdminMessageLabel != null)

{

AdminMessageLabel.Text = "You are an admin.";

}

Note that when the user is **not** an administrator, you won’t have this control, so you need to check for null. You also could pass in the Page as the starting position for the search for the control, but that would be much less efficient, and since we know it’s in the LoginView1 control’s collection of controls, we pass that for efficiency’s sake.

Hope that helps – note that this last part was written via a web browser with no compiler access, so apologies in advance for any typos.