---
templateKey: blog-post
title: Creating an Autocomplete Redirect Navigation Control using jQuery UI
path: blog-post
date: 2011-04-21T20:34:00.000Z
description: On an application I’m working on, there’s was an ASP.NET
  DropDownList used for jumping to a particular account. This, when enhanced
  with the AJAX Control Toolkit’s ListSearchExtender, provided an awesome user
  experience for quickly navigating to a particular account.
featuredpost: false
featuredimage: /img/cloud-native.jpg
tags:
  - jquery
  - jqueryui
category:
  - Software Development
comments: true
share: true
---
On an application I’m working on, there’s was an ASP.NET DropDownList used for jumping to a particular account. This, when enhanced with the AJAX Control Toolkit’s ListSearchExtender, provided an awesome user experience for quickly navigating to a particular account. Just click the control, and either scroll, or better, type in the first few characters of the name of the account, and it was instantly selected. Tab or enter from there, and you’re done.

Unfortunately, as often happens, the applicability of this solution to application has changed with time. Where once the DropDownList had one or two hundred records, now it has thousands, and unfortunately its existing behavior relied on ViewState, so the total size of the page and time required to perform a postback grew in proportion to the number of accounts. Eventually, enough was enough. But for many years, this solution worked quite well, and actually required 0 client-side code to implement (here’s the code in question, minus the server-side databinding):

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:DropDownList</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">=&quot;AcctDropDownList&quot;</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">=&quot;server&quot;</span> 
<span style="color: #ff0000">OnSelectedIndexChanged</span><span style="color: #0000ff">=&quot;AcctDropDownList_SelectedIndexChanged&quot;</span>
<span style="color: #ff0000">AutoPostBack</span><span style="color: #0000ff">=&quot;true&quot;</span> <span style="color: #0000ff">/&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">AjaxControlToolkit:ListSearchExtender</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">=&quot;AcctListSearchExtender&quot;</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">=&quot;server&quot;</span>
<span style="color: #ff0000">PromptText</span><span style="color: #0000ff">=&quot;search&quot;</span> <span style="color: #ff0000">PromptPosition</span><span style="color: #0000ff">=&quot;Top&quot;</span> <span style="color: #ff0000">TargetControlID</span><span style="color: #0000ff">=&quot;AcctDropDownList&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">AjaxControlToolkit:Li
```

**Creating an AutoComplete Solution using jQuery UI**

I quickly decided that a DropDownList as a navigation element was simply no longer suited to the amount of data that the application now had to contend with. This is a fairly common issue with applications, and the next logical UI pattern to apply typically is to replace the DropDownList with a simple textbox and provide some kind of search functionality. Implementations can vary, but to me the most elegant way to do this is to build the search right into the textbox, and using [jQuery UI’s AutoComplete](http://jqueryui.com/demos/autocomplete) this is pretty easy to accomplish.

I found [this article helpful in getting me started with my autocompleting textbox](http://www.dotnetcurry.com/ShowArticle.aspx?ID=515). However, it didn’t quite go far enough, in that it left out how to redirect the user based on the selected result. Here’s the code I came up with based on that article. First, the <head> section scripts and includes:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Creating-an-Autocomplete_E4DA/image_2.png)

Then, the textbox itself:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">body</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">form</span> <span style="color: #ff0000">id</span><span style="color: #0000ff">=&quot;form1&quot;</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">=&quot;server&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">div</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">=&quot;demo&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">div</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">=&quot;ui-widget&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">label</span> <span style="color: #ff0000">for</span><span style="color: #0000ff">=&quot;tbAuto&quot;</span><span style="color: #0000ff">&gt;</span>
Enter Search Term:
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">label</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:TextBox</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">=&quot;tbAuto&quot;</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">=&quot;tb&quot;</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">=&quot;server&quot;</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">asp:TextBox</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">form</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">body</span><span style="color: #0000ff">&gt;</span>
```

This works, and will give you output like this:

![image](<> "image")

**Creating a jQuery AutoComplete Redirect**

This is all well and good that you can populate a textbox from an ajax call, but what I really wanted was to then be able to redirect the user based on their pick. And I didn’t want to redirect to a page that included the text of their selection – rather I wanted to use the ID of the account they had chosen and construct a URL with this ID in the querystring. Looking into this further, I found that the [AutoComplete control supports an event called select](http://jqueryui.com/demos/autocomplete/#event-select), which fires when the user makes a selection:

![image](<> "image")

Great – so I added one of these to my code above. The only trick was, I couldn’t immediately figure out the type of the ui parameter. Trying to alert(ui) just told me it was an object, and I struggled a bit to see its properties, etc. However, eventually I figured out that it’s whatever is returned from the success: event on the .autocomplete() call. In the code above you can see that I’m returning a type that has properties for value and id (before I figured this out it only had value). You can return whatever you want from the success: function and you’ll have these properties available in the select: function. Here’s my completed script block, which performs a redirect to **/Admin/Account.aspx?id=(selected id)**.

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Creating-an-Autocomplete_E4DA/image_16.png)

**What about the Service?**

Of course, to make this work, there needs to be a service on the web server, too. I’ve had a habit of using .asmx web services for most of my web service needs, but I decided to get with the times and use a WCF service in this case, and it was quite painless to do so. I started out with AJAX-enabled WCF Service item template from Add New Item:

![SNAGHTML572355b](<> "SNAGHTML572355b")

**Note that when you add one of these, it will edit your web.config file.** I didn’t immediately realize this, and since my dev web.config doesn’t get deployed to production, I had to track this down before I could deploy this solution. Look for a section like this:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Creating-an-Autocomplete_E4DA/image_18.png)

Be sure to copy that block into your production configuration.

Finally, implementing the service was pretty straightforward. I already have a larger domain object to represent an account, but I only wanted to send an ID + Name over the wire, so I created an AccountDTO (data transfer object) class for this purpose. Here’s the code, stripped of error handling and some other details.

```
[ServiceContract(Namespace = <span style="color: #006080">&quot;&quot;</span>)]
[ServiceBehavior(IncludeExceptionDetailInFaults = <span style="color: #0000ff">true</span>)]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> AccountService
{
 [OperationContract]
<span style="color: #0000ff">public</span> List&lt;AccountDTO&gt; ListMatches(<span style="color: #0000ff">string</span> searchTerm)
 {

var repo = IoC.Resolve&lt;IAccountRepository&gt;();
var result = repo.ListByNameOrId(searchTerm).Select(FromAccount).ToList();
<span style="color: #0000ff">return</span> result;

}

&#160;
<span style="color: #0000ff">private</span> AdvertiserDTO FromAccount(Account account)

{
<span style="color: #0000ff">return</span> <span style="color: #0000ff">new</span> AccountDTO() {Id = account.Id, Name = account.Name};

}

}
&#160;

[Serializable]

<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> AccountDTO
{
<span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> Id;
<span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Name;
}
```

Note: if you’re doing a lot of mapping of objects between DTOs, Entities, and/or domain objects, check out [AutoMapper](http://automapper.codeplex.com/).

**Summary**

Once the total number of rows grows beyond a few hundred, a DropDownList becomes less and less well-suited as a user interface control for selecting a particular piece of data. This is compounded if the application is relying on postbacks and server-side processing in order to accomplish navigation using such a DropDownList. Using jQuery, and specifically the jQuery UI AutoComplete plugin, it’s easy to create a navigational element that allows the user to perform a quick search and jump-to account within your application. Binding such a textbox to a service within the ASP.NET application is very simple to get started with, too, and there’s no need to drop down to the raw JSON or XML level while doing so.