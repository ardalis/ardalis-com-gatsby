---
title: Display Current Bin Folder Content Information
date: "2007-04-10T10:34:42.3900000-04:00"
description: As part of my automated build and test process, I wanted to be able
featuredImage: img/display-current-bin-folder-content-information-featured.png
---

As part of my automated build and test process, I wanted to be able to confirm that my third party components were the proper version and, more importantly, that they were fully licensed. For some components, I can create a new instance of the control or component and test its IsLicensed property. For others, the assembly itself is different for evaluation versus professional versions, and another approach is required. In the first case, the code required to test if the control is licensed is trivial – the second case requires slightly more work.

These assemblies live in the /bin folder of my ASP.NET application. The best way to determine whether or not the assembly in question is an evaluation copy or not, for this particular vendor, is to test the AssemblyDescription attribute to see if it contains the string "Evaluation". To do this, I need to get a reference to the assembly in my application's /bin folder. In my case, I'm doing all of this on a web page that I can then bring up in test or production and see the licensing status and versions of all of the third party assemblies and controls I'm using. I can also scrape this page using a web test and [Plasma](http://codeplex.com/plasma) to ensure that things are configured correctly as part of my automated build process.

To set the status label on my page, I have some code like this:


```
ChartLabel.Text = IsLicensed(Server.MapPath("~/bin/Chart.dll")).ToString();
```


The CheckValid function looks like this, then:


```
private bool IsLicensed(string assemblyPath)
{
bool isLicensed = false;
Assembly assembly = Assembly.LoadFile(assemblyPath);
AssemblyDescriptionAttribute assemblyDescriptionAttribute = null;
foreach(object item in assembly.GetCustomAttributes(false))
{
if(item is AssemblyDescriptionAttribute)
{
assemblyDescriptionAttribute = (AssemblyDescriptionAttribute) item;
break;
}
}
if (assemblyDescriptionAttribute!= null)
{
if (assemblyDescriptionAttribute.Description.Contains("Evaluation"))
{
isLicensed = false;
}
}
return isLicensed;
}
```


Finally, my web test looks something like this:

\[TestMethod]


```
public void CheckDundasLicense()
{
string url ="~/test/Licenses.aspx";
AspNetResponse response = WebApp.ProcessRequest(url);
Assert.AreEqual(200, response.Status,"Page did not return 200 OK." + response.BodyAsString);
HtmlNode navBarLabel = response.FindHtmlElementById("ChartLabel");
Assert.IsTrue(navBarLabel.InnerHtml.Contains("True"),"Chart Not Licensed.");
}
```

