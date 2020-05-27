---
templateKey: blog-post
title: Ultimate ASP.NET Base Page Class
path: blog-post
date: 2006-09-15T02:19:49.737Z
description: I'm working on a base page for a new application and it seems like
  this is about the 5th or 6th time I'm building one of these things, so it's
  getting a bit repetitive.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I'm working on a base page for a new application and it seems like this is about the 5th or 6th time I'm building one of these things, so it's getting a bit repetitive. In this case, it's for an ASP.NET 2.0 app, but I have base pages in use in 1.x apps as well, where they are arguably more useful (or at least, lacking built-in master page support, they are more necessary). I'd like to know what app-agnostic features folks are including in the BasePage classes so that I can compile sort of the ultimate base page class (perhaps I'll call it UltimateBasePage) which inherits from and extends System.Web.UI.Page and the features of which are generally useful in most applications. Probably we'll want a 1.x and a 2.0 version.

By way of example, a useful BasePage property is the RunTimeMasterPageFile, a tip from Dan Wahlin in the [MVP ASP.NET 2.0 Hacks](http://www.amazon.com/ASP-NET-2-0-Hacks-David-Yack/dp/0764597663) book (and also from [ScottGu](http://weblogs.asp.net/scottgu/archive/2005/11/11/430382.aspx) I just discovered). Basically the property allows nested master page using pages to still benefit from Design mode in VS 2005 (though they don't get WYSIWYG master page support). The code for this is

```
private string runtimeMasterPageFile;

public string RuntimeMasterPageFile {

get{

return runtimeMasterPageFile;

}

set{

runtimeMasterPageFile = value;

}

}

protected override void OnPreInit(EventArgs e) {

if (runtimeMasterPageFile != null) {

this.MasterPageFile = runtimeMasterPageFile;

}

base.OnPreInit(e);

}
```



Another example property would be PrintView, as Robert B writes about [here](http://aspalliance.com/63_BasePageandUserControlClasses). The code for this might look like:

<!--EndFragment-->

```
<font><font><font color="lightgrey"><font color="black">  //Example variable that can be set for all pages to access<br />  private bool bPrintView = false;<br /><br />  public bool PrintableView<br />  {<br />    get<br />    {<br />      return bPrintView;<br />    }<br />  }<br /><br />  override protected void OnInit(EventArgs e)<br />  {<br />    //Always call the base method when override<br />    // so what it originally did can still happen<br />    base.OnInit(e);<br /><br />    //Example that just reads a querystring that<br />    // should be supported for all pages<br />    if (null != Request.QueryString[&quot;Print&quot;])<br />    {<br />      //Use try/catch in case value is not a boolean<br />      try<br />      {<br />        bPrintView = Convert.ToBoolean(Request.QueryString[&quot;Print&quot;]);<br />      }<br />      catch<br />      {<br />        //Do nothing, just leave as false<br />      }<br />    }<br />  }</font></font></font></font>
While scouring the Internet for useful UltimateBasePage additions, I also found one example of what NOT to do, <a href="http://www.codeguru.com/csharp/.net/net_asp/webforms/article.php/c11939">here</a>.<br />Do not, for the love of scalability, ever, open up a connection in every one of your pages in Init and then (hopefully) close it in Unload().  Bad Bad Bad.
<a href="http://www.gridviewguy.com/ArticleDetails.aspx?articleID=156">GridViewGuy has some nice suggestions</a>, but they don&#39;t quite seem general enough to include in UltimateBasePage.
Another fairly common 1.x inclusion in the BasePage class was a ConnectionString property, but in 2.0 this is less necessary given the full support<br />for Connection Strings in System.Configuration, and also because DataSourceControls make it less necessary to write data binding code <br />(which should be done in a Data Access Layer anyway). <br />
```

A useful diagnostic method to consider including is a ViewState trace, found [here](http://www.webreference.com/programming/asp/viewstate/3.html). Looks like this:

```
protected override void OnPreRender(EventArgs e)<br />    {<br />      object ViewState = HttpContext.Current.Request[&quot;__VIEWSTATE&quot;];<br />      if(ViewState == null)<br />      {<br />        HttpContext.Current.Trace.Warn(&quot;ViewState Size&quot;, &quot;0&quot;);<br />      }<br />      else<br />      {<br />        HttpContext.Current.Trace.Warn(&quot;ViewState Size&quot;, <br />          HttpContext.Current.Request[&quot;__VIEWSTATE&quot;].Length.ToString());<br />      }<br />      base.OnPreRender(e);<br />    }
```

<!--StartFragment-->

One last thing that might be worth adding to UltimateBasePage would be Google Analytics support, like [Tim Haines describes](http://ims.co.nz/blog/archive/2006/04/07/1666.aspx):

<!--EndFragment-->

```
protected override void Render(HtmlTextWrite
r writer )
{
StringWriter stringWriter = new StringWriter();
HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);
base.Render(htmlWriter);
string html = stringWriter.ToString();
if (Global.GoogleAnalyticsAccountNumber != "")
{
string GoogleAnalyticsScript =
String.Format(ResourceManager.GetResource("GoogleAnalyticsScript"),
Global.GoogleAnalyticsAccountNumber);
int BodyCloseTagStart = html.IndexOf("</body>") -1;
if( BodyCloseTagStart >=0)
{
html = html.Insert(BodyCloseTagStart, GoogleAnalyticsScript);
}
}
writer.Write(html);
}
```