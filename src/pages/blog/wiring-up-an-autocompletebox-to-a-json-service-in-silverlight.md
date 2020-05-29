---
templateKey: blog-post
title: Wiring up an AutoCompleteBox to a JSON Service in Silverlight
path: blog-post
date: 2011-09-23T05:33:00.000Z
description: "I’m currently building an internal application for The Code
  Project that needs to be able to transfer the contents of some potentially
  very large files over the wire. "
featuredpost: false
featuredimage: /img/silverlight.png
tags:
  - html
  - javascript
  - silverlight
category:
  - Software Development
comments: true
share: true
---
I’m currently building an internal application for [The Code Project](http://codeproject.com) that needs to be able to transfer the contents of some potentially very large files over the wire. After considering various ways to get the data from point A to point B, we decided the easiest thing would be to process the text file on the client, and send batches of rows up to the server for processing. Initially we looked at building a WPF client for this, but then switched over to Silverlight 4 since the rest of the application is web-based and we didn’t want staff to have to worry about a separate standalone application.

Basically the files get translated into simple lists on the server, so the UI simply consists of “Enter/choose a list” and a drag-and-drop file uploader. The list selection UI needs to support both selection from existing lists, or creation of new lists. To that end, I did some searching for an AutoCompleteTextBox in Silverlight, and found [Jeff Wilcox’s article on Introducing the AutoCompleteBox](http://www.jeff.wilcox.name/2008/10/introducing-autocompletebox). Of course, it doesn’t show how to wire up the contents to a JSON call, so another search yielded [Tim Heuer’s article on Making Use of JSON data in Silverlight](http://timheuer.com/blog/archive/2008/05/06/use-json-data-in-silverlight.aspx). Putting them together, you get something that works quite well for what I need.

Here’s my XAML for the AutoCompleteBox:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">sdk:AutoCompleteBox</span> <span style="color: #ff0000">Height</span><span style="color: #0000ff">="20"</span> <span style="color: #ff0000">HorizontalAlignment</span><span style="color: #0000ff">="Left"</span>
<span style="color: #ff0000">Margin</span><span style="color: #0000ff">="12,0,0,0"</span>
<span style="color: #ff0000">Name</span><span style="color: #0000ff">="autoCompleteBox1"</span> <span style="color: #ff0000">VerticalAlignment</span><span style="color: #0000ff">="Top"</span>
<span style="color: #ff0000">Width</span><span style="color: #0000ff">="376"</span> <span style="color: #ff0000">Grid</span>.<span style="color: #ff0000">Row</span><span style="color: #0000ff">="1"</span>
<span style="color: #ff0000">ValueMemberBinding</span><span style="color: #0000ff">="{Binding Name}"</span> <span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">sdk:AutoCompleteBox.ItemTemplate</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">DataTemplate</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">TextBlock</span> <span style="color: #ff0000">Text</span><span style="color: #0000ff">="{Binding Name}"</span><span style="color: #0000ff">&gt;&lt;/</span><span style="color: #800000">TextBlock</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">DataTemplate</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">sdk:AutoCompleteBox.ItemTemplate</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">sdk:AutoCompleteBox</span><span style="color: #0000ff">&gt;</span>
```



Note: I’m not a Silverlight expert, so if I’m doing things against best practices, I apologize. It does, however, work for me as shown. I wired up the loading of the AutoCompleteBox in my form’s load, since it’s the only thing this page does so I saw no point in doing it lazily when the AutoCompleteBox is used. I simply added Loaded=”UserControl_Loaded” to my root UserControl element for this.

Then in the MainPage.xaml.cs, I implemented this Loaded handler like so:



```
<span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> UserControl_Loaded(<span style="color: #0000ff">object</span> sender, RoutedEventArgs e)
   {
   WebClient proxy = <span style="color: #0000ff">new</span> WebClient();
   
   
```

All that remains is to implement a controller in the ASP.NET MVC application that this Silverlight control will live in (and make sure it has the clientaccesspolicy.xml and crossdomain.xml files, if needed). The controller action needs to[AllowGet with its JsonResult](/set-jsonrequestbehavior-to-allowget), too. Here’s basically what it looks like:

```
 <span style="color: #008000">// _repository is provided via the Controller constructor and IOC</span>
 <span style="color: #0000ff">return</span> Json(_repository.ListReadOnly(), JsonRequestBehavior.AllowGet);
}
```

Here’s the result in action: