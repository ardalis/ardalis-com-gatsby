---
templateKey: blog-post
title: Render Control as String
path: blog-post
date: 2008-08-28T02:50:00.000Z
description: When working with AJAX and Web Services it’s often nice to be able
  to render ASP.NET controls as strings, so the rendered HTML can be sent back
  to the client to replace the contents of a <div> or something like that. The
  standard way of achieving this is to use the RenderControl() method, exposed
  by all ASP.NET controls.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - RenderControl
category:
  - Uncategorized
comments: true
share: true
---
When working with AJAX and Web Services it’s often nice to be able to render ASP.NET controls as strings, so the rendered HTML can be sent back to the client to replace the contents of a <div> or something like that. The standard way of achieving this is to use the RenderControl() method, exposed by all ASP.NET controls. Unfortunately, the RenderControl() method doesn’t simply return a string – that would be too easy. Instead, it takes in an **HtmlTextWriter** which it will render the control into. No problem, just new one of those up and… not so fast. You can’t actually create an instance of an HtmlTextWriter without first having a **TextWriter**. And since you really want a string when this is all said and done, a **StringBuilder** would be nice to have as well. So, a few using() statements later, you end up with something like this as the basic pattern:

```
StringBuilder sb = <span style="color: #0000ff">new</span> StringBuilder();
<span style="color: #0000ff">using</span> (StringWriter sw = <span style="color: #0000ff">new</span> StringWriter(sb))
{
    <span style="color: #0000ff">using</span> (HtmlTextWriter textWriter = <span style="color: #0000ff">new</span> HtmlTextWriter(sw))
    {
        myControl.RenderControl(textWriter);
    }
}
<span style="color: #0000ff">return</span> sb.ToString();
```

You can take this technique and apply it to a real control in a web method like this example, that renders a Panel with two Label controls in it.

```
[WebMethod]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> GetPanel()
{
    Panel myPanel = <span style="color: #0000ff">new</span> Panel();
    Label myLabel1 = <span style="color: #0000ff">new</span> Label();
    myLabel1.Text = <span style="color: #006080">"First Label"</span>;
    Label myLabel2 = <span style="color: #0000ff">new</span> Label();
    myLabel2.Text = <span style="color: #006080">"Second Label"</span>;
    myPanel.Controls.Add(myLabel1);
    myPanel.Controls.Add(myLabel2);
 
    StringBuilder sb = <span style="color: #0000ff">new</span> StringBuilder();
    <span style="color: #0000ff">using</span> (StringWriter sw = <span style="color: #0000ff">new</span> StringWriter(sb))
    {
        <span style="color: #0000ff">using</span> (HtmlTextWriter textWriter = <span style="color: #0000ff">new</span> HtmlTextWriter(sw))
        {
            myPanel.RenderControl(textWriter);
        }
    }
    <span style="color: #0000ff">return</span> sb.ToString();
}
```

I have another blog post on [how to render a user control as a string](http://aspadvice.com/blogs/ssmith/archive/2007/10/19/Render-User-Control-as-String-Template.aspx) if that is what you really want to do.

The thing to notice about this code for rendering an ASP.NET control as a string is that it’s rather repetitive and verbose. However, it also is the same for any System.Web.UI.Control, and so it is an excellent candidate for an [extension method](http://en.wikipedia.org/wiki/Extension_method). Add something like this to a namespace that is referenced in your code to create the extension method:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">class</span> ControlExtenders
{
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">string</span> RenderControl(<span style="color: #0000ff">this</span> Control control)
    {
        StringBuilder sb = <span style="color: #0000ff">new</span> StringBuilder();
        <span style="color: #0000ff">using</span> (StringWriter sw = <span style="color: #0000ff">new</span> StringWriter(sb))
        {
            <span style="color: #0000ff">using</span> (HtmlTextWriter textWriter = <span style="color: #0000ff">new</span> HtmlTextWriter(sw))
            {
                control.RenderControl(textWriter);
            }
        }
        <span style="color: #0000ff">return</span> sb.ToString();
    }
}
```

Now the code to render a control becomes simply myControl.RenderControl();. Our GetPanel() web method can be rewritten to use the extension method like so:

```
[WebMethod]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> GetPanel()
{
    Panel myPanel = <span style="color: #0000ff">new</span> Panel();
    Label myLabel1 = <span style="color: #0000ff">new</span> Label();
    myLabel1.Text = <span style="color: #006080">"First Label"</span>;
    Label myLabel2 = <span style="color: #0000ff">new</span> Label();
    myLabel2.Text = <span style="color: #006080">"Second Label"</span>;
    myPanel.Controls.Add(myLabel1);
    myPanel.Controls.Add(myLabel2);
 
    <span style="color: #0000ff">return</span> myPanel.RenderControl(); <span style="color: #008000">// extension method</span>
}
```

I discussed this approach briefly on a recent interview on [Craig Shoemaker’s Polymorphic Podcast](http://polymorphicpodcast.com/). You can listen to the show [here](http://polymorphicpodcast.com/shows/webperformance).

[![kick it on DotNetKicks.com](https://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=http%3a%2f%2fstevesmithblog.com%2fblog%2frender-control-as-string%2f)](http://www.dotnetkicks.com/kick/?url=http%3a%2f%2fstevesmithblog.com%2fblog%2frender-control-as-string%2f)

[Subscribe to Steve’s Blog](http://feeds.stevesmithblog.com/StevenSmith)