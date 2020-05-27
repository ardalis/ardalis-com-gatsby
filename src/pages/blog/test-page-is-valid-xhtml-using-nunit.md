---
templateKey: blog-post
title: Test Page is Valid XHTML using NUnit
path: blog-post
date: 2005-12-09T13:58:57.620Z
description: "I’m wrapping up some tests of AspAlliance Cache Manager (no URL
  yet) and wanted to ensure that my output was valid XHTML. So I did some
  googling and found [this thread] which led me to create this technique in my
  unit test:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - C#
  - Test Driven Development
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

<http://www.artima.com/forums/flat.jsp?forum=152&thread=82646> I’m wrapping up some tests of AspAlliance Cache Manager (no URL yet) and wanted to ensure that my output was valid XHTML. So I did some googling and found [this thread](http://www.dotnet247.com/247reference/msgs/57/288422.aspx) which led me to create this technique in my unit test:

```
private bool IsUrlValidXhtml(string url)

{

System.Xml.XmlTextReader reader = new System.Xml.XmlTextReader(url);

reader.Normalization = true;

Xhtml11Resolver resolver = new Xhtml11Resolver();

reader.XmlResolver = resolver;

XmlValidatingReader valReader = new XmlValidatingReader(reader);

valReader.ValidationEventHandler+= new System.Xml.Schema.ValidationEventHandler(valReader_ValidationEventHandler);

valReader.ValidationType = System.Xml.ValidationType.DTD;

errorCount = 0;

while(valReader.Read())

{}

valReader.Close();

if(errorCount > 0)

{

return false;

}

else

{

return true;

}
```



I copied this class from the thread above:

```
public class Xhtml11Resolver:XmlUrlResolver

{

public override Uri ResolveUri(Uri baseUri, string relativeUri)

{

if (relativeUri.StartsWith(“xhtml11”))

{

baseUri=new Uri(“http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd”);

}

Uri resolved=base.ResolveUri(baseUri,relativeUri);

return resolved;

}

}
```

I declare a class level variable int errorCount and define the delegate for the validator like so:

```
private void valReader_ValidationEventHandler(object sender, System.Xml.Schema.ValidationEventArgs e)

{

Console.WriteLine(“Validation Error: ” + e.Severity + “, ” + e.Message);

errorCount += 1;

}
```

Finally, here is a test:

```
[Test]

public void TestCacheManagerHomePageXHTML()

{

currentUrl = baseUrl + “CacheManager.axd”;

NUnit.Framework.Assert.IsTrue(IsUrlValidXhtml(currentUrl), currentUrl + ” is not valid XHTML.”);

}
```

I also ran across this [post by Scott Hanselman](http://www.artima.com/forums/flat.jsp?forum=152&thread=82646) that I want to revisit when I deploy these tests to my build server:

<http://www.artima.com/forums/flat.jsp?forum=152&thread=82646>

<!--EndFragment-->